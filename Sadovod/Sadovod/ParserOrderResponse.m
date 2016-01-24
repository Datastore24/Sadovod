//
//  ParserOrderResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 24.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserOrderResponse.h"
#import "ParserOrder.h"

@implementation ParserOrderResponse
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block {
    
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        ParserOrder *parserOrder = [[ParserOrder alloc] init];
        [parserOrder mts_setValuesForKeysWithDictionary:response];
       
        [arrayResponse addObject:parserOrder];
        
        block();
          
        
    }
}
@end
