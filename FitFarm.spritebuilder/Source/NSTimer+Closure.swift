//
//  NSTimer+Closure.swift
//  FitFarm
//
//  Created by Zachary Espiritu on 1/31/16.
//  Copyright © 2016 Zachary Espiritu. All rights reserved.
//

extension NSTimer {
    /**
     Creates and schedules a one-time `NSTimer` instance.
     - parameter delay:     the delay (in seconds) before execution of `handler`
     - parameter handler:   a closure to execute after `delay`
     - returns:             the newly-created `NSTimer` instance
     */
    class func schedule(delay delay: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
    }
    
    /**
     Creates and schedules a repeating `NSTimer` instance.
     - Note: Individual calls may be delayed; subsequent calls to `handler` will be based on the time the timer was created.
     - parameter repeatInterval:   the interval (in seconds) between each execution of `handler`
     - parameter handler:          a closure to execute at each `repeatInterval`
     - returns:                    the newly-created `NSTimer` instance
     */
    class func schedule(repeatInterval interval: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
    }
}