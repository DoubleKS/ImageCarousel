//
//  NSTimer+DKTimer.h
//  ImageCarousel
//
//  Created by doublek on 2017/7/5.
//  Copyright © 2017年 doublek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (DKTimer)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
