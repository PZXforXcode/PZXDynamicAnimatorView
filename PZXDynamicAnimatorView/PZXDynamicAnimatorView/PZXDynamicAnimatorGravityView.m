//
//  PZXDynamicAnimatorGravityView.m
//  PZXDynamicAnimatorView
//
//  Created by xrkj on 2018/8/14.
//  Copyright © 2018年 pengzuxin. All rights reserved.
//

#import "PZXDynamicAnimatorGravityView.h"


@interface PZXDynamicAnimatorGravityView ()<UICollisionBehaviorDelegate>


@property (nonatomic, strong) NSMutableArray *balls;
@property (nonatomic, strong) UIGravityBehavior *gravityBeahvior;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;

@end

@implementation PZXDynamicAnimatorGravityView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = NO;
        _ballNum = 20;
        _ballSize = 40;
        
        [self _setupBalls];
        [self useGyroPush];
        
    }
    return self;
}

- (void)_setupBalls{
    
    
    
    self.balls = [NSMutableArray array];
    NSArray *views = [self subviews];
    for (UIImageView *imgV in views) {
        [imgV removeFromSuperview];
    }
    

    //添加两个球体，使用拥有重力特性和碰撞特性
    NSUInteger numOfBalls = self.ballNum;
    
    NSLog(@"numOfBalls = %ld",numOfBalls);
    
    for (NSUInteger i = 0; i < numOfBalls; i ++) {
        
        UIImageView *ball = [UIImageView new];
        
        //球的随机颜色
        ball.image = [UIImage imageNamed:[NSString stringWithFormat:@"ball0%ld.png",i%10]];
        ball.contentMode = UIViewContentModeScaleToFill;

//        ball.backgroundColor = [UIColor orangeColor];
        //球的随机大小:40~60之间
        CGFloat width = self.ballSize;
        ball.layer.cornerRadius = width/2;
        ball.layer.masksToBounds = YES;
        
        //球的随机位置
        CGRect frame = CGRectMake(arc4random()%((int)(self.bounds.size.width - width)), 0, width, width);
        [ball setFrame:frame];
        
        //添加球体到父视图
        [self addSubview:ball];
        //球堆添加该球
        [self.balls addObject:ball];
    }
    
    UIDynamicAnimator *animator     = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    _animator                       = animator;
    
    //添加重力的动态特性，使其可执行
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:self.balls];
    [self.animator addBehavior:gravity];
    _gravity = gravity;
    
    //添加碰撞的动态特性，使其可执行
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:self.balls];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    _collision = collision;
    
    //弹性
    UIDynamicItemBehavior *dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.balls];
    dynamicItemBehavior.allowsRotation = YES;//允许旋转
    dynamicItemBehavior.elasticity = 0.6;//弹性
    [self.animator addBehavior:dynamicItemBehavior];
}

- (void)useGyroPush{
    //初始化全局管理对象
    
    self.MotionManager = [[CMMotionManager alloc]init];
    self.MotionManager.deviceMotionUpdateInterval = 0.01;
    
    
    
    [self.MotionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *_Nullable motion,NSError * _Nullable error) {
        
        NSString *yaw = [NSString stringWithFormat:@"%f",motion.attitude.yaw];
        NSString *pitch = [NSString stringWithFormat:@"%f",motion.attitude.pitch];
        NSString *roll = [NSString stringWithFormat:@"%f",motion.attitude.roll];
        
        double rotation = atan2(motion.attitude.pitch, motion.attitude.roll);
        
        //重力角度
        self.gravity.angle = rotation;
        
//        NSLog(@"yaw = %@,pitch = %@, roll = %@,rotation = %fd",yaw,pitch,roll,rotation);
        
    }];
    
}

- (void)setBallNum:(NSInteger)ballNum{
    
    _ballNum = ballNum;
    [self _setupBalls];
    
    
}

- (void)setBallSize:(CGFloat)ballSize{
    
    _ballSize = ballSize;
    [self _setupBalls];
}


#pragma mark - UICollisionBehaviorDelegate
- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p {
    
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier {
    
}

- (void)dealloc{
    NSLog(@"[dealloc]");
    [self.MotionManager stopDeviceMotionUpdates];
}

@end
