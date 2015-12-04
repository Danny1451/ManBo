//
//  ViewController.h
//  TPOneClient
//
//  Created by 刘旦 on 15/11/6.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYLTabBarController.h"

#import "HomeViewController.h"
#import "UserInfoViewController.h"
#import <ZBarReaderViewController.h>

@interface ViewController : CYLTabBarController

@property(nonatomic,copy) UIViewController* tab1;
@property(nonatomic,copy) HomeViewController* view2;
@property(nonatomic,copy) UserInfoViewController* tab2;

@end

