//
//  YLBScrollContentViewController.h
//  Pods-YLBScrollViewNest_Example
//
//  Created by yulibo on 2020/10/16.
//

#import <UIKit/UIKit.h>
#import "YLBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLBScrollContentViewController : YLBBaseViewController

@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) NSString *str;

@end

NS_ASSUME_NONNULL_END
