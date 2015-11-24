//
//  ViewController.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/6.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "UserInfoViewController.h"
#import <ZBarReaderViewController.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    TRACE(@"applear");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZBarReaderViewController* tab1 = [[ZBarReaderViewController alloc] init];
    HomeViewController* view2 = [[HomeViewController alloc] init];
    UserInfoViewController* tab2 = [[UserInfoViewController alloc] init];
    [tab1.tabBarItem setTitle:@"tab1"];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:tab1,view2,tab2, nil];
    
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"first_normal",
                            CYLTabBarItemSelectedImage : @"first_selected",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"同城",
                            CYLTabBarItemImage : @"second_normal",
                            CYLTabBarItemSelectedImage : @"second_selected",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"third_normal",
                            CYLTabBarItemSelectedImage : @"third_selected",
                            };
   
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
                                       dict3
                                       ];
    self.tabBarItemsAttributes = tabBarItemsAttributes;
    [self setViewControllers:viewArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
