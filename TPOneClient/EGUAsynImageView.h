//
//  AsynImageView.h
//  openudidtest
//
//  Created by 刘旦 on 15/8/28.
//  Copyright (c) 2015年 egame. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NSURL_CACHE_SIZE 1*1024*1024

@interface EGUAsynImageView : UIImageView{
    NSMutableData *loadData;
    NSURLConnection *connection;
}

@property (nonatomic, retain) NSString *fileName;

@property (nonatomic, retain) UIImage *placeholderImage;

@property (nonatomic, retain) NSString *imageUrl;


- (void) setImageUrlWithOutCache:(NSString *)imageUrl;
@end
