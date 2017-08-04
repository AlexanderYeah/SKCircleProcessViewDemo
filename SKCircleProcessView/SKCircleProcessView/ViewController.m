//
//  ViewController.m
//  SKCircleProcessView
//
//  Created by AY on 2017/8/4.
//  Copyright © 2017年 AlexanderYeah. All rights reserved.
//
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#import "ViewController.h"
#import "CircleProcessView.h"
@interface ViewController ()<CircleViewDelegate>


@property (nonatomic,strong)CircleProcessView *circleView;


@property (nonatomic,strong)UIView *exView;


@end

@implementation ViewController
- (void)createCircleView
{
	
		_circleView = [[CircleProcessView alloc]initWithFrame:CGRectMake(200, 100, 200, 200)];
		_circleView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
		_circleView.hidden = YES;
		_circleView.delegate = self;
		[self.view addSubview:_circleView];
}



- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	
	[self createCircleView];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"show" forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
	[btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
	btn.frame = CGRectMake(100, 100, 100, 40);
	[self.view addSubview:btn];
	
	
}

- (void)btnClick{
	
	NSLog(@"222");
	
	self.circleView.hidden = NO;
	
}

#pragma mark - 动画完成的回调
- (void)animDidFinished
{
	self.circleView.hidden =YES;
	self.circleView = nil;
	[self.circleView removeFromSuperview];
	
	
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
