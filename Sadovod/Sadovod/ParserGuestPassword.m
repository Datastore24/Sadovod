//
//  ParserGuestPassword.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserGuestPassword.h"

@implementation ParserGuestPassword
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"password" : mts_key(password),
             
             
             };
    
    
}
@end
