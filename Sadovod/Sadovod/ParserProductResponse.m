//
//  ParserProductResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 21.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserProductResponse.h"
#import "ParserProduct.h"

@implementation ParserProductResponse
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block {
    
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        ParserProduct *parserProduct = [[ParserProduct alloc] init];
        [parserProduct mts_setValuesForKeysWithDictionary:response];
        NSDictionary * product = parserProduct.product;
        
            [arrayResponse addObject:product];
            
                block();
                

        
        
        
        
    }
}
@end
