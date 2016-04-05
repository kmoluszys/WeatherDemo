//
//  NSData+AES256.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 19/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256EncryptWithKey:(NSString *)key iv:(NSData *)iv;
- (NSData *)AES256EncryptWithKeyData:(NSData *)key;
- (NSData *)AES256EncryptWithKeyData:(NSData *)key iv:(NSData *)iv;

- (NSData *)AES256DecryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key iv:(NSData *)iv;
- (NSData *)AES256DecryptWithKeyData:(NSData *)key;
- (NSData *)AES256DecryptWithKeyData:(NSData *)key iv:(NSData *)iv;

+ (NSData *)AES256GenerateKey;
+ (NSData *)AES256GenerateIV;

@end
