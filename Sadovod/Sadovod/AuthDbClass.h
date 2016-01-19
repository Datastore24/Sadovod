//
//  AuthDbClass.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthDbClass : NSObject
-(NSArray *) showAllUsers;
- (void)deleteAuth;
-(BOOL)checkKey:(NSString*) key;
-(void) addKey: (NSString *) key;
-(void) authFist: (NSString *) login andPassword: (NSString *) password andEnter:(NSString *) enter andKey:(NSString *) key;
- (BOOL)checkUsers:(NSString*) login andPassword:(NSString*) password;
- (void)updateToken:(NSString *)token;
- (void)DeleteUserWithOutKey;
- (void)UpdateUserWithOutKey: (NSString *) login password:(NSString *) password;
@end
