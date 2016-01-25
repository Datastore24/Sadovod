//
//  ParserProductSize.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 25.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserProductSize.h"

@implementation ParserProductSize
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"sizes" : mts_key(sizes),
             @"aviable" : mts_key(aviable),
             };
    
    
}
@end
