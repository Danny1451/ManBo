//
//  ViewController.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/6.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    TRACE(@"applear");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tab1 = [[UIViewController alloc] init];
    _view2 = [[HomeViewController alloc] init];
    _tab2 = [[UserInfoViewController alloc] init];
    [_tab1.tabBarItem setTitle:@"tab1"];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:_tab1,_view2,_tab2, nil];
    
    
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
