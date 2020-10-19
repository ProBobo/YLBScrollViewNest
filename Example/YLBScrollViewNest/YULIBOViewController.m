//
//  YULIBOViewController.m
//  YLBScrollViewNest
//
//  Created by ProBobo on 10/16/2020.
//  Copyright (c) 2020 ProBobo. All rights reserved.
//

#import "YULIBOViewController.h"
#import <YLBScrollViewNest/YLBScrollNestController.h>
#import <YLBCommon/YLBCommon.h>
@interface YULIBOViewController ()

@end

@implementation YULIBOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    button.backgroundColor = UIColor.cyanColor;
    button.frame = CGRectMake(0, 0, 200, 50);
    button.center = CGPointMake(self.view.ylb_width/2.0, self.view.ylb_height/2.0);
    [button addTarget:self action:@selector(skipToMainVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (void)skipToMainVC {
    YLBScrollNestController *vc = [[YLBScrollNestController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
