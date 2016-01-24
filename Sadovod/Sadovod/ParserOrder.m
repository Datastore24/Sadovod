//
//  ParserOrder.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 24.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserOrder.h"

@implementation ParserOrder
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"order" : mts_key(order),
             @"list" : mts_key(list),

             };
    
    
}
@end
