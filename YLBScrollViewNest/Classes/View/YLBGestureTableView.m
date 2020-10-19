//
//  YLBGestureTableView.m
//  YLBScrollViewNest
//
//  Created by yulibo on 2020/10/16.
//

#import "YLBGestureTableView.h"

@implementation YLBGestureTableView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
