//
//  CommonUtils.m
//  TPOneClient
//
//  Created by 刘旦 on 15/12/10.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

+(NSString*) dataToString:(id)object{
    
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (id) stringToData:(NSString *)string{
    
    
    NSError *jsonError;
    NSData *objectData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&jsonError];
    
    if (! json) {
        NSLog(@"Got an error: %@", jsonError);
        return nil;
    } else {
        return json;
    }
    
    
}

+ (NSString*) sinaDateToTargetDate:(NSString *) sinaStr target:(NSString*) target{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"EEE MMM dd HH:mm:ss zzz yyyy"];
    
    [df setLocale:[NSLocale localeWithLocaleIdentifier:@"en"]];
    NSDate *des = [df dateFromString:sinaStr];
    
    
    [df setDateFormat:target];
    
    NSString* newStr = [df stringFromDate:des];
    
    return newStr;
    
}

+ (NSString*)picUrl:(NSString*) source Format:(PicFormat) type{

    NSString* replace;
    switch (type) {
        case PicBmiddle:
            replace = @"bmiddle";
            break;
        case PicOriginal:
            replace = @"large";
            break;
        case PicThumbnail:
            return source;
            break;
        default:
            break;
    }
    
    return [source stringByReplacingOccurrencesOfString:@"thumbnail" withString:replace];
}
@end
