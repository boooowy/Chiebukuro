//
//  WebViewController.h
//  Chiebukuro
//
//  Created by 萱島克英 on 2014/03/29.
//  Copyright (c) 2014年 private_company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong , nonatomic) NSURL *url;
@end
