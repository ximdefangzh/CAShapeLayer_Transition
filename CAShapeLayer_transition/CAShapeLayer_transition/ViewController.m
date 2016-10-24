//
//  ViewController.m
//  CAShapeLayer_transition
//
//  Created by ximdefangzh on 16/10/22.
//  Copyright © 2016年 ximdefangzh. All rights reserved.
//

#import "ViewController.h"
#import "XimCircleAnimator.h"
@interface ViewController ()

@end

@implementation ViewController{
    XimCircleAnimator *_animator;
}

//- (instancetype)init{
//    if(self = [super init]){
//        self.modalPresentationStyle = UIModalPresentationCustom;
//        _animator = [[XimCircleAnimator alloc] init];
//        self.transitioningDelegate = _animator;
//    }
//    return self;
//}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.modalPresentationStyle = UIModalPresentationCustom;
        _animator = [[XimCircleAnimator alloc] init];
        self.transitioningDelegate = _animator;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
