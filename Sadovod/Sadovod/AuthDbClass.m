//
//  AuthDbClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "AuthDbClass.h"
#import "Auth.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AuthDbClass
-(void) authFist: (NSString *) login andPassword: (NSString *) password andEnter:(NSString *) enter andKey:(NSString *) key{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    Auth *auth = [Auth MR_createEntityInContext:localContext];
    auth.login = login;
    auth.password = password;
    auth.enter = enter;
    auth.uid=@"1";
    auth.key=key;
    NSLog(@"SAVE");
    [localContext MR_saveToPersistentStoreAndWait];
}

- (BOOL)checkUsers:(NSString*) login andPassword:(NSString*) password{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"login ==[c] %@ AND password ==[c] %@",login,password];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (authFounded)
    {
        return YES;
    }else{
        return NO;
    }
}

-(void) addKey: (NSString *) key{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    Auth *auth = [Auth MR_createEntityInContext:localContext];
    auth.key=key;
    auth.uid=@"1";
    [localContext MR_saveToPersistentStoreAndWait];
}

- (BOOL)checkKey:(NSString*) key{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"key ==[c] %@",key];
    Auth *keyFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (keyFounded)
    {
        return YES;
    }else{
        return NO;
    }
}

- (void)deleteAuth
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        // Delete the person found
        [authFounded MR_deleteEntityInContext:localContext];
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}

- (void)updateToken:(NSString *)token
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"uid ==[c] 1"];
    Auth *authFounded                   = [Auth MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (authFounded)
    {
        
        authFounded.token = token;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}


-(NSArray *) showAllUsers{
    NSArray *users            = [Auth MR_findAll];
    return users;
}
@end
