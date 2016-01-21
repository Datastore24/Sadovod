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
        NSArray * product = parserProduct.product;
        
        
        for (int i = 0; i < product.count; i++) {
            
            [arrayResponse addObject:[product objectAtIndex:i]];
            
            //Отслеживаем конец цикла
            if ([[product objectAtIndex:i] isEqual:[product lastObject]]) {
                
                block();
                
            }
            
        }
        
        
        
        
    }
}
@end
