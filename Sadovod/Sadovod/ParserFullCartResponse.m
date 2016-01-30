//
//  ParserFullCartResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 30.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserFullCartResponse.h"
#import "ParserFullCart.h"

@implementation ParserFullCartResponse
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block {
    
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        ParserFullCart *parserFullCart = [[ParserFullCart alloc] init];
        [parserFullCart mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserFullCart];
        
        block();
        
        
    }
}
@end
