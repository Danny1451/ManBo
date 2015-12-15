//
//  PicBroswer.h
//  TPOneClient
//
//  Created by 刘旦 on 15/12/14.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PIC_GAP 8

@interface PicBroswer : UIView

/** 图片数组 */
@property (nonatomic,strong) NSArray *images;


@property (nonatomic,copy) void (^ClickImageBlock)(NSUInteger index);


@end
