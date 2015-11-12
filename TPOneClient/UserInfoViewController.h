//
//  UserInfoViewController.h
//  TPOneClient
//
//  Created by 刘旦 on 15/11/11.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *userNameLab;

- (IBAction)btnLogin:(id)sender;

@end
