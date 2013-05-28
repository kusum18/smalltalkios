//
//  plist.h
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface plist : NSObject

+ (NSMutableDictionary *)readPlist;

+ (NSString *)getValueforKey:(NSString *)key;

+ (void)writeToPlistsetValue:(NSString *)val forKey:(NSString *)key;

+ (void)checkIfFileExists;

+ (NSString *) getPath;

@end
