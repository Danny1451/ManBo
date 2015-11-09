//
//  ViewController.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/6.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableViewController* tab1 = [[UITableViewController alloc] init];
    HomeViewController* view2 = [[HomeViewController alloc] init];
    UITableViewController* tab2 = [[UITableViewController alloc] init];
    [tab1.tabBarItem setTitle:@"tab1"];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:tab1,view2,tab2, nil];
    
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"同城",
                            CYLTabBarItemImage : @"mycity_normal",
                            CYLTabBarItemSelectedImage : @"mycity_highlight",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"消息",
                            CYLTabBarItemImage : @"message_normal",
                            CYLTabBarItemSelectedImage : @"message_highlight",
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
