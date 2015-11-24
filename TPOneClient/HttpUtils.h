//
//  HttpUtils.m
//  TPOneClient
//
//  Created by 刘旦 on 15-11-24.
//  Copyright (c) 2015年 炫彩互动网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtils : NSObject

#define CODE_OK 0
#define CODE_ERROR -1
#define CODE_ACCOUNT_NOT_EXIST -211
#define CODE_ACCOUNT_OR_PASSWORD_ERROR -219
#define CODE_TOKEN_INVALID -261

#define CODE_VERTIFY_ERRO -230

#define CODE_ACCOUNT_REGISTERED -202
#define CODE_ACCOUNT_BINDED -216

#define CODE_IMAGE_CODE_REQUIRED -275
#define CODE_IMAGE_CODE_LIMITED -276
#define CODE_IMAGE_CODE_WRONG -277
#define CODE_IMAGE_CODE_FAST -278


#define ERROR_CODE_KEY @"error_code"

#define BOOL_YES @"YES"
#define BOOL_NO @"NO"

//#define URL_HEAD @"https://%@%@"
#define URL_HEAD @"http://%@%@"

//#define OPEN_PLAY_CN_HOST @"192.168.251.64"
//#define OPEN_PLAY_CN_HOST @"192.168.251.51:8101"
//#define OPEN_PLAY_CN_HOST @"202.102.39.20:8101"
#define URL_HOST @"api.weibo.com"

//#define BULLET_HOST @"open.play.cn"
#define BULLET_HOST @"192.168.251.68"

#define URL_USER_INFO @"/2/users/show.json"


#define URL_INIT @"/api/v1/user/common/get_parameter.json"
#define URL_ACCESS_TOKEN @"/oauth/access_token"
#define URL_SSO @"/oauth/sdk_login"
#define URL_CHECK_ACCOUNT @"/api/v1/user/check_account.json"
#define URL_GET_CODE @"/api/v1/user/valid/get_code.json"
#define URL_VERIFY_CODE @"/api/v1/user/valid/verify_code.json"
#define URL_REGISTER @"/api/v1/user/register.json"
#define URL_CHECK_PHONE @"/api/v1/user/valid/phone/format.json"
#define URL_GET_INFO @"/api/v1/user/info.json"
#define URL_GET_USER_NAME @"/api/v1/user/info/get_user_name.json"
#define URL_CHECK_VISITOR_ACCONUT @"/api/v1/user/common/check_account.json"
#define URL_UPGRADE_ACCOUNT @"/api/v1/user/upgrade/bind.json"
#define URL_BOARD_INFO @"/api/v2/egame/online_sdk/bulletin.json"
#define URL_IMAGE_CODE @"/api/v1/user/captcha/key/get.json"
#define URL_IMAGE_CODE_GET @"/api/v1/user/captcha/get?"
#define URL_IMAGE_CODE_CHECK @"/api/v1/user/captcha/key/check.json"

#define LOGIN_TYPE_NAMORL @"3"
#define LOGIN_TYPE_VISITOR @"12"

#define VISITOR_STATE_UNEXIST 1000
#define VISITOR_STATE_EXIST 1001

typedef void(^ReqBlock)(int resultCode, id resultObj);


//@property(nonatomic, copy) NSString *finalUrl;


+ (void) requestUserInfoAccessToken: (NSString*) token
                                uid:(NSString* ) uid
                           callback: (ReqBlock) callback;


@end
