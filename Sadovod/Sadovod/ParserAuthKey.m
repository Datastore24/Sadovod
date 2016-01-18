//
//  ParserAuth.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserAuthKey.h"

@implementation ParserAuthKey
//Метод парсинга
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"key" : mts_key(key),
             
             
             };
    
    
}
@end
