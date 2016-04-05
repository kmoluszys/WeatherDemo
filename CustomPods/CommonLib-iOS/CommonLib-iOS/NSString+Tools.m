//
//  NSString+Trim.m
//  TiViK
//
//  Created by Karol Moluszys on 17.10.2012.
//  Copyright (c) 2012 Speednet Sp. z o. o. All rights reserved.
//

#import "NSString+Tools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Tools)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)complexTrim {
	NSString *resultString = [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	resultString = [[resultString componentsSeparatedByString:@"\n"] componentsJoinedByString:@""];
	resultString = [[[resultString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]] componentsJoinedByString:@" "];

	return resultString;
}

- (BOOL)isEmpty {
    return ![self length];
}

- (BOOL)isEmptyOrWhiteSpace {
    return ![[self trim] length];
}

+ (BOOL)stringIsEmpty:(NSString*)aString {
    return !(aString && [aString length]);
}

+ (BOOL)stringIsEmptyOrWhiteSpace:(NSString*)aString {
    return !(aString && [[aString trim] length]);
}

+ (NSString *)hashedString:(NSString *)input {
    return [self SHA256String:input];
}

+ (NSString *)SHA256String:(NSString *)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    // This is an iOS5-specific method.
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    // Parse through the CC_SHA256 results (stored inside of digest[]).
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

+ (NSString *)MD5String:(NSString *)input {
    const char* inputChars = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(inputChars, (CC_LONG)strlen(inputChars), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

- (NSString *)removeWhiteSpacesFromString {
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (NSUInteger)countNumberOfWords {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];

    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace intoString: nil]) {
        count++;
    }

    return count;
}

- (BOOL)containsString:(NSString *)subString {
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end {
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

-(NSString *)removeSubString:(NSString *)subString {
    if ([self containsString:subString]) {
        NSRange range = [self rangeOfString:subString];
        return [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}


- (BOOL)containsOnlyLetters {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

- (BOOL)containsOnlyNumbers {
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

- (BOOL)containsOnlyNumbersAndLetters {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

- (BOOL)isInThisArray:(NSArray*)array {
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }

    return NO;
}

- (NSData *)convertToData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)getStringFromData:(NSData *)data {
    if (!data) {
		return nil;
	}

	NSString *encodedString = nil;

	if ((encodedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSNEXTSTEPStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSJapaneseEUCStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSSymbolStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSNonLossyASCIIStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSShiftJISStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSISOLatin2StringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSUnicodeStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSWindowsCP1251StringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSWindowsCP1252StringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSWindowsCP1253StringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSWindowsCP1254StringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSWindowsCP1250StringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSISO2022JPStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSMacOSRomanStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSUTF16BigEndianStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSUTF16LittleEndianStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSUTF32BigEndianStringEncoding])) {
		return encodedString;
	} else if ((encodedString = [[NSString alloc] initWithData:data encoding:NSUTF32LittleEndianStringEncoding])) {
		return encodedString;
	}

	return nil;
}

- (BOOL)isValidEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    NSString *regex = @"^(\\+[0-9]{2}[ -]?)?[0-9]{3}[ -]?[0-9]{3}[ -]?[0-9]{3}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

- (BOOL)isValidUrl {
    return [NSURL URLWithString:self] != nil;
}

+ (NSString *)stringForCount:(NSInteger)count fromOptions:(NSArray *)options {
    NSAssert([options count] == 5, @"Wron options array count");

    if (count == 0) {
        return options[0];
    } else if (count == 1) {
        return options[1];
    } else if (count >= 2 && count <= 4) {
        return options[2];
    } else if (count >= 5 && count <= 19) {
        return options[3];
    } else if (count % 10 >= 2 && count % 10 <= 4) {
        return options[4];
    }

    return options[0];
}

- (NSString *)stripHTML {
	NSRange range;
	NSString *strippedString = [self copy];
	while ((range = [strippedString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
		strippedString = [strippedString stringByReplacingCharactersInRange:range withString:@""];
	return strippedString;
}

@end
