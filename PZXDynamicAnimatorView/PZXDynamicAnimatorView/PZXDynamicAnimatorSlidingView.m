//
//  PZXDynamicAnimatorSlidingView.m
//  PZXDynamicAnimatorView
//
//  Created by xrkj on 2018/8/14.
//  Copyright © 2018年 pengzuxin. All rights reserved.
//

#import "PZXDynamicAnimatorSlidingView.h"


@interface PZXDynamicAnimatorSlidingView ()<UICollisionBehaviorDelegate>

@property(nonatomic,strong)UIDynamicAnimator *animator;
@property(nonatomic,strong)UIGravityBehavior *gravity;
@property(nonatomic,strong)UICollisionBehavior *collision;

@property (nonatomic, strong) NSMutableArray *balls;

@end


@implementation PZXDynamicAnimatorSlidingView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        _ballNum = 2;
        _ballSize = 40;
        [self setView];
        
    }
    return self;
}

-(void)setView{
    
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
        ball.tag = 10+i;
        ball.userInteractionEnabled = YES;
        // 初始化手势
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hanlePanGesture:)];
        // 添加手势
        [ball addGestureRecognizer:panGesture];
        

        //球的随机颜色
        ball.image = [UIImage imageNamed:[NSString stringWithFormat:@"ball0%ld.png",i%10]];
        ball.contentMode = UIViewContentModeScaleToFill;
        //        ball.backgroundColor = [UIColor orangeColor];
        //球的随机大小:40~60之间
        CGFloat width = self.ballSize;
        ball.layer.cornerRadius = width/2;
        ball.layer.masksToBounds = YES;
        
        //球的随机位置
        CGRect frame = CGRectMake(arc4random()%((int)(self.bounds.size.width - width)), 60, width, width);
        [ball setFrame:frame];
        
        //添加球体到父视图
        [self addSubview:ball];
        //球堆添加该球
        [self.balls addObject:ball];
    }
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    _animator = animator;

    
    //添加碰撞的动态特性，使其可执行
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:self.balls];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    _collision = collision;
    

    
}



- (void)setBallNum:(NSInteger)ballNum{
    
    _ballNum = ballNum;
    [self setView];
    
    
}

- (void)setBallSize:(CGFloat)ballSize{
    
    _ballSize = ballSize;
    [self setView];
}


- (void)hanlePanGesture:(UIPanGestureRecognizer *)recognizer{
    
    // 获取定位点
    CGPoint translation = [recognizer translationInView:self];
    // recognizer.view.center指的就是button的center,手势已经添加到view上
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    
    // 恢复坐标系，必须恢复不然动画越来越快
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        [self.animator removeAllBehaviors];
        
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        // 获取加速度值
        CGPoint velocity = [recognizer velocityInView:self];
        UIDynamicItemBehavior *b = [[UIDynamicItemBehavior alloc]initWithItems:@[recognizer.view]];
        [b addLinearVelocity:CGPointMake(velocity.x, velocity.y) forItem:recognizer.view];
            b.allowsRotation = YES;//允许旋转
            b.elasticity = 0.6;//弹性
        [self.animator addBehavior:b];
        [self.animator addBehavior:self.collision];
        //        [self.animator addBehavior:self.gravity];
        
    }
    
    NSLog(@"x=%f,y=%f",translation.x,translation.y);
    
}

#pragma mark - UICollisionBehaviorDelegate
- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p {
    
}

- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier {
    
}

@end
