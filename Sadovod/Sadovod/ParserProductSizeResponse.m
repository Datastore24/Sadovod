//
//  ParserProductSizeResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 25.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserProductSizeResponse.h"
#import "ParserProductSize.h"

@implementation ParserProductSizeResponse
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block {
    
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        ParserProductSize *parserProductSize = [[ParserProductSize alloc] init];
        [parserProductSize mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserProductSize];
        
        block();
        
        
        
        
        
        
    }
}
@end
