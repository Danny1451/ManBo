//
//  AppDelegate.h
//  TPOneClient
//
//  Created by 刘旦 on 15/11/6.
//  Copyright © 2015年 刘旦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WeiboSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>{
    NSString* wbtoken;
    NSString* wbCurrentUserID;
}

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
@property (strong, nonatomic) NSString *wbRefreshToken;

@end

