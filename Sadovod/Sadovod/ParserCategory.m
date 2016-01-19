//
//  ParserCategory.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 19.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserCategory.h"

@implementation ParserCategory
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"list" : mts_key(list),
             
             
             };
    
    
}
@end
