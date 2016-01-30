//
//  ParserSimpleCartResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 29.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserSimpleCartResponse.h"


@implementation ParserSimpleCartResponse
- (ParserSimpleCart *)parsing:(id)response{
    
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        ParserSimpleCart *parserSimpleCart = [[ParserSimpleCart alloc] init];
        [parserSimpleCart mts_setValuesForKeysWithDictionary:response];
        
        

        return parserSimpleCart;
        
    }
    return nil;
}
@end
