//
//  DatabaseManager.m
//  Oath
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "DatabaseManager.h"
#import "RequestAPI.h"
#import "AccountObject.h"
#import "Define.h"

@interface DatabaseManager () {
}

@end

@implementation DatabaseManager

static DatabaseManager* dbInstance = nil;
+ (DatabaseManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbInstance = [[DatabaseManager alloc] init];
    });
	return dbInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)parseDataLogin: (id)User {
    
    AccountObject *account = [[AccountObject alloc] initWithDictionary: User error:nil];
    return account;
}

+ (id)parseObjectWithApiType:(int)apiType dataResult:(id)JSON
{
    switch (apiType) {
        case API_TYPE_LOGIN:
        case API_TYPE_REGISTRATION:
        case API_TYPE_LOGIN_VIA_SOCIAL:
        {
            NSDictionary *User = (NSDictionary*)JSON;
            if (User)
            {
                AccountObject *account = [[AccountObject alloc] initWithDictionary: User error:nil];
                return account;
            }
        }
            break;

        case API_TYPE_GET_PROFILE:
        case API_TYPE_UPDATE_PROFILE:
        case API_TYPE_ADD_RECIPE:
        case API_TYPE_ADD_FOOD:
        case API_TYPE_GET_RECIPE_DETAIL:
        case API_TYPE_UPDATE_RECIPE:
        case API_TYPE_UPDATE_FOOD:
        case API_TYPE_GET_CATEGORY_RECIPE:
        case API_TYPE_GET_LIST_RECIPE:
        case API_TYPE_GET_MY_RECIPE:
        case API_TYPE_GET_DISCOVER:
        default:
            break;
    }
    
    return nil;
}

@end
