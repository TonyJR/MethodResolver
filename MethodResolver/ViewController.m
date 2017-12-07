//
//  ViewController.m
//  MethodResolver
//
//  Created by Tony on 2017/12/7.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "ViewController.h"
#import "MethodResolver.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidAppear:(BOOL)animated{
    methodResolverInit();
    [self performSelector:@selector(foo) withObject:nil];
    
    NSLog(@"-------%@",self);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
