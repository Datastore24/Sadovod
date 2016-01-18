//
//  ParserLoginPassword.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserLoginPassword.h"

@implementation ParserLoginPassword
//Метод парсинга
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"token" : mts_key(token),
             
             
             };
    
    
}
@end
