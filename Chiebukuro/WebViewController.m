//
//  WebViewController.m
//  Chiebukuro
//
//  Created by 萱島克英 on 2014/03/29.
//  Copyright (c) 2014年 private_company. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:self.url];
    [self.webView loadRequest:request];
}


@end
