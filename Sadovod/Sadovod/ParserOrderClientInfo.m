//
//  ParserOrderClientInfo.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 24.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserOrderClientInfo.h"

@implementation ParserOrderClientInfo
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"order_id" : mts_key(order_id),
             @"phone" : mts_key(phone),
             @"name" : mts_key(name),
             @"address" : mts_key(address),
             @"comment" : mts_key(comment),
             @"cost" : mts_key(cost),
             
             };
    
    
}
@end
