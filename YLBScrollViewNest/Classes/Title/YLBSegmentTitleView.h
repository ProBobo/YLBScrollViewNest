//
//  YLBSegmentTitleView.h
//  Pods-YLBScrollViewNest_Example
//
//  Created by yulibo on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YLBSegmentTitleView;

typedef enum : NSUInteger {
    YLBIndicatorTypeDefault,//默认与按钮长度相同
    YLBIndicatorTypeEqualTitle,//与文字长度相同
    YLBIndicatorTypeCustom,//自定义文字边缘延伸宽度
    YLBIndicatorTypeNone,
} YLBIndicatorType;//指示器类型枚举

@protocol YLBSegmentTitleViewDelegate <NSObject>

@optional

/**
 切换标题
 
 @param titleView YLBSegmentTitleView
 @param startIndex 切换前标题索引
 @param endIndex 切换后标题索引
 */
- (void)YLBSegmentTitleView:(YLBSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface YLBSegmentTitleView : UIView

@property (nonatomic, weak) id<YLBSegmentTitleViewDelegate>delegate;

/**
 标题文字间距，默认20
 */
@property (nonatomic, assign) CGFloat itemMargin;

/**
 当前选中标题索引，默认0
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 标题字体大小，默认15
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 标题选中字体大小，默认15
 */
@property (nonatomic, strong) UIFont *titleSelectFont;

/**
 标题正常颜色，默认black
 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/**
 标题选中颜色，默认red
 */
@property (nonatomic, strong) UIColor *titleSelectColor;

/**
 指示器颜色，默认与titleSelectColor一样,在JGIndicatorTypeNone下无效
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 在JGIndicatorTypeCustom时可自定义此属性，为指示器一端延伸长度，默认5
 */
@property (nonatomic, assign) CGFloat indicatorExtension;

/**
 对象方法创建YLBSegmentTitleView
 
 @param frame frame
 @param titlesArr 标题数组
 @param delegate delegate
 @param incatorType 指示器类型
 @return JGSegmentTitleView
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArr delegate:(id<YLBSegmentTitleViewDelegate>)delegate indicatorType:(YLBIndicatorType)incatorType;

@end

NS_ASSUME_NONNULL_END
