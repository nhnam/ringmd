//
//  DataManager.h
//  Oath
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountObject;

@interface DataManager : NSObject

+ (DataManager *)shareInstance;

/*!
 @abstract cancel all request
 */
- (void)cancelAllRequest;

/*!
 @abstract login。
 @param username。
 @param password。
 @result completed  : Account obj, message, error。
 @result failed     : error。
 */
- (void)loginWithUsername:(NSString *)username password:(NSString *)password
                completed:(void (^)( id object, NSString *message))completedBlock
                   failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract logout。
 @result completed  : message。
 @result failed     : error。
 */
- (void)logoutWithcompleted:(void (^)( id object, NSString *message))completedBlock
                     failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract register。
 @param username, password, fullname, email。
 @result completed  : Account obj, message, error。
 @result failed     : error。
 */
- (void)registerWithUsername:(NSString *)username
                    password:(NSString *)password
                    fullname:(NSString *)fullname
                       email:(NSString *)email
                   completed:(void (^)( id object, NSString *message))completedBlock
                      failed:(void (^)(NSString *error))failBlock;
/*!
 @abstract forgor password。
 @param Email。
 @result completed  : message。
 @result failed     : error。
 */
- (void)forgotPasswordWithEmail:(NSString *)email
                  completed:(void (^)( id object, NSString *message))completedBlock
                     failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract login via social。
 @param social_media_type, id, email_id, name。
 @result completed  : Account obj, message, error。
 @result failed     : error。
 */
- (void)loginViaSocialType:(NSString *)social_type
                  socialID:(NSString *)social_id
                     email:(NSString *)email
                      name:(NSString *)name
                completed:(void (^)( id object, NSString *message))completedBlock
                    failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract check username。
 @param username。
 @result completed  : message。
 @result failed     : error。
 */
- (void)checkUsername:(NSString *)username
         completed:(void (^)( id object, NSString *message))completedBlock
            failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract check email。
 @param email。
 @result completed  : message。
 @result failed     : error。
 */
- (void)checkEmail:(NSString *)email
         completed:(void (^)( id object, NSString *message))completedBlock
            failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract get profile。
 @param user_id or username。
 @result completed  : Account obj, message, error。
 @result failed     : error。
 */
- (void)getProfile:(NSString *)user
                completed:(void (^)( id object, NSString *message))completedBlock
                   failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract update profile。
 @param user, email, password, fullname, profile status, country, profile image data, cover image data。
 @result completed  : Account obj, message, error。
 @result failed     : error。
 */
- (void)updateProfileWithUser:(NSString *)user_id
                        email:(NSString *)email
                     password:(NSString *)password
                     fullname:(NSString *)fullname
               profile_status:(NSString *)profile_status
                      country:(NSString *)country
                profile_image: (NSData *)profile_data
                  cover_image: (NSData *)cover_data
                    completed:(void (^)( id object, NSString *message))completedBlock
                       failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract add recipe。
 @param user, name, category, duration, steps, ingredients, caption, location_name, image1_data, image2_data, image3_data, image4_data, video_data。
 @result completed  : Recipe obj, message, error。
 @result failed     : error。
 */
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
                       failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract get recipe detail。
 @param user_id, recipe_id。
 @result completed  : Recipe obj, message, error。
 @result failed     : error。
 */
- (void)getRecipeDetailWithUser:(NSString *)user_id
                         recipe:(NSString *)recipe_id
                      completed:(void (^)( id object, NSString *message))completedBlock
                         failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract update recipe。
 @param user, recipe_id, name, category, duration, steps, ingredients, caption, location_name, image_path1, image1_id, image_path2, image2_id, image_path3, image3_id, image_path4, image4_id, video_path, video_id。
 @result completed  : Recipe obj, message, error。
 @result failed     : error。
 */
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
                      failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract get category of recipe。
 @param user_id。
 @result completed  : Recipe obj, message, error。
 @result failed     : error。
 */
- (void)getCategoryOfRecipe:(NSString *)user_id
                completed:(void (^)( id object, NSString *message))completedBlock
                   failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract report a recipe。
 @param user_id, recipe_id, report。
 @result completed  : Recipe obj, message, error。
 @result failed     : error。
 */
- (void)reportRecipe:(NSString *)user_id
              recipe:(NSString *)recipe_id
         report_text:(NSString *)report
                  completed:(void (^)( id object, NSString *message))completedBlock
              failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract get list of recipe。
 @param user_id, page。
 @result completed  : Recipe obj, message, error。
 @result failed     : error。
 */
- (void)getListRecipe:(NSString *)user_id
                 page:(int)page
                  completed:(void (^)( id object, NSString *message))completedBlock
                     failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract get discover。
 @param user_id。
 @result completed  : Recipe obj, message, error。
 @result failed     : error。
 */
- (void)getDiscover:(NSString *)user_id
            completed:(void (^)( id object, NSString *message))completedBlock
               failed:(void (^)(NSString *error))failBlock;

/*!
 @abstract get my list of recipe。
 @param user_id, page。
 @result completed  : Recipe obj, message, error。
 @result failed     : error。
 */
- (void)getMyListRecipe:(NSString *)user_id
                   page:(int)page
              completed:(void (^)( id object, NSString *message))completedBlock
                 failed:(void (^)(NSString *error))failBlock;

@end
