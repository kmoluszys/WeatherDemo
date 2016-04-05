//
//  SNKeychain.h
//  NavigatorTouch
//
//  Created by Grzegorz Sagadyn on 19/12/13.
//  Copyright (c) 2013 Speednet Sp. z o. o. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNKeychain : NSObject

/**
 Przeszukiwanie keychaina dla zadanej wartości, jeden rezultat na szukanie
 @param identifier identyfikator
 @returns znalezione dane
 */
+ (NSData *)searchKeychainCopyMatchingIdentifier:(NSString *)identifier;


/**
 Wywołanie metody searchKeychainCopyMatchingIdentifier z konwertowaniem na string
 @param identifier identyfikator
 @returns znaleziony string
 */
+ (NSString *)keychainStringFromMatchingIdentifier:(NSString *)identifier;


/**
 Inicjalizacja zmiennej w keychainie
 @param value zapisywana wartość
 @param identifier identyfikator wartości
 @returns YES/NO - status powodzenia
 */
+ (BOOL)createKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier;


/**
 Update wartości w keychainie
 @param value wartość do update
 @param identifier identyfikator wartości
 @returns YES/NO - status powodzenia
 */
+ (BOOL)updateKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier;


/**
 Usuwanie wartości z keychaina
 @param identifier identyfikator wartości
 */
+ (void)deleteItemFromKeychainWithIdentifier:(NSString *)identifier;

@end
