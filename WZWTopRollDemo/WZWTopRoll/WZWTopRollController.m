
#import "WZWTopRollController.h"
#import "WZWHeader.h"

@interface WZWTopRollController () <UICollectionViewDataSource,UICollectionViewDelegate>

/** 内容视图(标题滚动视图+内容滚动视图) */
@property (nonatomic,strong) UIView * contentView;

/** 标题滚动视图 */
@property (nonatomic,strong) UIScrollView * titleScrollView;

/** 内容滚动视图 */
@property (nonatomic,strong) UICollectionView * contentCollectionView;

/** 标题间距 */
@property (nonatomic,assign) CGFloat titleMargin;

/** 存储所有标题的宽度 */
@property (nonatomic,strong) NSMutableArray * titleWidths;

/** 存储所有标题label */
@property (nonatomic,strong) NSMutableArray * titleLabels;

/** 根据角标选择对应的控制器 */
@property (nonatomic,assign) NSInteger selectIndex;

/** 记录上一次内容滚动视图的偏移量 */
@property (nonatomic,assign) CGFloat lastOffsetX;

/** 标题下划线view */
@property (nonatomic,strong) UIView * underLine;

/** 是否初始化 */
@property (nonatomic,assign) BOOL isInital;

@end

@implementation WZWTopRollController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //初始化视图
    [self initView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_isInital == NO) {
        _isInital = YES;
        //设置所有标题宽度
        [self setupTitleWidth];
        
        //设置所有标题
        [self setupAllTitle];
    }
}


#pragma mark - 懒加载
-(UIFont *)titleFont{
    if (!_titleFont) {
        _titleFont = WZWTitleFont;
    }
    return _titleFont;
}

-(NSMutableArray *)titleWidths{
    if (!_titleWidths) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

-(NSMutableArray *)titleLabels{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

-(UIView *)underLine{
    if (!_underLine) {
        _underLine = [[UIView alloc]init];
        _underLine.backgroundColor = _underLineColor?_underLineColor:[UIColor redColor];
        [self.titleScrollView addSubview:_underLine];
    }
    return _underLine;
}

#pragma mark - 头部标题设置
//设置标题间距
-(void)setupTitleWidth{
    NSInteger count = self.childViewControllers.count;
    
    NSArray * titles = [self.childViewControllers valueForKeyPath:@"title"];
    CGFloat totalWidth = 0;
    
    //计算标题总高度
    for (NSString * title in titles) {
        CGSize labelSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
        totalWidth += labelSize.width;
        [self.titleWidths addObject:@(labelSize.width)];
    }
    
    if (totalWidth > ScreenW) {
        _titleMargin = WZWMargin;
        return;
    }
    
    CGFloat titleMargin = (ScreenW - totalWidth)/(count +1);
    _titleMargin = titleMargin < WZWMargin?WZWMargin:titleMargin;
}

//添加所有标题
-(void)setupAllTitle{
    
    NSInteger count = self.childViewControllers.count;
    
    //添加标题label
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelW = 0;
    CGFloat labelH = WZWTitleScrollH;
    for (int i=0; i<count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        UILabel * label = [[UILabel alloc]init];
        label.tag = i;
        label.font = self.titleFont;
        label.textColor = [UIColor blackColor];
        label.text = vc.title;
        //设置label位置和大小
        UILabel * lastLabel = [self.titleLabels lastObject];
        labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        labelW = [self.titleWidths[i] floatValue];
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        label.userInteractionEnabled = YES;
        //监听标题的点击
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        [self.titleLabels addObject:label];
        [self.titleScrollView addSubview:label];
        
        if (i == _selectIndex) {
            [self titleClick:tap];
        }
    }
    
    //设置头部标题滚动视图的内容范围
    UILabel * lastLabel = [self.titleLabels lastObject];
    _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;
}

-(void)titleClick:(UITapGestureRecognizer *)tap{
    _selectIndex = tap.view.tag;
    
    //获取点击的label
    UILabel * selectedLabel = (UILabel *)tap.view;
    NSInteger index = tap.view.tag;
    
    //内容视图滚动到对应的位置
    CGFloat offseX = index * ScreenW;
    self.contentCollectionView.contentOffset = CGPointMake(offseX, 0);
    _lastOffsetX = offseX;
    
    //设置选中label的属性
    [self setupSelectedLabel:selectedLabel];
}


#pragma mark - 设置选中标题的属性
-(void)setupSelectedLabel:(UILabel *)label{
    for (UILabel * tempLabel in self.titleLabels) {
        if (tempLabel == label) continue;
        tempLabel.textColor = _norColor?_norColor:[UIColor blackColor];
        tempLabel.transform = CGAffineTransformIdentity;
    }
    //修改选中标题的颜色
    label.textColor = _selColor?_selColor:[UIColor redColor];
    
    //设置标题字体缩放
    if (_isShowTitleScale) {
        CGFloat scaleTransform = _titleScale?_titleScale:WZWTitleTransformScale;
        label.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
    }
    
    //设置标题居中
    [self setupTitleLabelCenter:label];
    
    //设置下标
    [self setupUnderLine:label];
}

//设置下标
-(void)setupUnderLine:(UILabel *)label{
    if (_isShowUnderLine == NO) return;
    //获取label大小
    CGSize labelSize = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
    CGFloat underLineH = _underLineH?_underLineH:WZWUnderLineH;
    
    __block CGRect frame = self.underLine.frame;
    frame.origin.y = label.frame.size.height - underLineH;
    frame.size.height = underLineH;
    self.underLine.frame = frame;
    
    //最开始不需要动画
    if (self.underLine.frame.origin.x == 0) {
        frame.size.width = labelSize.width;
        frame.origin.x = label.frame.origin.x;
        self.underLine.frame = frame;
        return;
    }
    
    //点击的时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        frame.size.width = labelSize.width;
        frame.origin.x = label.frame.origin.x;
        self.underLine.frame = frame;
    }];
}

//设置选中的label居中
-(void)setupTitleLabelCenter:(UILabel *)label{
    //设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - ScreenW * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    //计算最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - ScreenW + _titleMargin;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - 初始化视图
-(void)initView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //设置contentView
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    _contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_contentView];
    
    //设置titleScrollView
    _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavBarH, ScreenW, WZWTitleScrollH)];
    _titleScrollView.backgroundColor = _titleScrollViewColor?_titleScrollViewColor:[UIColor whiteColor];
    [self.contentView addSubview:_titleScrollView];
    
    //设置contentCollectionView
    UICollectionViewFlowLayout * floLayout = [[UICollectionViewFlowLayout alloc]init];
    floLayout.minimumLineSpacing = 0;
    floLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:floLayout];
    _contentCollectionView.pagingEnabled = YES;
    _contentCollectionView.showsHorizontalScrollIndicator = NO;
    _contentCollectionView.bounces = NO;
    _contentCollectionView.delegate = self;
    _contentCollectionView.dataSource = self;
    [_contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellId];
    [self.contentView insertSubview:_contentCollectionView belowSubview:_titleScrollView];
    floLayout.itemSize = self.contentCollectionView.bounds.size;
    
}

#pragma mark - UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    //移除之前的控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //添加控制器
    UIViewController * vc = self.childViewControllers[indexPath.row];
    vc.view.frame = CGRectMake(0, 0, self.contentCollectionView.frame.size.width, self.contentCollectionView.frame.size.height);
    [cell.contentView addSubview:vc.view];
    return cell;
}

#pragma mark - UIScrollView代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    //获取对应的选中的标题
    NSInteger index = offsetX/ScreenW;
    [self setupSelectedLabel:self.titleLabels[index]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //获取左边label
    NSInteger leftIndex = offsetX / ScreenW;
    UILabel * leftLabel = self.titleLabels[leftIndex];
    
    //获取右边label
    NSInteger rightIndex = leftIndex + 1;
    UILabel * rightLabel = nil;
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    //字体缩放
    [self setupTitleScaleWithOffset:offsetX leftLabel:leftLabel rightLabel:rightLabel];
    
    //下标偏移
    [self setupUnderLineWithOffset:offsetX leftLabel:leftLabel rightLabel:rightLabel];
    
    //记录上一次的偏移量
    _lastOffsetX = offsetX;
}

#pragma mark - 设置字体、下标按滚动视图滑动的比例缩放
//字体缩放
-(void)setupTitleScaleWithOffset:(CGFloat)offsetX leftLabel:(UILabel *)leftLabel rightLabel:(UILabel *)rightLabel{
    if (_isShowTitleScale == NO) return;
    //获取右边的缩放
    CGFloat rightScale = offsetX /ScreenW - leftLabel.tag;
    CGFloat leftScale = 1 - rightScale;
    CGFloat scaleTransform = _titleScale?_titleScale:WZWTitleTransformScale;
    scaleTransform -=1;
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * scaleTransform + 1, rightScale * scaleTransform + 1);
}

//下标偏移
-(void)setupUnderLineWithOffset:(CGFloat)offsetX leftLabel:(UILabel *)leftLabel rightLabel:(UILabel *)rightLabe{
    if (_isShowUnderLine == NO) return;
    
    //获取两个标题中心点的距离
    CGFloat centerRange = rightLabe.center.x - leftLabel.center.x;
    //标题宽度差值
    CGSize leftSize = [leftLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
    CGSize rightSize = [rightLabe.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil].size;
    CGFloat widthRange = rightSize.width - leftSize.width;
    //获取移动距离
    CGFloat offsetRange = offsetX - _lastOffsetX;
    //计算当前下划线的偏移量
    CGFloat underLineTransformX = offsetRange * centerRange /ScreenW;
    CGFloat underLineWidth = offsetRange * widthRange / ScreenW;
    
    CGRect frame = self.underLine.frame;
    frame.size.width += underLineWidth;
    frame.origin.x += underLineTransformX;
    self.underLine.frame = frame;
}

@end
