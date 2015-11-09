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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableViewController* tab1 = [[UITableViewController alloc] init];
    UIViewController* view2 = [[UIViewController alloc] init];
    UITableViewController* tab2 = [[UITableViewController alloc] init];
    [tab1.tabBarItem setTitle:@"tab1"];
    NSArray *viewArray = [[NSArray alloc] initWithObjects:tab1,view2,tab2, nil];
    
    NSDictionary* tab1Nic = [[NSDictionary alloc]init];
    tab1Nic
    
    [self setViewControllers:viewArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
