//
//  CommonUtils.h
//  TPOneClient
//
//  Created by 刘旦 on 15/12/10.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    //小图
    PicThumbnail=0,
    
    //中等
    PicBmiddle,
    
    //原图
    PicOriginal,
    
    
}PicFormat;
@interface CommonUtils : NSObject

+ (NSString *) dataToString:(id) object;
+ (id) stringToData:(NSString *) string;


+ (NSString*) sinaDateToTargetDate:(NSString *) sinaStr target:(NSString*) target;


+ (NSString*) picUrl:(NSString*) source Format:(PicFormat) type;
@end
