//
//  NSString+Trim.h
//  TiViK
//
//  Created by Karol Moluszys on 17.10.2012.
//  Copyright (c) 2012 Speednet Sp. z o. o. All rights reserved.
//
// Kategoria NSString

#import <Foundation/Foundation.h>

@interface NSString (Tools)

/**
	Trimowanie stringa
	@returns NSString
 */
- (NSString *)trim;
- (NSString *)complexTrim;

- (BOOL)isEmpty;
- (BOOL)isEmptyOrWhiteSpace;

+ (BOOL)stringIsEmpty:(NSString*)aString;
+ (BOOL)stringIsEmptyOrWhiteSpace:(NSString*)aString;

+ (NSString *)hashedString:(NSString *)input;
+ (NSString *)SHA256String:(NSString *)input;
+ (NSString *)MD5String:(NSString *)input;

- (NSUInteger)countNumberOfWords;
- (BOOL)containsString:(NSString *)subString;

- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)removeSubString:(NSString *)subString;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)isInThisArray:(NSArray*)array;

- (NSData *)convertToData;
+ (NSString *)getStringFromData:(NSData *)data;

- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;
- (BOOL)isValidUrl;

/**
 *  Returns proper string for count
 *
 *  @param count   count number
 *  @param options Array of string options (string for count: 0, 1, 2, 5, 22)
 *
 *  @return string
 */
+ (NSString *)stringForCount:(NSInteger)count fromOptions:(NSArray *)options;

/**
 *  Removes HTML tags from NSString
 *
 *  @return stripped NSString
 */
- (NSString *)stripHTML;

@end
