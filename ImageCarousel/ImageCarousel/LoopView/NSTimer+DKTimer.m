//
//  NSTimer+DKTimer.m
//  ImageCarousel
//
//  Created by doublek on 2017/7/5.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import "NSTimer+DKTimer.h"

@implementation NSTimer (DKTimer)

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}



@end
