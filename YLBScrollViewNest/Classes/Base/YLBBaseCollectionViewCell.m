//
//  YLBBaseCollectionViewCell.m
//  Pods-YLBScrollViewNest_Example
//
//  Created by yulibo on 2020/10/16.
//

#import "YLBBaseCollectionViewCell.h"

@implementation YLBBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
          [self configUI];
    }
    return self;
}


// 配置UI
- (void)configUI {}

@end
