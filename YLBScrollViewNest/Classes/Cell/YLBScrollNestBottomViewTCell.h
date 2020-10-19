//
//  YLBScrollNestBottomViewTCell.h
//  Pods-YLBScrollViewNest_Example
//
//  Created by yulibo on 2020/10/16.
//

#import "YLBBaseTableViewCell.h"
#import "YLBPageContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBScrollNestBottomViewTCell : YLBBaseTableViewCell

@property (nonatomic, strong) YLBPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;
@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) NSString *currentTagStr;

@end

NS_ASSUME_NONNULL_END
