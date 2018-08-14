//
//  ViewController.m
//  PZXDynamicAnimatorView
//
//  Created by xrkj on 2018/8/14.
//  Copyright © 2018年 pengzuxin. All rights reserved.
//

#import "ViewController.h"
#import "GravityViewController.h"
#import "SlidingViewController.h"
@interface ViewController ()

- (IBAction)gravityButtonPressed:(UIButton *)sender;
- (IBAction)slidingButtonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)gravityButtonPressed:(UIButton *)sender {
    
    GravityViewController *vc = [[GravityViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)slidingButtonPressed:(UIButton *)sender {
    
    SlidingViewController *vc = [[SlidingViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
