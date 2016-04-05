//
//  SNBaseValueTransformer.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 18/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import "SNBaseValueTransformer.h"
#import "SNKeychain.h"
#import "NSData+AES256.h"

@implementation SNBaseValueTransformer

+ (Class)transformedValueClass {
    return [NSData class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (id)transformedValue:(id)value {
    NSData *encoded;
    if ([value respondsToSelector:@selector(encodeWithCoder:)]) {
        encoded = [NSKeyedArchiver archivedDataWithRootObject:value];
        NSString *password = [SNKeychain keychainStringFromMatchingIdentifier:KEYCHAIN_PASSWORD_KEY];
        if (password) {
            encoded = [encoded AES256EncryptWithKey:password];
        }
    } else {
        NSLog(@"Class: %@ not implement encodeWithCoder: method", NSStringFromClass([value class]));
    }
    
    return encoded;
}

- (id)reverseTransformedValue:(id)value {
    NSData *decoded;
    if ([value isKindOfClass:[NSData class]]) {
        NSString *password = [SNKeychain keychainStringFromMatchingIdentifier:KEYCHAIN_PASSWORD_KEY];
        if (password) {
            decoded = [value AES256DecryptWithKey:password];
        }
        decoded = [NSKeyedUnarchiver unarchiveObjectWithData:decoded];
    }
    
    return decoded;
}

@end
