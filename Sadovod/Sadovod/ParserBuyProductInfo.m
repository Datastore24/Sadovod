//
//  ParserBuyProductInfo.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 28.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
/*
 @property (strong,nonatomic) NSString * status;
 @property (strong,nonatomic) NSDictionary * product;
 @property (strong,nonatomic) NSString * total;
 @property (strong,nonatomic) NSString * global_count;
 @property (strong,nonatomic) NSString * global_cost;
 */

#import "ParserBuyProductInfo.h"

@implementation ParserBuyProductInfo
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"status" : mts_key(status),
             @"product" : mts_key(product),
             @"total" : mts_key(total),
             @"global_count" : mts_key(global_count),
             @"global_cost" : mts_key(global_cost),
             
             };
    
    
}
@end
