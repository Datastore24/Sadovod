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
-(void) authFist: (NSString *) email andPassword: (NSString *) password andEnter: (NSNumber *) enter{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    Auth *auth = [Auth MR_createEntityInContext:localContext];
   
    [localContext MR_saveToPersistentStoreAndWait];
}
@end
