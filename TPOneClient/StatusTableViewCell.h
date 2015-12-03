//
//  StatusTableViewCell.h
//  TPOneClient
//
//  Created by 刘旦 on 15/12/2.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"

@interface StatusTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *userNameLab;
@property (strong, nonatomic) IBOutlet UILabel *timeCreatedLab;
@property (strong, nonatomic) IBOutlet UILabel *textLab;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;

- (void)showDate:(Status *) model;

@end
