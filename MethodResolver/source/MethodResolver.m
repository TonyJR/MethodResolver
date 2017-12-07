//
//  MethodResolver.m
//  MethodResolver
//
//  Created by Tony on 2017/12/7.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+MethodResolver.h"
#import <objc/runtime.h>

@interface NSObject ()

+ (BOOL)swapped_resolveClassMethod:(SEL)sel;
+ (BOOL)swapped_resolveInstanceMethod:(SEL)sel;

@end

int methodResolverInit(void){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldM,newM;
//        oldM  = class_getClassMethod([NSObject class], @selector(resolveClassMethod:));
//        newM = class_getClassMethod([NSObject class], @selector(swapped_resolveClassMethod:));
//        method_exchangeImplementations(oldM, newM);
        
        oldM  = class_getClassMethod([NSObject class], @selector(resolveInstanceMethod:));
        newM = class_getClassMethod([NSObject class], @selector(swapped_resolveInstanceMethod:));
        method_exchangeImplementations(oldM, newM);
    });
    return 0;
}
