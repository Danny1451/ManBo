//
//  StatusTableViewCell.m
//  TPOneClient
//
//  Created by 刘旦 on 15/12/2.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "StatusTableViewCell.h"
#import "CommonUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation StatusTableViewCell

- (void)showDate:(Status *)model{
    
    self.userNameLab.text = model.user.name;
    self.timeCreatedLab.text = [CommonUtils sinaDateToTargetDate:model.timeCreated target:@"yyyy-MM-dd HH:mm:ss"];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.user.profileUrl] placeholderImage:[UIImage imageNamed:@"ico_avatar_normal.png"]];
    
    self.textLab.text = model.text;
    [self.textLab sizeToFit];
    
    
    [self.repostLab setText:[NSString stringWithFormat:@"转发:%d", model.repostCount]];
    [self.repostLab sizeToFit];
    
    [self.commentLab setText:[NSString stringWithFormat:@"评论:%d", model.commentsCount]];
    [self.commentLab sizeToFit];
    
    
    
    [self.attitudeLab setText:[NSString stringWithFormat:@"点赞:%d", model.attitudeCount]];
    [self.attitudeLab sizeToFit];
    
    
    if (model.picurl.count > 0) {
        
    }
    
}

- (CGFloat)getCellHeight{
    
    
    CGFloat labHeight = self.textLab.frame.size.height;
    return labHeight + 130;
    
}

@end
