//
//  plist.m
//  smalltalk
//
//  Created by App Jam on 5/27/13.
//  Copyright (c) 2013 Prakash Nagarajan. All rights reserved.
//

#import "plist.h"

@implementation plist

+ (NSMutableDictionary *)readPlist
{
    NSString *path = [self getPath];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    return plistDict;
    /* You could now call the string "value" from somewhere to return the value of the string in the .plist specified, for the specified key. */
}

+ (void)writeToPlistsetValue:(NSString *)value forKey:(NSString *)key
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    [plistDict setValue:value forKey:key];
    [plistDict writeToFile:path atomically: YES];
    
    /* This would change the firmware version in the plist to 1.1.1 by initing the NSDictionary with the plist, then changing the value of the string in the key "ProductVersion" to what you specified */
}

+ (NSString *)getValueforKey:(NSString *)key{
    
    NSString *path = [self getPath];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
//    return ([plistDict objectForKey:key]!=nil)?[plistDict objectForKey:key]:@"";
    return [plistDict objectForKey:key];
}

+ (NSString *) getPath{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    return path;
}

+ (void)checkIfFileExists{
    NSError *error;
    NSString *path = [self getPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
}



@end
