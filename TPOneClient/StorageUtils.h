//
//  StorageUtils.h
//  TPOneClient
//
//  Created by 刘旦 on 15/11/24.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StorageUtils : NSObject

@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, strong) NSString* uid;

+ (id) shareInstance;

- (void) writeToken:(NSString*) token;
- (NSString*) readToken;


- (void) writeUid:(NSString*) token;
- (NSString*) readUid;
@end
