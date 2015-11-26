//
//  UserInfoViewController.h
//  TPOneClient
//
//  Created by 刘旦 on 15/11/11.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "EGUAsynImageView.h"

@interface UserInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *userNameLab;
@property (strong, nonatomic) IBOutlet EGUAsynImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *locationLab;
@property (strong, nonatomic) IBOutlet UILabel *friendLab;
@property (strong, nonatomic) IBOutlet UILabel *fansLab;
@property (strong, nonatomic) IBOutlet UILabel *statusLab;

- (IBAction)btnLogin:(id)sender;


- (void)startGetUserInfo;
@end
