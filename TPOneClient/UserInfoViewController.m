//
//  UserInfoViewController.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/11.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "UserInfoViewController.h"
#import <WeiboSDK.h>
#import "Const.h"


@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)btnLogin:(id)sender {
    //换取sina 的token
    if (![WeiboSDK isWeiboAppInstalled]){
        //没装围脖
        TRACE(@"没装微博%@",[NSURL URLWithString:[WeiboSDK getWeiboAppInstallUrl]]);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WeiboSDK getWeiboAppInstallUrl]]];
        
    }else{
        
        
        
        WBAuthorizeRequest *reuqest = [WBAuthorizeRequest request];
        reuqest.redirectURI = @"www.baidu.com";
        reuqest.scope = @"all";
        
        [WeiboSDK sendRequest:reuqest];
    
    
    }
    
}
@end
