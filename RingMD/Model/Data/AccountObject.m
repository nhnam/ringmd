//
//  AccountObject.m
//  CurrentCostApp
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//


#import "AccountObject.h"
#import "Utilities.h"
#import "Define.h"
#import "DatabaseManager.h"

@implementation AccountObject

+ (AccountObject*)accountInfoFromUserDefault
{
    if ([Utilities dataArchiverForKey: kAccount])
        return [DatabaseManager parseDataLogin: [Utilities dataArchiverForKey: kAccount]];
    
    return nil;
}

@end
