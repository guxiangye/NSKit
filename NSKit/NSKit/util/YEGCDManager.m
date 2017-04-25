//
//  YEGCDManager.m
//  ModaiTreasure
//
//  Created by 相晔谷 on 16/5/12.
//  Copyright © 2016年 相晔谷. All rights reserved.
//

#import "YEGCDManager.h"

@implementation YEGCDManager

/**
 *  1.只执行一次
 *
 *  @param oncePerform 事件
 */
+ (void)gcd_oncePerform:(void(^)())oncePerform {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, oncePerform);
}

/**
 *  2.分组: dispatch_group_notify
 *
 *  @param firstEvent        第一个异步
 *  @param secondEvent       第二个异步
 *  @param thirdEvent        第三个异步
 *  @param group_notifyEvent 全部执行完之后再执行
 */
+ (void)gcd_groupPerform:(void (^)())firstEvent
             secondEvent:(void (^)())secondEvent
              thridEvent:(void (^)())thirdEvent
       group_notifyEvent:(void (^)())group_notifyEvent {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, firstEvent);
    
    if (secondEvent) {
        dispatch_group_async(group, queue, secondEvent);
    }
    if (thirdEvent) {
        dispatch_group_async(group, queue, thirdEvent);
    }
    
    dispatch_group_notify(group, queue, group_notifyEvent);
}

/**
 *  3.分段: dispatch_barrier_async
 *
 *  @param firstEvent @param secondEvent  前两个执行
 *  @param barrierEvent 然后执行
 *  @param thirdEvent   最后执行
 */
+ (void)gcd_barrierPerform:(void (^)())firstEvent
               secondEvent:(void (^)())secondEvent
              barrierEvent:(void (^)())barrierEvent
                thridEvent:(void (^)())thirdEvent {
    
    dispatch_queue_t queue = dispatch_queue_create("YEGCDManager.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, firstEvent);
    
    if (secondEvent) {
        dispatch_async(queue, secondEvent);
    }
    
    if (barrierEvent) {
        dispatch_barrier_async(queue, barrierEvent);
    }
    
    if (thirdEvent) {
        dispatch_async(queue, thirdEvent);
    }
}

/**
 *  4.重复执行
 *
 *  @param timer 次数
 *  @param event 事件
 */
+ (void)gcd_applyPerformTimes:(NSInteger)timer event:(void (^)())event {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        dispatch_apply(timer, queue, event);
    });
}

/**
 *  5.延时执行
 *
 *  @param time  时间
 *  @param event 事件
 */
+ (void)gcd_afterPerformTimer:(float)time event:(void (^)())event {
    
    double delayInSeconds = time;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), event);
}

/**
 *  6.主线程
 *
 *  @param event 事件
 */
+ (void)gcd_mainPerformEvent:(void (^)())event {
    
    dispatch_async(dispatch_get_main_queue(), event);
}

/**
 *  7.异步执行
 *
 *  @param event 事件
 */
+ (void)gcd_asyncPerformEvent:(void (^)())event {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, event);
}

@end
