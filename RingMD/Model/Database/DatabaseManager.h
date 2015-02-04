//
//  DatabaseManager.h
//  Oath
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject 

+ (DatabaseManager *)shareInstance;

// Parse

+ (id)parseDataLogin: (NSDictionary *)User;
+ (id)parseObjectWithApiType:(int)apiType dataResult:(id)dicJSON;

@end
