//
//  DBUtils.m
//  TPOneClient
//
//  Created by 刘旦 on 15/12/9.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "DBUtils.h"
#import <FMDB.h>
#import "CommonUtils.h"

#define DB_STATUS  @"status.sqlite"
#define DB_USER @"user.sqlite"
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface DBUtils()

@property (nonatomic,retain) NSString* dbPath;

@end

@implementation DBUtils

+ (instancetype)shareInstance{
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance initDB];
    });
    
    return sharedInstance;
    
}


- (void) initDB{
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    
    NSString * doc = PATH_OF_DOCUMENT;
    NSString * path = [doc stringByAppendingPathComponent:DB_STATUS];
    self.dbPath = path;
    if ([fileManager fileExistsAtPath:self.dbPath]) {
        //create db
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        
        if ([db open]) {
            NSString * sql = @"create table if not exists t_status ( statusid long long PRIMARY KEY NOT NULL , status text , userid long long )";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                TRACE(@"error when creating db table");
            }else{
                TRACE(@"create success");
            }
            
            [db close];
            
        }else{
            TRACE(@"error when open db");
        }
        
    }
    
    
    
    
}

- (BOOL) insertStatusArray:(NSArray *)stats{
    
    BOOL res = NO;
    
    for (id temp in stats) {
        
        if ([self insertStatus:temp]) {
            res = YES;
        }
        
    }
    
    return res;
    
}

- (BOOL) insertStatus:(Status *) status{
    
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString* sql = @"insert into 't_status' ( statusid, status, userid) values(?, ?, ?) ";
        NSNumber* sid = [NSNumber numberWithLongLong:status.sId];
        NSString* sjson = status.json;
        NSNumber* uid = [NSNumber numberWithLongLong:status.user.uid];
        BOOL res = [db executeUpdate:sql, sid , sjson, uid];
        if (!res) {
            TRACE(@"erro to insert data");
        }else{
            TRACE(@"succ to insert data");
        }
        [db close];
        return res;
        
    }
    
    return NO;
}

- (NSMutableArray *) getStatus{
    
    NSMutableArray* resArray = [[NSMutableArray alloc] init];
    
    FMDatabase *db =[FMDatabase databaseWithPath:self.dbPath];
    
    if ([db open]) {
        
        
        
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_status ORDER BY statusid DESC"];
        
        while ([rs next]) {
            NSString *status = [rs stringForColumn:@"Status"];
            
            Status* stat = [Status parseJsonData:[CommonUtils stringToData:status]];
            
            [resArray addObject:stat];
        }
    }
    [db close];
    
    return resArray;
}
@end
