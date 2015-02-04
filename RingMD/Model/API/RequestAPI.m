//
//  RequestAPI.m
//  Oath
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "RequestAPI.h"
#import "Define.h"
#import "GeneralFunctions.h"

static NSString * api_url[API_TYPE_NUM] = {
	@"api/v4/tokens.json",
    @"api/user/logout",
    @"api/user/register",
    @"api/user/forgotpassword",
    @"api/user/loginviasocial",
    @"api/user/checkusername",
    @"api/user/checkemail",
    @"api/user/getuserprofile",
    @"api/user/updateuserprofile",
    @"api/user/addrecipe",
    @"api/user/addrecipe",
    @"api/user/getrecipedetails",
    @"api/user/updaterecipe",
    @"api/user/updaterecipe",
    @"api/user/getrecipecategory",
    @"api/user/reportrecipe",
    @"api/user/getrecipelist",
    @"api/user/getdiscoverscreen",
    @"api/user/getmyrecipelist"
};

typedef enum {
    GET     = 0,
    POST    = 1,
    PUT     = 2,
    PATCH   = 3,
    DELETE  = 4
}RequestType;

@implementation RequestAPI

static AFHTTPRequestOperationManager *_sharedManager = nil;

+ (AFHTTPRequestOperationManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return _sharedManager;
}

//+ (instancetype)sharedClient {
//    static RequestAPI *_sharedClient = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedClient = [[RequestAPI alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
//        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
//    });
//    return _sharedClient;
//}

+ (RequestType)requestType:(int )type
{
    RequestType requestType = POST;
    switch (type)
    {
    }
    return requestType;
}

+ (NSString *)urlRequestWithType:(int )type linkParamater:(NSString *)urlLink
{
    NSString *UrlStr = [NSString stringWithFormat:@"%@/%@",API_SERVER_ROOT_URL,api_url[type]];
    if (urlLink)
        UrlStr = [NSString stringWithFormat:@"%@%@",UrlStr,urlLink];
    DLog(@"Link request : %@", UrlStr);
    return UrlStr;
}

+ (void)request:(int)type paramsGet:(NSString *)link paramsPost:(NSDictionary *)parameters
        success:(void (^)(AFHTTPRequestOperation *operation, id JSON))success
        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    RequestType requestType = [self requestType:type];
    NSString *linkURL = [self urlRequestWithType:type linkParamater:link];

    AFHTTPRequestOperationManager *manager = [self sharedManager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setTimeoutInterval: 60];
        
    AFHTTPRequestOperation *anOperation;
    
    switch (requestType)
    {
        case GET:
        {
            anOperation = [manager GET:linkURL
                            parameters:parameters
                               success:^(AFHTTPRequestOperation *operation, id JSON) {
                if (success) {
                    success(operation,JSON);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(operation,error);
                }
            }];
        }
                break;
        case POST:
        {
            anOperation = [manager POST:linkURL
                             parameters:parameters
                                success:^(AFHTTPRequestOperation *operation, id JSON)
            {
                if (success) {
                    success(operation,JSON);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(operation,error);
                }
            }];
        }
               break;
        case PUT:
        {
            anOperation = [manager PUT:linkURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
                if (success) {
                    success(operation,JSON);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(operation,error);
                }
            }];
        }
            break;
            
        case PATCH:
        {
            anOperation = [manager PATCH:linkURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
                if (success) {
                    success(operation,JSON);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(operation,error);
                }
            }];
        }
            break;
        case DELETE:
        {
            anOperation = [manager DELETE:linkURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
                if (success) {
                    success(operation,JSON);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(operation,error);
                }
            }];
        }
            break;
        default:
            break;
    }
    
}

+ (void)cancelAllRequest {

    AFHTTPRequestOperationManager *manager = [self sharedManager];
    [manager.operationQueue cancelAllOperations];
}

@end
