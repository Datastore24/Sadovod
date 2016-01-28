//
//  ParserBuyProductInfoResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 28.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserBuyProductInfoResponse.h"
#import "ParserBuyProductInfo.h"

@implementation ParserBuyProductInfoResponse
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block {
    
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        ParserBuyProductInfo *parserBuyProductInfo = [[ParserBuyProductInfo alloc] init];
        [parserBuyProductInfo mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserBuyProductInfo];
        
        block();
        
        
        
        
        
        
    }
}
@end
