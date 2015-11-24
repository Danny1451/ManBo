//
//  UserInfo.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/24.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (UserInfo*)parseJsonData:(id)jsonDic{
    UserInfo* result = [[UserInfo alloc] init];
    
    result.name = [jsonDic objectForKey:@"name"];
    result.location = [jsonDic objectForKey:@"location"];
    result.descrip = [jsonDic objectForKey:@"description"];
    result.profileUrl = [jsonDic objectForKey:@"profile_image_url"];
    
    result.hdHead = [jsonDic objectForKey:@"avatar_hd"];
    result.largeHead = [jsonDic objectForKey:@"avatar_large"];
    
    result.followers = [[jsonDic objectForKey:@"followers_count"] integerValue];
    result.friends = [[jsonDic objectForKey:@"friends_count"] integerValue];
    result.statuses = [[jsonDic objectForKey:@"statuses_count"] integerValue];
    
    result.urank = [[jsonDic objectForKey:@"urank"] integerValue];
    return result;
    
}

@end
