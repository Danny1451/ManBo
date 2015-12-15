//
//  Status.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/27.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "Status.h"
#import "CommonUtils.h"
@implementation Status

+ (Status *) parseJsonData:(id)jsonDic{
    
    if ([jsonDic isEqual:[NSNull null]]){
        
        return nil;
        
    }
    if ([jsonDic count] < 1) {
        
        return nil;
    }

    Status * res = [[Status alloc] init];
    
    res.json = [CommonUtils dataToString:jsonDic];
    
    res.user = [UserInfo parseJsonData:[jsonDic objectForKey:@"user"]];
    
    res.sId = [[jsonDic objectForKey:@"id"] longLongValue];
    
    res.text = [jsonDic objectForKey:@"text"];
    
    res.souce = [jsonDic objectForKey:@"source"];
    res.timeCreated = [jsonDic objectForKey:@"created_at"];
    
    //获取相关微博
    res.releateStatus = [self parseJsonData:[jsonDic objectForKey:@"retweeted_status"]];
    
    res.repostCount = [[jsonDic objectForKey:@"reposts_count"] integerValue];
    res.commentsCount = [[jsonDic objectForKey:@"comments_count"] integerValue];
    res.attitudeCount = [[jsonDic objectForKey:@"attitudes_count"] integerValue];
    
    res.isLongText = [[jsonDic objectForKey:@"isLongText"] boolValue];
    
    
    NSMutableArray* urlArray = [[NSMutableArray alloc] init];
    
    NSArray* urls = [jsonDic objectForKey:@"pic_urls"];
    
    for (id temp  in urls) {
        NSString* thumbnail = [temp objectForKey:@"thumbnail_pic"];
        
        [urlArray addObject:thumbnail];
    }
    
    res.picurl = urlArray;
    
    
    
    res.thumnailPic = [jsonDic objectForKey:@"thumbnail_pic"];
    res.bminddlePic = [jsonDic objectForKey:@"bmiddle_pic"];
    res.originalPic = [jsonDic objectForKey:@"original_pic"];
    
    return res;
}

+ (NSMutableArray*) parseToStatusArray:(id)jsonDic{
    
    NSMutableArray* res = [[NSMutableArray alloc] init];
    
    NSArray* statuses = [jsonDic objectForKey:@"statuses"];
    
    for (id temp in statuses) {
        Status* tempStatus = [self parseJsonData:temp];
        [res addObject:tempStatus];
    }
    
    return res;
}

- (id) copyWithZone:(NSZone *)zone{
    Status *newModel = [[[self class] allocWithZone:zone] init];
    
    newModel.user = [self user];
    
    newModel.sId = [self sId];
    newModel.text = [self text];
    newModel.souce = [self souce];
    newModel.timeCreated = [self timeCreated];
    
    newModel.releateStatus = [self releateStatus];
    newModel.repostCount = [self repostCount];
    newModel.commentsCount = [self commentsCount];
    newModel.attitudeCount = [self commentsCount];
    newModel.isLongText = [self isLongText];
    
    newModel.picurl =[self picurl];
    newModel.thumnailPic = [self thumnailPic];
    newModel.bminddlePic = [self bminddlePic];
    newModel.originalPic = [self originalPic];
    
    return newModel;
    
}
@end
