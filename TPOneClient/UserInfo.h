//
//  UserInfo.h
//  TPOneClient
//
//  Created by 刘旦 on 15/11/24.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCopying>

//用户id
@property(nonatomic) long long uid;
//名称
@property(nonatomic, strong) NSString *name;
//地理位置
@property(nonatomic, strong) NSString *location;
//签名
@property(nonatomic, strong) NSString *descrip;
//头像
@property(nonatomic, strong) NSString *profileUrl;
@property(nonatomic, strong) NSString *hdHead;
@property(nonatomic, strong) NSString *largeHead;

//粉丝
@property(nonatomic) NSInteger followers;
//关注人数
@property(nonatomic) NSInteger friends;
//微博数
@property(nonatomic) NSInteger statuses;
//等级
@property(nonatomic) NSInteger urank;

+ (UserInfo *) parseJsonData: (id) jsonDic;

@end
