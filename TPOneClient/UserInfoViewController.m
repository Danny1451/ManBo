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

#import "HttpUtils.h"
#import "StorageUtils.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TRACE(@"view  load ");
    // Do any additional setup after loading the view from its nib.
}


- (void)viewWillAppear:(BOOL)animated{
    
    TRACE(@"view  show ");
    
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
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = SINA_kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];

    
}

- (void)startGetUserInfo{
    StorageUtils* uts = [StorageUtils shareInstance];
    [HttpUtils requestUserInfoAccessToken:uts.accessToken
                                      uid:uts.uid
                                 callback:^(int resultCode, id resultObj) {
       
                                     if (resultCode == CODE_OK) {
                                         
                                         [self updateUserInfo:resultObj];
                                         
                                     }else{
                                         
                                         TRACE(@" get user info erro %d",resultCode);
                                     }
        
    }];
    
}

- (void)updateUserInfo:(UserInfo *)info{
    if (info == nil) {
        return ;
    }
    
    [_friendLab setHidden:NO];
    [_fansLab setHidden:NO];
    [_statusLab setHidden:NO];
    
    
    NSString* friendStr = [NSString stringWithFormat:@"关注：%d", info.friends];
    NSString* fansStr = [NSString stringWithFormat:@"粉丝： %d", info.followers];
    NSString* statusStr= [NSString stringWithFormat:@"微博: %d", info.statuses];
    
    [_friendLab setText:friendStr];
    [_fansLab setText:fansStr];
    [_statusLab setText:statusStr];
    
    [_userNameLab setText:info.name];
    [_locationLab setText:info.location];
    
    [_headImage setImageUrl:info.profileUrl];
    
    
    TRACE(@" 刷新用户信息");
    
}


@end
