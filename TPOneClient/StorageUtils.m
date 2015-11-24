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
        
        isFromSelf = NO;
    }
    
    return sInstance;
    
}

@end
