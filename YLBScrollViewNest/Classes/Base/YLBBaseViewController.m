//
//  YLBBaseViewController.m
//  Pods-YLBScrollViewNest_Example
//
//  Created by yulibo on 2020/10/16.
//

#import "YLBBaseViewController.h"

@interface YLBBaseViewController ()

@end

@implementation YLBBaseViewController

-(NSString *)backItemImageName{
    return @"navigator_btn_back";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configUI];
}

// 配置UI
- (void)configUI {}

@end
