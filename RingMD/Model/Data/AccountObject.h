//
//  AccountObject.h
//  CurrentCostApp
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "BaseObject.h"

@interface AccountObject : BaseObject
                                       
@property (nonatomic, assign) int               user_id;
@property (nonatomic, strong) NSString          *email;
@property (nonatomic, strong) NSString          *full_name;
@property (nonatomic, strong) NSString          *authentication_token;
@property (nonatomic, strong) NSString          *avatar;
@property (nonatomic, strong) NSString          *currency;
@property (nonatomic, strong) NSString          *gender;
@property (nonatomic, strong) NSString          *location;
@property (nonatomic, strong) NSString          *phone_number;
@property (nonatomic, strong) NSString          *role;


+ (AccountObject*)accountInfoFromUserDefault;

@end
