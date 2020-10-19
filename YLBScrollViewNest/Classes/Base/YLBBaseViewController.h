//
//  YLBBaseViewController.h
//  Pods-YLBScrollViewNest_Example
//
//  Created by yulibo on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLBBaseViewController : UIViewController

@property (nonatomic, assign) BOOL isHideBackItem;

-(NSString *)backItemImageName;

// 配置UI
- (void)configUI;
@end

NS_ASSUME_NONNULL_END
