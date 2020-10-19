//
//  YLBPageContentView.h
//  YLBScrollViewNest
//
//  Created by yulibo on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YLBPageContentView;

@protocol YLBPageContentViewDelegate <NSObject>

@optional

/**
 YLBPageContentView开始滑动
 
 @param contentView YLBPageContentView
 */
- (void)YLBContentViewWillBeginDragging:(YLBPageContentView *)contentView;

/**
 YLBPageContentView滑动调用
 
 @param contentView YLBPageContentView
 @param startIndex 开始滑动页面索引
 @param endIndex 结束滑动页面索引
 @param progress 滑动进度
 */
- (void)YLBContentViewDidScroll:(YLBPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress;

/**
 YLBPageContentView结束滑动
 
 @param contentView YLBPageContentView
 @param startIndex 开始滑动索引
 @param endIndex 结束滑动索引
 */
- (void)YLBContenViewDidEndDecelerating:(YLBPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface YLBPageContentView : UIView

/**
 对象方法创建YLBPageContentView
 
 @param frame frame
 @param childVCs 子VC数组
 @param parentVC 父视图VC
 @param delegate delegate
 @return YLBPageContentView
 */
- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<YLBPageContentViewDelegate>)delegate;

@property (nonatomic, weak) id<YLBPageContentViewDelegate>delegate;

/**
 设置contentView当前展示的页面索引，默认为0
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;

@end

NS_ASSUME_NONNULL_END
