//
//  ParserProduct.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 21.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserProduct.h"

@implementation ParserProduct
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"product" : mts_key(product),
             
             
             };
    
    
}
@end
