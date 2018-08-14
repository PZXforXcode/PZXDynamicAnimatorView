//
//  SlidingViewController.m
//  PZXDynamicAnimatorView
//
//  Created by xrkj on 2018/8/14.
//  Copyright © 2018年 pengzuxin. All rights reserved.
//

#import "SlidingViewController.h"
#import "PZXDynamicAnimatorSlidingView.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface SlidingViewController ()

@property (nonatomic,strong)PZXDynamicAnimatorSlidingView *slidingView;

@end

@implementation SlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _slidingView = [[PZXDynamicAnimatorSlidingView alloc]initWithFrame:CGRectMake(0, 61, WIDTH, HEIGHT-64)];
    _slidingView.ballNum = 6;
    _slidingView.ballSize = 50;
    [self.view addSubview:_slidingView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
