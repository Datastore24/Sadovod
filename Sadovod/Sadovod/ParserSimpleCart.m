//
//  ParserSimpleCart.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 29.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserSimpleCart.h"

@implementation ParserSimpleCart
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"count" : mts_key(count),
             @"cost" : mts_key(cost),
             
             };
    
    
}
@end
