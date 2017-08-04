//
//  CircleProcessView.h
//  SKCircleProcessView
//
//  Created by AY on 2017/8/4.
//  Copyright © 2017年 AlexanderYeah. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CircleViewDelegate <NSObject>

- (void)animDidFinished;

@end
@interface CircleProcessView : UIView<CAAnimationDelegate>

@property (nonatomic,assign)id<CircleViewDelegate> delegate;

@end
