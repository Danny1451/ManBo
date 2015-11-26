//
//  HttpUtils.m
//  TPOneClient
//
//  Created by 刘旦 on 15-11-24.
//  Copyright (c) 2015年 炫彩互动网络科技有限公司. All rights reserved.
//


#import "HttpUtils.h"
#import "AFNetworking.h"
#import "UserInfo.h"

@implementation HttpUtils



//私有的Get方法
+ (void) requestGetWithDic:(NSDictionary *) params
                       url:(NSString *) url
                  Callback:(ReqBlock) callback{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
    
    //设置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //设置接收格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", nil];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        TRACE(@"Request  : %@", operation.request);
        TRACE(@"Result   : %@", responseObject);
        
        id erro = [responseObject objectForKey:ERROR_CODE_KEY];
        
        if (![erro isEqual:[NSNull null]]) {
            //有附加加上code
            
            NSInteger rescode = [erro integerValue] ;
            
            callback(rescode,responseObject);
            
        }else{
            callback(CODE_OK,responseObject);
        }
        
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TRACE(@"Net Erro : %@", error);
        callback(CODE_ERROR,nil);
    }];
}


+ (void) requestUserInfoAccessToken: (NSString*) token
                                uid: (NSString*) uid
                           callback: (ReqBlock) callback{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    
    [params setValue:token forKey:@"access_token"];
    [params setValue:uid forKey:@"uid"];
    
    NSString *url = [NSString stringWithFormat:URL_HEAD,URL_HOST,URL_USER_INFO];
    
    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
        
        if (resultCode == CODE_OK) {
            
            UserInfo *info = [UserInfo parseJsonData:resultObj];
            callback(CODE_OK, info);
            
        }else{
            
            callback(resultCode,nil);
        }
        
        
        
        
        
    }];
    
}

//+ (void) requestInitCallback:(ReqBlock)callback{
// 
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    
//    [params setValue:SDK_FROM forKey:@"fromer"];
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_INIT];
//    
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        if(resultCode == CODE_OK) {
//            
//            id ext = [resultObj objectForKey:@"ext"];
//            
//            callback(CODE_OK, ext);
//        }else{
//            callback(CODE_ERROR,nil);
//        }
//    }];
//    
//
//}
//
//+ (void) requestOauthWithUserName: (NSString*) userName
//                         password: (NSString*) password
//                          captcha: (NSString*) cap
//                            ckKey: (NSString*) key
//                        loginType: (NSString*) type
//                         callback: (ReqBlock) callback {
//    NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//     NSString *openudid = [EGUOpenUDID value];
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:@"password" forKey:@"grant_type"];
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    [params setValue:SDK_CLIENT_SECRET forKey:@"client_secret"];
//    [params setValue:userName forKey:@"username"];
//    [params setValue:password forKey:@"password"];
//    [params setValue:type forKey:@"login_type"];
//    [params setValue:SDK_FROM forKey:@"fromer"];
//    
//    [params setValue:identifierForAdvertising forKey:@"idfa"];
//    [params setValue:openudid forKey:@"openudid"];
//
//    
//    if (!strIsEmpty(key)) {
//        [params setValue:EGAME_USER_SDK_VERSION_STR forKey:@"vc"];
//        [params setValue:key forKey:@"ck"];
//        [params setValue:cap forKey:@"captcha"];
//    }
//    
//    
//    
//    
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_ACCESS_TOKEN];
//
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        EGUOauth2AccessToken *token = [EGUOauth2AccessToken parseJsonData:resultObj];
//        if([token accessToken] == nil) {
//            callback([[resultObj objectForKey:@"code"] intValue], token);
//            return;
//        }
//        
//        callback(CODE_OK, token);
//    }];
//    
//    
//}
//
//+ (void) requestSsoWithClientId: (NSString*) clientId
//                      rootToken: (NSString*) rootToken
//                       callback: (ReqBlock) callback {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:@"code" forKey:@"response_type"];
//    [params setValue:clientId forKey:@"client_id"];
//    [params setValue:rootToken forKey:@"token"];
//    [params setValue:SDK_FROM forKey:@"fromer"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_SSO];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//            return ;
//        }
//        
//        NSString *ssoCode = [[resultObj objectForKey:@"ext"] objectForKey:@"code"];
//        callback(CODE_OK, ssoCode);
//        
//    }];
//    
//    
//    
//
//}
//
//+ (void) requestCheckExistWithPhone: (NSString*) phoneNumber
//                      callback: (ReqBlock) callback {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:phoneNumber forKey:@"user_account"];
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_CHECK_ACCOUNT];
//
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//            return ;
//        }
//        
//        int exist = [[[resultObj objectForKey:@"ext"] objectForKey:@"is_exist"] intValue];
//        if(exist == 1) {
//            callback(CODE_OK, BOOL_YES);
//        } else {
//            callback(CODE_OK, BOOL_NO);
//        }
//    }];
//    
//
//}
//
//+ (void) requestValidateCodeWithPhone: (NSString*) phoneNumber
//                                 type: (NSString *) type
//                           callback: (ReqBlock) callback {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:phoneNumber forKey:@"phone"];
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    [params setValue:type forKey:@"type"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_GET_CODE];
//
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//        } else {
//            callback(CODE_OK, nil);
//        }
//    }];
//    
//}
//
//+ (void) requestVerifyWithCode: (NSString*) validateCode
//                         phone: (NSString*) phoneNumber
//                          type: (NSString *) type
//                      callback: (ReqBlock) callback {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:validateCode forKey:@"check_code"];
//    [params setValue:phoneNumber forKey:@"phone"];
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    [params setValue:type forKey:@"type"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_VERIFY_CODE];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//        } else {
//            BOOL result = [[[resultObj objectForKey:@"ext"] objectForKey:@"main"] boolValue];
//            if(result) {
//                callback(CODE_OK, BOOL_YES);
//            } else {
//                callback(CODE_OK, BOOL_NO);
//            }
//        }
//
//        
//    }];
//    
//}
//
//+ (void) requestRegisterWithPhone: (NSString*) phoneNumber
//                         password: (NSString*) password
//                     validateCode: (NSString*) validateCode
//                         callback: (ReqBlock) callback {
//    NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//
//    NSString *openudid = [EGUOpenUDID value];
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    [params setValue:phoneNumber forKey:@"username"];
//    [params setValue:password forKey:@"password"];
//    [params setValue:SDK_FROM forKey:@"fromer"];
//    [params setValue:identifierForAdvertising forKey:@"idfa"];
//    [params setValue:openudid forKey:@"openudid"];
//    [params setValue:validateCode forKey:@"check_code"];
//
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_REGISTER];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//        } else {
//            callback(CODE_OK, nil);
//        }
//        
//    }];
//    }
//
//+ (void) requestCheckValidWithPhone:(NSString *)phoneNumber
//                           callback:(ReqBlock)callback {
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:phoneNumber forKey:@"user_account"];
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_CHECK_ACCOUNT];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//            return ;
//        }
//        
//        int exist = [[[resultObj objectForKey:@"ext"] objectForKey:@"is_exist"] intValue];
//        if(exist == 1) {
//            callback(CODE_OK, BOOL_YES);
//        } else {
//            callback(CODE_OK, BOOL_NO);
//        }
//    }];
//    }
//
//+ (void) requestUserInfoWithRootToken:(NSString *)rootToken
//                               userId:(NSString *)userId
//                             callback:(ReqBlock)callback{
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:rootToken forKey:@"access_token"];
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    [params setValue:userId forKey:@"uids"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_GET_INFO];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        EGUUserInfo *info = [EGUUserInfo parseJsonData:resultObj];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//            return ;
//        }
//        
//        callback(CODE_OK,info);
//    }];
//    
//}
//+ (void) requestCheckVisitorWithCallback:(ReqBlock)callback{
//    
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//    NSString *openUdid = [EGUOpenUDID value];
//    
//    [params setValue:openUdid forKey:@"major_device"];
//    [params setValue:identifierForAdvertising  forKey:@"minor_device"];
//    [params setValue:SDK_FROM forKey:@"fromer"];
//    [params setValue:@"2" forKey:@"type"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_CHECK_VISITOR_ACCONUT];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            
//            callback(code, nil);
//            
//        } else {
//            id ext = [resultObj objectForKey:@"ext"];
//            
//            int isSame = [[ext objectForKey:@"is_same"] intValue];
//            
//            int restMajor = [[ext objectForKey:@"result_major"] intValue];
//            
//            int restMinor = [[ext objectForKey:@"result_minor"] intValue];
//            
//            NSString *username = @"";
//            
//            int result = VISITOR_STATE_UNEXIST;
//            if (isSame == 1) {
//                
//                if (restMajor == 2) {
//                    username = [ext objectForKey:@"username_major"];
//                    result = VISITOR_STATE_EXIST;
//                }
//                
//            }else{
//                
//                if (restMinor == 2) {
//                    username = [ext objectForKey:@"username_minor"];
//                    result = VISITOR_STATE_EXIST;
//                }
//                
//                if (restMajor == 2) {
//                    username = [ext objectForKey:@"username_major"];
//                    result = VISITOR_STATE_EXIST;
//                }
//                
//                
//                
//            }
//            
//            callback(result, username);
//            
//        }
//        
//    }];
//
//}
//
//+ (void) requestRegisterWithUserName:(NSString *)name password:(NSString *)pwd callback:(ReqBlock)callback{
//    
//    NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//    NSString *openUdid = [EGUOpenUDID value];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    
//    [params setValue:SDK_CLIENT_ID forKey:@"client_id"];
//    [params setValue:name forKey:@"username"];
//    [params setValue:pwd forKey:@"password"];
//    [params setValue:SDK_FROM forKey:@"fromer"];
//    [params setValue:identifierForAdvertising forKey:@"idfa"];
//    [params setValue:openUdid forKey:@"openudid"];
//    //[params setValue:validateCode forKey:@"check_code"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_REGISTER];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//        } else {
//            callback(CODE_OK, nil);
//        }
//        
//    }];
// }
//
//+ (void)requestUserName:(ReqBlock)callback{
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    
//    [params setValue:SDK_FROM forKey:@"fromer"];
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_GET_USER_NAME];
//
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            
//            callback(code, nil);
//            
//        } else {
//            
//            NSString* name = [[resultObj objectForKey:@"ext"] valueForKey:@"egame_name"];
//            
//            callback(CODE_OK, name);
//        }
//        
//    }];}
//
//+ (void)requestBoardInfoWithClientId:(NSString *)clentId
//                         requestTime:(long long)time
//                            callback:(ReqBlock)callback{
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:clentId forKey:@"client_id"];
//    [params setValue:@"2" forKey:@"platform"];
//    [params setValue:[NSString stringWithFormat:@"%d",EGAME_USER_SDK_VERSION_INT]forKey:@"vc"];
//    
//    
//    
//    
//    [params setValue:[NSString stringWithFormat:@"%lli",time]forKey:@"request_time"];
//    
//
//    NSString *url = [NSString stringWithFormat:URL_HEAD, BULLET_HOST, URL_BOARD_INFO];
//
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            
//            callback(code, nil);
//            
//        } else {
//            
//            
//            callback(CODE_OK, resultObj);
//        }
//
//        
//    }];
//    
//  
//}
//
//
//+ (void)requestUpgradeAccountPhone:(NSString *)phone
//                          password:(NSString *)pwd
//                       accessToken:(NSString *)token
//                      validateCode:(NSString*) validateCode
//                          callback:(ReqBlock)callback{
//    
//    NSString *identifierForAdvertising = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
//    NSString *openUdid = [EGUOpenUDID value];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:token forKey:@"access_token"];
//    [params setValue:phone forKey:@"phone"];
//    [params setValue:pwd forKey:@"password"];
//    [params setValue:SDK_FROM forKey:@"fromer"];
//    [params setValue:validateCode forKey:@"check_code"];
//    [params setValue:@"2" forKey:@"type"];
//    
//    //修改为idfa为device_no   openudid 为 imsi
//    [params setValue:identifierForAdvertising forKey:@"device_no"];
//    [params setValue:openUdid forKey:@"imsi"];
//    
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_UPGRADE_ACCOUNT];
//
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            callback(code, nil);
//        } else {
//            callback(CODE_OK, nil);
//        }
//    }];
//    
//
//}
//
//+ (void)requestImageValidateCodeWithClientId:(NSString *)clientId
//                                    callback:(ReqBlock)callback{
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:clientId forKey:@"client_id"];
//    
//    
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_IMAGE_CODE];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            
//            callback(code, nil);
//            
//        } else {
//            
//            id  extObj = [resultObj objectForKey:@"ext"];
//            NSString* capKay = [extObj objectForKey:@"captcha_key"];
//            //传入随机码
//            callback(CODE_OK, capKay);
//        }
//    }];
//    
//
//}
//
//+ (void) reuqestImageValidateCodeConfirm:(NSString *)code
//                                clientId:(NSString *)clientId
//                                     key:(NSString *)key
//                                callback:(ReqBlock)callback{
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [params setValue:clientId forKey:@"client_id"];
//    [params setValue:code forKey:@"check_code"];
//    [params setValue:key forKey:@"r"];
//    
//    
//    NSString *url = [NSString stringWithFormat:URL_HEAD, OPEN_PLAY_CN_HOST, URL_IMAGE_CODE_CHECK];
//    
//    [self requestGetWithDic:params url:url Callback:^(int resultCode, id resultObj) {
//        
//        int code = [[resultObj objectForKey:@"code"] intValue];
//        
//        if(code != CODE_OK) {
//            
//            callback(code, nil);
//            
//        } else {
//            
//            id  extObj = [resultObj objectForKey:@"ext"];
//            int result = [[extObj objectForKey:@"result_code"] intValue];
//            //传入随机码
//            
//            NSNumber *nsresult = [[NSNumber alloc]initWithInt:result];
//            callback(CODE_OK, nsresult);
//        }
//    }];
//    
//}
@end
