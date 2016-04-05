//
//  RACCache.h
//  ArchitectureSampleApp
//
//  Created by Grzegorz Sagadyn on 15.01.2016.
//  Copyright © 2016 Grzegorz Sagadyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACCache : NSObject

+ (RACCache *)sharedCache;

- (id)cachedObjectForKey:(id<NSCopying>)cacheKey;
- (void)setCachedObject:(id)cacheObject forKey:(id<NSCopying>)cacheKey;
- (void)setCachedObject:(id)cacheObject forKey:(id<NSCopying>)cacheKey expirationTimeInterval:(NSTimeInterval)expirationTimeInterval;
- (void)clearCache;

@end
