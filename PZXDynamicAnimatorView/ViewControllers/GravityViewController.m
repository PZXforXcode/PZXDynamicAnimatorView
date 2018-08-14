//
//  GravityViewController.m
//  PZXDynamicAnimatorView
//
//  Created by xrkj on 2018/8/14.
//  Copyright © 2018年 pengzuxin. All rights reserved.
//

#import "GravityViewController.h"
#import "PZXDynamicAnimatorGravityView.h"

#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height

@interface GravityViewController ()

@property(nonatomic,strong)PZXDynamicAnimatorGravityView *gravityView;

@end

@implementation GravityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _gravityView = [[PZXDynamicAnimatorGravityView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    _gravityView.ballNum = 99;
    _gravityView.ballSize = 20;
    [self.view addSubview:_gravityView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    NSLog(@"[dealloc]");
    //记得在销毁内存时停止陀螺仪工作
    [_gravityView.MotionManager stopDeviceMotionUpdates];
}

@end
