//
//  NSData+AES256.m
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 19/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import "NSData+AES256.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (AES256)

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Encrypt
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (NSData *)AES256EncryptWithKey:(NSString *)key {
	return [self AES256EncryptWithKey:key iv:nil];
}

- (NSData *)AES256EncryptWithKey:(NSString *)key iv:(NSData *)iv {
	char keyPtr[kCCKeySizeAES256+1];
	bzero(keyPtr, sizeof(keyPtr));
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	return [self AES256EncryptWithKeyData:[NSData dataWithBytes:keyPtr length:kCCKeySizeAES256 + 1] iv:iv];
}

- (NSData *)AES256EncryptWithKeyData:(NSData *)key {
	return [self AES256EncryptWithKeyData:key iv:nil];
}

- (NSData *)AES256EncryptWithKeyData:(NSData *)key iv:(NSData *)iv {
	unsigned char *keyPtr = (unsigned char *)[key bytes];
	
	NSUInteger dataLength = [self length];
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
										  keyPtr, kCCKeySizeAES256,
										  (iv ? [iv bytes] : NULL),
										  [self bytes], dataLength,
										  buffer, bufferSize,
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
	
	free(buffer);
	return nil;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Decrypt
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

- (NSData *)AES256DecryptWithKey:(NSString *)key {
	return [self AES256DecryptWithKey:key iv:nil];
}

- (NSData *)AES256DecryptWithKey:(NSString *)key iv:(NSData *)iv {
	char keyPtr[kCCKeySizeAES256 + 1];
	bzero(keyPtr, sizeof(keyPtr));
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	return [self AES256DecryptWithKeyData:[NSData dataWithBytes:keyPtr length:kCCKeySizeAES256 + 1] iv:iv];
}

- (NSData *)AES256DecryptWithKeyData:(NSData *)key {
	return [self AES256DecryptWithKeyData:key iv:nil];
}

- (NSData *)AES256DecryptWithKeyData:(NSData *)key iv:(NSData *)iv {
	unsigned char *keyPtr = (unsigned char *)[key bytes];
	
	NSUInteger dataLength = [self length];
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
										  keyPtr, kCCKeySizeAES256,
										  (iv ? [iv bytes] : NULL),
										  [self bytes], dataLength,
										  buffer, bufferSize,
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
		return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
	}
	
	free(buffer);
	return nil;
}

// ----------------------------------------------------------------------------------------------------------------
# pragma mark -
# pragma mark Helpers
# pragma mark -
// ----------------------------------------------------------------------------------------------------------------

+ (NSData *)AES256GenerateKey {
	unsigned char salt[kCCKeySizeAES256];
	for (int i = 0; i < kCCKeySizeAES256; i++) {
		salt[i] = (unsigned char)arc4random();
	}
	
	NSData *dataSalt = [NSData dataWithBytes:salt length:sizeof(salt)];
	return dataSalt;
}

+ (NSData *)AES256GenerateIV {
	return [self randomDataOfLength:kCCBlockSizeAES128];
}

extern int SecRandomCopyBytes(SecRandomRef rnd, size_t count, uint8_t *bytes) __attribute__((weak_import));

+ (NSData *)randomDataOfLength:(size_t)length {
	NSMutableData *data = [NSMutableData dataWithLength:length];
	
	int result;
	if (SecRandomCopyBytes != NULL) {
		result = SecRandomCopyBytes(NULL, length, data.mutableBytes);
	}
	else {
		result = RN_SecRandomCopyBytes(NULL, length, data.mutableBytes);
	}
	NSAssert(result == 0, @"Unable to generate random bytes: %d", errno);
	
	return data;
}

static int RN_SecRandomCopyBytes(void *rnd, size_t count, uint8_t *bytes) {
	static int kSecRandomFD;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		kSecRandomFD = open("/dev/random", O_RDONLY);
	});
	
	if (kSecRandomFD < 0)
		return -1;
	while (count) {
		ssize_t bytes_read = read(kSecRandomFD, bytes, count);
		if (bytes_read == -1) {
			if (errno == EINTR)
				continue;
			return -1;
		}
		if (bytes_read == 0) {
			return -1;
		}
		bytes += bytes_read;
		count -= bytes_read;
	}
	
	return 0;
}

@end
