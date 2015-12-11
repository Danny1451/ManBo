//
//  DBUtils.h
//  TPOneClient
//
//  Created by 刘旦 on 15/12/9.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Status.h"
@interface DBUtils : NSObject

+ (instancetype) shareInstance;

- (BOOL) insertStatus:(Status *) stat;

- (BOOL) insertStatusArray:(NSArray *) stats;

- (NSMutableArray *) getStatus;
@end
