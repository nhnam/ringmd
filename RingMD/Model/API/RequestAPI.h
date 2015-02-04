//
//  RequestAPI.h
//  Oath
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

typedef enum {
    API_TYPE_LOGIN,
    API_TYPE_LOGOUT,
    API_TYPE_REGISTRATION,
    API_TYPE_FORGOT_PASS,
    API_TYPE_LOGIN_VIA_SOCIAL,
    API_TYPE_CHECK_USERNAME,
    API_TYPE_CHECK_EMAIL,
    API_TYPE_GET_PROFILE,
    API_TYPE_UPDATE_PROFILE,
    API_TYPE_ADD_RECIPE,
    API_TYPE_ADD_FOOD,
    API_TYPE_GET_RECIPE_DETAIL,
    API_TYPE_UPDATE_RECIPE,
    API_TYPE_UPDATE_FOOD,
    API_TYPE_GET_CATEGORY_RECIPE,
    API_TYPE_REPORT_RECIPE,
    API_TYPE_GET_LIST_RECIPE,
    API_TYPE_GET_DISCOVER,
    API_TYPE_GET_MY_RECIPE,
    API_TYPE_NUM
} API_TYPE;

@interface RequestAPI : NSObject

//+ (instancetype)sharedClient;

+ (void)request:(int)type paramsGet:(NSString *)link paramsPost:(NSDictionary *)parameters
                            success:(void (^)(AFHTTPRequestOperation *operation, id JSON))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)cancelAllRequest;

@end
