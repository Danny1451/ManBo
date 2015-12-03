//
//  StatusTableViewCell.m
//  TPOneClient
//
//  Created by 刘旦 on 15/12/2.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "StatusTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation StatusTableViewCell

- (void)showDate:(Status *)model{
    
    self.userNameLab.text = model.user.name;
    self.timeCreatedLab.text = model.timeCreated;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.user.profileUrl] placeholderImage:[UIImage imageNamed:@"ico_avatar_normal.png"]];
    
    self.textLab.text = model.text;
    [self.textLab sizeToFit];
}

@end
