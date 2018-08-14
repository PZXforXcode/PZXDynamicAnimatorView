# PZXDynamicAnimatorView
重力弹球界面，以及滑动弹球的封装

![image](https://github.com/PZXforXcode/PZXDynamicAnimatorView/blob/master/PZXDynamicAnimatorView/pzxgra.gif) 

![image](https://github.com/PZXforXcode/PZXDynamicAnimatorView/blob/master/PZXDynamicAnimatorView/pzxpz.gif) 

`  //重力view使用方法
    _gravityView = [[PZXDynamicAnimatorGravityView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];

    _gravityView.ballNum = 99;//弹球数量

    _gravityView.ballSize = 20;//弹球size</br>

    [self.view addSubview:_gravityView];</br>

    //滑动弹球使用方法</br>

    _slidingView = [[PZXDynamicAnimatorSlidingView alloc]initWithFrame:CGRectMake(0, 61, WIDTH, HEIGHT-64)];</br>

    _slidingView.ballNum = 6;</br>

    _slidingView.ballSize = 50;</br>

    [self.view addSubview:_slidingView];</br>

    //具体见demo
    `
