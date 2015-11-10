//
//  HomeViewController.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/9.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://open.play.cn/api/v1/user/captcha/get?client_id=730988&r=3733303938382D32313833353536353934353836333034352D35363838333332393431303132383939313830"]]];
    
    [self.imageView setImage:image];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
