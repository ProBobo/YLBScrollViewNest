//
//  YLBScrollContentViewController.m
//  Pods-YLBScrollViewNest_Example
//
//  Created by yulibo on 2020/10/16.
//

#import "YLBScrollContentViewController.h"
#import "YLBScrollContentViewTCell.h"
#import <YLBCommon/YLBCommon.h>
#import <MJRefresh/MJRefresh.h>

NSString * const YLBMineLeaveTopNotification = @"YLBMineLeaveTopNotification";

@interface YLBScrollContentViewController () <UICollectionViewDelegate,UICollectionViewDataSource> 

@property (nonatomic, assign) BOOL fingerIsTouch;

@end

static NSString * const YLBScrollContentViewTCellId = @"YLBScrollContentViewTCellId";

@implementation YLBScrollContentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self insertRowAtTop];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupRefresh];
}


- (void)configUI {
    
    // 创建一个网格布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, YLB_SCREEN_WIDTH, YLB_SCREEN_HEIGHT - 40) collectionViewLayout:layout];
    // 指定代理
    _collectionView.delegate = self;
    // 指定数据源代理
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceVertical = YES; //数据不够一屏时上下滚动
    
    // 添加到当前视图上显示
    _collectionView.backgroundColor = YLBHexColor(0xeeeeee);//[UIColor colorWithHexCode:@"#eeeeee"];
    [_collectionView registerClass:[YLBScrollContentViewTCell class] forCellWithReuseIdentifier:YLBScrollContentViewTCellId];
    [self.view addSubview:_collectionView];
    
}


- (void)setupRefresh {
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(insertRowAtTop)];
    
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(insertRowAtBottom)];
}


#pragma mark Setter
- (void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;

    [self insertRowAtTop];
}

- (void)insertRowAtTop {
    
    
    //@"精选", @"女装", @"美妆", @"母婴"
    if ([self.str isEqualToString:@"精选"]) {
        YLBDLog(@"精选数据");
    }else if ([self.str isEqualToString:@"女装"]) {
        YLBDLog(@"女装数据");
    }else if ([self.str isEqualToString:@"美妆"]) {
        YLBDLog(@"美妆数据");
    }else if ([self.str isEqualToString:@"母婴"]) {
        YLBDLog(@"母婴数据");
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //让[刷新控件]结束刷新
        [self.collectionView.mj_header endRefreshing];
    });
}

- (void)insertRowAtBottom {
    
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //让[刷新控件]结束刷新
        [self.collectionView.mj_footer endRefreshing];
    });
}



#pragma mark - collectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YLBScrollContentViewTCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YLBScrollContentViewTCellId forIndexPath:indexPath];
        
    return cell;
}


//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YLBDLog(@"%ld", indexPath.row);
}

//返回每个子视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWidth = (YLB_SCREEN_WIDTH - 1.0f) / 2.0 ;
    return CGSizeMake(itemWidth, 202);
}

//设置每个子视图的缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(1, 0, 0, 0) ;
}


//设置子视图上下之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return  1 ;
}

//设置子视图左右之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return  1 ;
}



#pragma mark UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //    YLBLog(@"接触屏幕");
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //    YLBLog(@"离开屏幕");
    self.fingerIsTouch = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:YLBMineLeaveTopNotification object:nil];//到顶通知父视图改变状态
    }
    self.collectionView.showsVerticalScrollIndicator = _vcCanScroll ? YES : NO;
}

@end
