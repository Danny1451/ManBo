//
//  StorageUtils.m
//  TPOneClient
//
//  Created by 刘旦 on 15/11/24.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "StorageUtils.h"

static StorageUtils *sInstance;

@implementation StorageUtils

BOOL isFromSelf = NO;

+ (id) shareInstance{
    
    if (sInstance == nil) {
        isFromSelf = YES;
        
        sInstance = [[StorageUtils alloc] init];
        
        [sInstance readToken];
        [sInstance readUid];
        
        isFromSelf = NO;
    }
    
    return sInstance;
    
}

- (void)writeToken:(NSString *)token{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    _accessToken = token;
    [defaults setObject:token forKey:@"access_token"];
    [defaults synchronize];
}

- (NSString*)readToken{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    _accessToken = [defaults objectForKey:@"access_token"];
    return _accessToken;
}

- (void)writeUid:(NSString *) uid{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    _uid = uid;
    [defaults setObject:uid forKey:@"uid"];
    [defaults synchronize];
}
- (NSString*)readUid{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    _uid = [defaults objectForKey:@"uid"];
    return _uid;
}

@end
