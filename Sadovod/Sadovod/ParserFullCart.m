//
//  ParserFullCart.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 30.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserFullCart.h"

@implementation ParserFullCart
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"global_cost" : mts_key(global_cost),
             @"global_count" : mts_key(global_count),
             @"list" : mts_key(list),
             
             };
    
    
}
@end
