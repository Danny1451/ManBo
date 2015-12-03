//
//  Status.h
//  TPOneClient
//
//  Created by 刘旦 on 15/11/27.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface Status : NSObject <NSCopying>

//发布微博的用户
@property(nonatomic, copy) UserInfo* user;

//微博ID
@property(nonatomic) NSInteger sId;
//微博的文本内容
@property(nonatomic, strong) NSString* text;
//微博的来源
@property(nonatomic, strong) NSString* souce;
//生成时间
@property(nonatomic, strong) NSString* timeCreated;

//相关的微博
@property(nonatomic, copy) Status* releateStatus;


@property(nonatomic) NSInteger repostCount;

@property(nonatomic) NSInteger commentsCount;

@property(nonatomic) NSInteger attitudeCount;

@property(nonatomic) BOOL isLongText;

//图片
@property(nonatomic, strong) NSMutableArray* picurl;

//长图的不同模式
@property(nonatomic, strong) NSString* thumnailPic;
@property(nonatomic, strong) NSString* bminddlePic;
@property(nonatomic, strong) NSString* originalPic;

//json TO status
+ (Status *) parseJsonData: (id) jsonDic;

+ (NSMutableArray*) parseToStatusArray: (id) jsonDic;


@end
