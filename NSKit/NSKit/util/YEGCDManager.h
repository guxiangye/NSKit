//
//  YEGCDManager.h
//  ModaiTreasure
//
//  Created by 相晔谷 on 16/5/12.
//  Copyright © 2016年 相晔谷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YEGCDManager : NSObject

/**
 *  1.只执行一次
 *
 *  @param oncePerform 事件
 */
+ (void)gcd_oncePerform:(void(^)())oncePerform;

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
       group_notifyEvent:(void (^)())group_notifyEvent;


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
                thridEvent:(void (^)())thirdEvent;


/**
 *  4.重复执行
 *
 *  @param timer 次数
 *  @param event 事件
 */
+ (void)gcd_applyPerformTimes:(NSInteger)timer
                        event:(void (^)())event;


/**
 *  5.延时执行
 *
 *  @param time  时间
 *  @param event 事件
 */
+ (void)gcd_afterPerformTimer:(float)time
                        event:(void (^)())event;

/**
 *  6.主线程
 *
 *  @param event 事件
 */
+ (void)gcd_mainPerformEvent:(void (^)())event;

/**
 *  7.异步执行
 *
 *  @param event 事件
 */
+ (void)gcd_asyncPerformEvent:(void (^)())event;


@end
