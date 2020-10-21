//
//  YLBScrollNestController.m
//  YLBScrollViewNest
//
//  Created by yulibo on 2020/10/16.
//

#import "YLBScrollNestController.h"
#import "YLBSegmentTitleView.h"
#import "YLBPageContentView.h"
#import "YLBGestureTableView.h"
#import "YLBScrollNestBottomViewTCell.h"
#import <MJRefresh/MJRefresh.h>
#import "YLBScrollContentViewController.h"
#import <YLBCommon/YLBCommon.h>
#import "YLBScrollContentConst.h"
#import "YLBScrollNestTopCell.h"

@interface YLBScrollNestController ()<UITableViewDelegate,UITableViewDataSource,YLBSegmentTitleViewDelegate,YLBPageContentViewDelegate>
@property (nonatomic, strong) YLBGestureTableView *tableView;
@property (nonatomic, strong) YLBScrollNestBottomViewTCell *contentCell;
@property (nonatomic, strong) YLBSegmentTitleView *titleView;

@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, strong) NSArray *titlesArrM;

@end

static NSString * const YLBScrollNestTopCellId = @"YLBScrollNestTopCellId";
static NSString * const YLBLishSaltFishBottomViewTCellId = @"YLBLishSaltFishBottomViewTCellId";

@implementation YLBScrollNestController

- (NSArray *)titlesArrM {
    if (!_titlesArrM) {
        _titlesArrM = @[@"精选", @"女装", @"美妆", @"母婴"];
    }
    return _titlesArrM;
}

- (YLBGestureTableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[YLBGestureTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[YLBScrollNestTopCell class] forCellReuseIdentifier:YLBScrollNestTopCellId];
        //        _tableView.bounces = NO;
        [_tableView stopAdjustmentWithScrollView:_tableView controller:self];
    }
    return _tableView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                       selector:@selector(changeScrollStatus)
                           name:YLBMineLeaveTopNotification
                         object:nil];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(insertRowAtTop)];
    [self.tableView.mj_header beginRefreshing];
}


- (void)configUI {
    
    self.canScroll = YES;
    
    [self.view addSubview:self.tableView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    self.tableView.frame = self.view.bounds;
}


- (void)insertRowAtTop {
    
    self.contentCell.currentTagStr = self.titlesArrM[self.titleView.selectIndex];
    self.contentCell.isRefresh = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //让[刷新控件]结束刷新
      [self.tableView.mj_header endRefreshing];
    });
    
    
}



#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}


#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  indexPath.section == 0 ? 295 : CGRectGetHeight(self.view.bounds);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0.01f : 40.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.titleView = [[YLBSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40) titles:self.titlesArrM delegate:self indicatorType:YLBIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.titleNormalColor = YLBHexColor(0x666666);
    self.titleView.titleSelectColor = YLBHexColor(0xE54B4B);
    self.titleView.indicatorColor = YLBHexColor(0xE54B4B);
    self.titleView.titleFont = [UIFont systemFontOfSize:13];
    return self.titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        _contentCell = [tableView dequeueReusableCellWithIdentifier:YLBLishSaltFishBottomViewTCellId];
        if (!_contentCell) {
            _contentCell = [[YLBScrollNestBottomViewTCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:YLBLishSaltFishBottomViewTCellId];
            NSMutableArray *contentVCs = [NSMutableArray array];
            for (NSString *title in self.titlesArrM) {
                YLBScrollContentViewController *vc = [[YLBScrollContentViewController alloc] initWithCollectionViewFrame:CGRectMake(0, 0, YLB_SCREEN_WIDTH, YLB_SCREEN_HEIGHT - 40)];
                vc.title = title;
                vc.str = title;
                [contentVCs addObject:vc];
            }
            _contentCell.viewControllers = contentVCs;
            _contentCell.pageContentView = [[YLBPageContentView alloc] initWithFrame:CGRectMake(0, 0, YLB_SCREEN_WIDTH, YLB_SCREEN_HEIGHT - 40) childVCs:contentVCs parentVC:self delegate:self];
            [_contentCell.contentView addSubview:_contentCell.pageContentView];
        }
        return _contentCell;
    }
    
    if (indexPath.section == 0) {
        YLBScrollNestTopCell *cell = [tableView dequeueReusableCellWithIdentifier:YLBScrollNestTopCellId forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

#pragma mark YLBSegmentTitleViewDelegate
- (void)YLBContenViewDidEndDecelerating:(YLBPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    _tableView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)YLBSegmentTitleView:(YLBSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.contentCell.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)YLBContentViewDidScroll:(YLBPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    _tableView.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomCellOffset = [_tableView rectForSection:1].origin.y;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
