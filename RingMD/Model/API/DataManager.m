//
//  DataManager.m
//  Oath
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "DataManager.h"
#import "Define.h"
#import "RequestAPI.h"
#import "SBJson4Writer.h"
#import "DatabaseManager.h"
#import "GeneralFunctions.h"

@interface DataManager () {
    NSMutableArray *arrayRunningService;
}

@end

@implementation DataManager

static DataManager* gInstance = nil;

+ (DataManager *)shareInstance
{
    if( !gInstance )
	{
		gInstance = [[DataManager alloc] init];
	}
	return gInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        arrayRunningService = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Login
- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
                completed:(void (^)( id object, NSString *message)) completedBlock
                   failed:(void (^)(NSString *error))failBlock
{

    
    @try {
        NSDictionary *dicParamaters = @{@"email": username,
                                        @"password": password};

        [self processRequestWithType:API_TYPE_LOGIN
                          postParmas:dicParamaters
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark -Logout
- (void)logoutWithcompleted:(void (^)( id object, NSString *message))completedBlock
                     failed:(void (^)(NSString *error))failBlock {
    @try
    {
        [self processRequestWithType:API_TYPE_LOGOUT
                          postParmas:nil
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
        
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Register 
- (void)registerWithUsername:(NSString *)username
                   password:(NSString *)password
                 phonenumber:(NSString *)phonenumber
                 phoneArea:(NSString *)phoneArea
                      email:(NSString *)email
                  completed:(void (^)( id object, NSString *message))completedBlock
                     failed:(void (^)(NSString *error))failBlock {
    @try {
        NSDictionary *dicParamaters = @{@"email" : email,
                                        @"full_name" : username,
                                        @"password" : password,
                                        @"phone_code" : phoneArea,
                                        @"phone_raw_number" : phonenumber,
                                        @"role" : @"patient",
                                        @"agree_on_terms" :[NSNumber numberWithBool:YES]
                                        };
        NSDictionary *userParam = @{@"user":dicParamaters};
        DLog(@"\nParamaters : %@", userParam);
        [self processRequestWithType:API_TYPE_REGISTRATION
                          postParmas:userParam
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
       
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Forgot Password
- (void)forgotPasswordWithEmail:(NSString *)email
                      completed:(void (^)( id object, NSString *message))completedBlock
                         failed:(void (^)(NSString *error))failBlock {
    @try
    {
        NSDictionary *params=@{@"email_id":email};
        [self processRequestWithType:API_TYPE_FORGOT_PASS
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Login Via Social
- (void)loginViaSocialType:(NSString *)social_type
                  socialID:(NSString *)social_id
                     email:(NSString *)email
                      name:(NSString *)name
                 completed:(void (^)( id object, NSString *message))completedBlock
                    failed:(void (^)(NSString *error))failBlock {
    
    @try {
        NSDictionary *dicParamaters = @{@"social_media_type": social_type,
                                        @"id": social_id,
                                        @"email_id": email,
                                        @"name": name,
                                        @"device_id" : deviceUdid(),
                                        @"device_type" : @"i"
                                        };
        
        [self processRequestWithType:API_TYPE_LOGIN_VIA_SOCIAL
                          postParmas:dicParamaters
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Check Username
- (void)checkUsername:(NSString *)username
                      completed:(void (^)( id object, NSString *message))completedBlock
                         failed:(void (^)(NSString *error))failBlock {
    @try
    {
        NSDictionary *params=@{@"username":username};
        [self processRequestWithType:API_TYPE_CHECK_USERNAME
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Check Email
- (void)checkEmail:(NSString *)email
            completed:(void (^)( id object, NSString *message))completedBlock
               failed:(void (^)(NSString *error))failBlock {
    @try
    {
        NSDictionary *params=@{@"email_id":email};
        [self processRequestWithType:API_TYPE_CHECK_EMAIL
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Get Profile
- (void)getProfile:(NSString *)user
         completed:(void (^)( id object, NSString *message))completedBlock
            failed:(void (^)(NSString *error))failBlock {
    
    @try
    {
        NSDictionary *params=@{@"user_id":user};
        [self processRequestWithType:API_TYPE_GET_PROFILE
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Update Profile
- (void)updateProfileWithUser:(NSString *)user_id
                        email:(NSString *)email
                     password:(NSString *)password
                     fullname:(NSString *)fullname
               profile_status:(NSString *)profile_status
                      country:(NSString *)country
        profile_image: (NSData *)profile_data
          cover_image: (NSData *)cover_data
            completed:(void (^)( id object, NSString *message))completedBlock
               failed:(void (^)(NSString *error))failBlock {
    
    @try
    {
        NSDictionary *params = @{@"user_id": user_id,
                                 @"email_id": email,
                                 @"password": password,
                                 @"full_name": fullname,
                                 @"profile_status" : profile_status,
                                 @"country" : country,
                                 @"profile_image": profile_data,
                                 @"cover_image": cover_data
                                 };

        [self processRequestWithType:API_TYPE_UPDATE_PROFILE
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Add Recipe
- (void)addRecipeWithUser:(NSString *)user_id
                     type:(NSString *)type
                     name:(NSString *)name
                 category:(NSString *)category
                 duration:(NSString *)duration
                    steps:(NSArray *)steps
              ingredients:(NSArray *)ingredients
                  caption:(NSString *)caption
             tagged_users:(NSArray *)tagged_users
            location_name:(NSString *)location_name
               imagePath1:(NSString *)imagePath1
               imagePath2:(NSString *)imagePath2
               imagePath3:(NSString *)imagePath3
               imagePath4:(NSString *)imagePath4
                videoPath:(NSString *)videoPath
           videoThumbnail:(NSString *)videoThumbnailPath
                completed:(void (^)( id object, NSString *message))completedBlock
                   failed:(void (^)(NSString *error))failBlock {

    @try
    {
        NSString *steps_json = @"";
        NSString *ingredients_json = @"";
        NSString *tagged_users_json = @"";
        SBJson4Writer *writer = [[SBJson4Writer alloc] init];

        if (steps)
            steps_json = [writer stringWithObject: steps];
        if (ingredients)
            ingredients_json = [writer stringWithObject: ingredients];
        if (tagged_users)
            tagged_users_json = [writer stringWithObject: tagged_users];

        NSDictionary *params = @{@"user_id": user_id,
                                 @"type": type,
                                 @"name": name,
                                 @"category": category,
                                 @"duration" : duration,
                                 @"steps" : steps_json,
                                 @"ingredients": ingredients_json,
                                 @"caption": caption,
                                 @"tagged_users": tagged_users_json,
                                 @"location_name": location_name,
                                 @"imagePath1": imagePath1,
                                 @"imagePath2": imagePath2,
                                 @"imagePath3": imagePath3,
                                 @"imagePath4": imagePath4,
                                 @"videoPath": videoPath,
                                 @"videoThumbnailPath" : videoThumbnailPath
                                 };
        
        [self processRequestWithType:API_TYPE_ADD_RECIPE
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%s: %@",__PRETTY_FUNCTION__,exception);
        failBlock([exception description]);
    }
}

#pragma mark - Get Recipe
- (void)getRecipeDetailWithUser:(NSString *)user_id
                   recipe:(NSString *)recipe_id
                completed:(void (^)( id object, NSString *message))completedBlock
                   failed:(void (^)(NSString *error))failBlock {
 
    @try
    {
        NSDictionary *params = @{@"user_id": user_id,
                                 @"recipe_id": recipe_id,
                                 };
        [self processRequestWithType:API_TYPE_GET_RECIPE_DETAIL
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Update Recipe
- (void)udpateRecipeWithUser:(NSString *)user_id
                      recipe:(NSString *)recipe_id
                        type:(NSString *)type
                        name:(NSString *)name
                    category:(NSString *)category
                    duration:(NSString *)duration
                       steps:(NSArray *)steps
                 ingredients:(NSArray *)ingredients
                     caption:(NSString *)caption
                tagged_users:(NSArray *)tagged_users
               location_name:(NSString *)location_name
                  media_type:(NSString *)media_type
                  imagePath1:(NSString *)imagePath1
                   image1_id:(NSString *)image1_id
                  imagePath2:(NSString *)imagePath2
                   image2_id:(NSString *)image2_id
                  imagePath3:(NSString *)imagePath3
                   image3_id:(NSString *)image3_id
                  imagePath4:(NSString *)imagePath4
                   image4_id:(NSString *)image4_id
                   videoPath:(NSString *)videoPath
                    video_id:(NSString *)video_id
              videoThumbnail:(NSString *)videoThumbnailPath
                   completed:(void (^)( id object, NSString *message))completedBlock
                      failed:(void (^)(NSString *error))failBlock {

    @try
    {
        NSString *steps_json = @"";
        NSString *ingredients_json = @"";
        NSString *tagged_users_json = @"";
        SBJson4Writer *writer = [[SBJson4Writer alloc] init];
        
        if (steps)
            steps_json = [writer stringWithObject: steps];
        if (ingredients)
            ingredients_json = [writer stringWithObject: ingredients];
        if (tagged_users)
            tagged_users_json = [writer stringWithObject: tagged_users];
        
        NSDictionary *params = @{@"user_id": user_id,
                                 @"recipe_id": recipe_id,
                                 @"type": type,
                                 @"name": name,
                                 @"category": category,
                                 @"duration" : duration,
                                 @"steps" : steps_json,
                                 @"ingredients": ingredients_json,
                                 @"caption": caption,
                                 @"tagged_users": tagged_users_json,
                                 @"location_name": location_name,
                                 @"media_type": media_type,
                                 @"imagePath1": imagePath1,
                                 @"image1_id": image1_id,
                                 @"imagePath2": imagePath2,
                                 @"image2_id": image2_id,
                                 @"imagePath3": imagePath3,
                                 @"image3_id": image3_id,
                                 @"imagePath4": imagePath4,
                                 @"image4_id": image4_id,
                                 @"videoPath": videoPath,
                                 @"video_id": video_id,
                                 @"videoThumbnailPath" : videoThumbnailPath
                                 };
        
        [self processRequestWithType:API_TYPE_UPDATE_RECIPE
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Get Category Of Recipe
- (void)getCategoryOfRecipe:(NSString *)user_id
                  completed:(void (^)( id object, NSString *message))completedBlock
                     failed:(void (^)(NSString *error))failBlock {
    
    @try
    {
        NSDictionary *params = @{@"user_id": user_id};
        [self processRequestWithType:API_TYPE_GET_CATEGORY_RECIPE
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Report A Recipe
- (void)reportRecipe:(NSString *)user_id
              recipe:(NSString *)recipe_id
         report_text:(NSString *)report
           completed:(void (^)( id object, NSString *message))completedBlock
              failed:(void (^)(NSString *error))failBlock {
    
    @try
    {
        NSDictionary *params = @{@"user_id": user_id,
                                 @"recipe_id": recipe_id,
                                 @"report_text": report
                                 };
        [self processRequestWithType:API_TYPE_REPORT_RECIPE
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Get List Recipe
- (void)getListRecipe:(NSString *)user_id
                 page:(int)page
            completed:(void (^)( id object, NSString *message))completedBlock
               failed:(void (^)(NSString *error))failBlock {
    
    @try
    {
        NSDictionary *params = @{@"user_id": user_id,
                                 @"page:": [NSNumber numberWithInt: page]};
        
        [self processRequestWithType:API_TYPE_GET_LIST_RECIPE
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Get Discover
- (void)getDiscover:(NSString *)user_id
         completed:(void (^)( id object, NSString *message))completedBlock
            failed:(void (^)(NSString *error))failBlock {
    
    @try
    {
        NSDictionary *params=@{@"user_id":user_id};
        [self processRequestWithType:API_TYPE_GET_DISCOVER
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Get My List Recipe
- (void)getMyListRecipe:(NSString *)user_id
                   page:(int)page
              completed:(void (^)( id object, NSString *message))completedBlock
                 failed:(void (^)(NSString *error))failBlock {
    
    @try
    {
        NSDictionary *params = @{@"user_id": user_id,
                                 @"page:": [NSNumber numberWithInt: page]};
        
        [self processRequestWithType:API_TYPE_GET_MY_RECIPE
                          postParmas:params
                           getParams:nil
                           completed:completedBlock
                              failed:failBlock];
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
}

#pragma mark - Process
- (void)processRequestWithType:(int)apiType
                    postParmas:(id)paramsPost
                     getParams:(id)parmasGet
                     completed:(void (^)( id object, NSString *message))completedBlock
                        failed:(void (^)(NSString *error))failBlock
{
    if ([arrayRunningService containsObject: [NSNumber numberWithInt: apiType]])
    {
        DLog(@"API Running: %d", apiType);
        return;
    }
    else{
        [arrayRunningService addObject: [NSNumber numberWithInt: apiType]];
    }
    
    DLog(@"%@",paramsPost);
    
    [RequestAPI request:apiType paramsGet: parmasGet paramsPost: paramsPost success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"Request API response: %@", JSON);
        
        if (!isEmptyJSON(JSON, @"authentication_token"))
        {
            NSDictionary * dict = (NSDictionary*)JSON;
            NSString* token = [dict objectForKey:@"authentication_token"];
            if (token.length == 0)
            {
                NSString *message = Alert_ServerError;
                if (failBlock)
                {
                    failBlock(message);
                }
            }
            else
            {
                if (completedBlock)
                {
                    completedBlock([DatabaseManager parseObjectWithApiType:apiType dataResult:JSON],nil);
                }
            }
        }
        else
        {
            if (completedBlock)
                completedBlock(nil, nil);
        }
        
        [arrayRunningService removeObject: [NSNumber numberWithInt: apiType]];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        long statusCode = [[operation response] statusCode];
        DLog(@"Fail Code: %ld", statusCode);
        
        NSDictionary *JSON = [operation responseObject];
        DLog(@"JSON : %@", JSON);

        if (failBlock)
        {
            NSString *message = [[NSString alloc] initWithData: [operation responseData]  encoding: NSUTF8StringEncoding];
            if (!isEmptyJSON(JSON, @"message"))
                message = [JSON objectForKey: @"message"];

            failBlock(message);
        }
        
        [arrayRunningService removeObject: [NSNumber numberWithInt: apiType]];
    }];
}

- (void)cancelAllRequest {

    [RequestAPI cancelAllRequest];
}

@end
