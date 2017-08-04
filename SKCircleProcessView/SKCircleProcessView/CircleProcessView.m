//
//  CircleProcessView.m
//  SKCircleProcessView
//
//  Created by AY on 2017/8/4.
//  Copyright © 2017年 AlexanderYeah. All rights reserved.
//

#import "CircleProcessView.h"
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]


@interface CircleProcessView ()
/** 定时器*/
@property (nonatomic,strong)NSTimer *timer;
/** 进度条lbl */
@property (nonatomic,strong)UILabel *processLbl;

/** 动画时长 */
@property (nonatomic,assign)CGFloat animDuration;

/** 显示lbl */
@property (nonatomic,strong)UILabel *showStateLbl;

@end
@implementation CircleProcessView

static int timerFlag = 0;
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	
	
	// 1 拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 2 使用path 绘制圆环
    CGContextBeginPath(context); // 起始位置
	CGContextAddArc(context, rect.size.width/2, rect.size.width/2, 60, 0, M_PI * 2, YES);
	// 设置线的宽度
	CGContextSetLineWidth(context, 5.0f);
	// 设置线的填充色
	CGContextSetRGBStrokeColor(context, 255, 255, 255, 1);
    // 3 绘制结束 不写默认封闭
    CGContextClosePath(context);
    // 4 设置填充色
	[[UIColor clearColor] setFill];
    // 5 绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
	
	
}




- (instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super  initWithFrame:frame]) {
			//  这是添加一个动画
	UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:60 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
	CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
	layer.fillColor = [UIColor clearColor].CGColor;
	layer.strokeColor = [UIColor orangeColor].CGColor;
	layer.lineWidth = 5.0;
	CABasicAnimation *strokeAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
	strokeAnim.delegate = self;
	    // 从0%开始到100%
    strokeAnim.fromValue = @(0.0);
    strokeAnim.toValue = @(1.0);
    
    strokeAnim.duration = 12;
	_animDuration = strokeAnim.duration;
    strokeAnim.fillMode = kCAFillModeForwards;
    strokeAnim.removedOnCompletion = NO;
    [layer addAnimation:strokeAnim forKey:@"stroke"];
	
	[self.layer addSublayer:layer];
	
	
	// 进度数字
	_processLbl = [[UILabel alloc]initWithFrame:CGRectMake(75, 75, 50, 30)];
	_processLbl.textAlignment = NSTextAlignmentCenter;
	_processLbl.textColor = [UIColor orangeColor];
	_processLbl.text = @"1%";
	[self addSubview:_processLbl];
	
	
	// 开启一个定时器，来动态改变lbl 的显示数字,这种初始化形式，要将其加入到主运行循环
	_timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(changeLblText) userInfo:nil repeats:YES];
	
	[[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
	[_timer fire];
	
	
	//
	_showStateLbl = [[UILabel alloc]init];
	_showStateLbl.frame = CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40);
	_showStateLbl.textAlignment = NSTextAlignmentCenter;
	_showStateLbl.textColor = [UIColor whiteColor];
	_showStateLbl.font = [UIFont systemFontOfSize:16.0f];
	_showStateLbl.text = @"设备连接中...";
	[self addSubview:_showStateLbl];
	
	
	
	
	
	}
	return self;
}


#pragma mark 动画的代理回调
/** 动画开始 */
- (void)animationDidStart:(CAAnimation *)anim
{
	NSLog(@"%f",anim.duration);
}
/** 动画结束 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	
	// 动画完成
	_showStateLbl.text = @"连接成功";
	
	// 代理回调
	[self.delegate animDidFinished];
	
}



#pragma mark - 定时器调用
- (void)changeLblText
{
	timerFlag ++;
	// timerFlag / 动画时间  = 百分比 25/100
	int perVal = timerFlag * (100 / _animDuration);
	_processLbl.text = [NSString stringWithFormat:@"%d%@",perVal,@"%"];
	
	if (timerFlag == _animDuration) {
		_animDuration = 0;
		[_timer invalidate];
	}

}

#pragma mark - 销毁timer
- (void)dealloc
{
	// 清除定时器
	[_timer invalidate];
}

@end
