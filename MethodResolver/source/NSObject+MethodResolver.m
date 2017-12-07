//
//  NSObject+MethodResolver.m
//  MethodResolver
//
//  Created by Tony on 2017/12/7.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "NSObject+MethodResolver.h"
#import <objc/runtime.h>

@implementation NSObject (MethodResolver)

static dispatch_semaphore_t semaphore;
static dispatch_once_t onceToken;

id unrecognized_method_resolver(id obj, SEL selector, ...){
    if (selector) {
        NSLog(@"%@->%s",NSStringFromClass([obj class]),[NSStringFromSelector(selector) UTF8String]);
    }
    return nil;
}



+ (BOOL)swapped_resolveClassMethod:(SEL)sel{
    if (![self swapped_resolveClassMethod:sel]) {
        dispatch_once(&onceToken, ^{
            semaphore = dispatch_semaphore_create(1);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self mr_addMethod:sel];
        dispatch_semaphore_signal(semaphore);
    }
    
    return YES;
}


+ (BOOL)swapped_resolveInstanceMethod:(SEL)sel{
    BOOL result = YES;
    
    if (![self swapped_resolveInstanceMethod:sel]) {
        
        dispatch_once(&onceToken, ^{
            semaphore = dispatch_semaphore_create(1);
        });
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        result = [self mr_addMethod:sel];
        dispatch_semaphore_signal(semaphore);
    }
    
    return result;
}

+ (BOOL)mr_addMethod:(SEL)sel{
    class_addMethod(self, sel, (IMP)unrecognized_method_resolver , "v16@0:8");
    return YES;
    
//
//    if ([predicate evaluateWithObject:NSStringFromClass(self)]) {
//        return NO;
//    }else{
//        class_addMethod(self, sel, (IMP)unrecognized_method_resolver , "v16@0:8");
//        return YES;
//    }
}

@end
