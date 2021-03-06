//
//  YLBScrollNestBottomViewTCell.m
//  Pods-YLBScrollViewNest_Example
//
//  Created by yulibo on 2020/10/16.
//

#import "YLBScrollNestBottomViewTCell.h"
#import "YLBScrollContentViewController.h"

@implementation YLBScrollNestBottomViewTCell

#pragma mark Setter
- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
}

- (void)setCellCanScroll:(BOOL)cellCanScroll
{
    _cellCanScroll = cellCanScroll;
    
    for (YLBScrollContentViewController *VC in _viewControllers) {
        VC.vcCanScroll = cellCanScroll;
        if (!cellCanScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.collectionView.contentOffset = CGPointZero;
        }
    }
}

- (void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
    
    for (YLBScrollContentViewController *ctrl in self.viewControllers) {
        if ([ctrl.title isEqualToString:self.currentTagStr]) {
            ctrl.isRefresh = isRefresh;
        }
    }
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
