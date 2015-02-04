//
//  BaseObject.m
//  CurrentCostApp
//
//  Created by namnguyen on 2/4/15.
//  Copyright (c) 2015 http://www.ring.md. All rights reserved.
//

#import "BaseObject.h"
#import <objc/runtime.h>

@implementation NSObject (RT)

// @see https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
- (NSUInteger)eachProperty:(void (^)(NSString *propertyName, NSArray *attributes))handler
{
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        const char *attr = property_getAttributes(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSString *attrString = [NSString stringWithUTF8String:attr];
        NSArray *attributes = [attrString componentsSeparatedByString:@","];
        
        handler(propertyName, attributes);
    }
    free(properties);
    
    return outCount;
}

- (NSString *)propertyDescription
{
    NSString * (^deepString)(NSString *, NSUInteger) = ^(NSString *sourceString, NSUInteger depth) {
        NSString *str = sourceString;
        for (NSUInteger i = 0; i < depth; i++) {
            str = [NSString stringWithFormat:@"    %@", str];
        }
        return str;
    };
    NSString * (^pairString)(NSString *, NSString *) = ^(NSString *str1, NSString *str2) {
        return [NSString stringWithFormat:@"%@ = %@", str1, str2];
    };
    
    NSString * (^setupDescription)(id, NSUInteger);
    NSString * (^__block __weak weakSetupDescription)(id, NSUInteger);
    
    weakSetupDescription = setupDescription= ^(id object, NSUInteger depth) {
        NSMutableString *result = [NSMutableString stringWithString:deepString(@"{\n", depth)];
        
        NSUInteger propertyNum = [object eachProperty:^(NSString *propertyName, NSArray *attributes) {
            NSString *typeAttribute = [attributes objectAtIndex:0];
            
            if ([typeAttribute hasPrefix:@"T@"] && [typeAttribute length] > 1) {
                NSString *propertyType = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length] - 4)];
                
                if ([propertyType isEqualToString:@"NSString"] ||
                    [propertyType isEqualToString:@"NSMutableString"] ||
                    [propertyType isEqualToString:@"NSDictionary"] ||
                    [propertyType isEqualToString:@"NSMutableDictionary"] ||
                    [propertyType isEqualToString:@"NSNumber"])
                {
                    NSString *str = pairString(propertyName, [object valueForKey:propertyName]);
                    [result appendFormat:@"%@\n", deepString(str, depth)];
                } else if ([propertyType isEqualToString:@"NSArray"] ||
                           [propertyType isEqualToString:@"NSMutableArray"]) {
                    NSString *str = deepString(propertyName, depth);
                    for (id child in [object valueForKey:propertyName]) {
                        NSString *subString = weakSetupDescription(child, depth + 1);
                        str = [NSString stringWithFormat:@"%@\n%@", str, subString];
                    }
                    [result appendFormat:@"%@\n", str];
                } else {
                    id child = [object valueForKey:propertyName];
                    NSString *str;
                    unsigned int outCount = 0;
                    objc_property_t *properties = class_copyPropertyList([child class], &outCount);
                    if (outCount == 0) {
                        str = deepString(pairString(propertyName, [child description]), depth);
                    } else {
                        NSString *subString = weakSetupDescription(child, depth + 1);
                        str = [NSString stringWithFormat:@"%@\n%@", deepString(propertyName, depth), subString];
                    }
                    free(properties);
                    [result appendFormat:@"%@\n", str];
                }
            } else {
                NSString *str = pairString(propertyName, [object valueForKey:propertyName]);
                [result appendFormat:@"%@\n", deepString(str, depth)];
            }
        }];
        
        if (propertyNum == 0) {
            return deepString([object description], depth);
        }
        
        [result appendString:deepString(@"}", depth)];
        
        return (NSString *)result;
    };
    
    return setupDescription(self, 0);
}
@end
@implementation BaseObject

- (NSString *)description
{
    return [self propertyDescription];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end
