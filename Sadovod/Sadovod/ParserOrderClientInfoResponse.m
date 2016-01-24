//
//  ParserOrderClientInfoResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 24.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserOrderClientInfoResponse.h"
#import "ParserOrderClientInfo.h"

@implementation ParserOrderClientInfoResponse
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block {
    
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        ParserOrderClientInfo *parserOrderClientInfo = [[ParserOrderClientInfo alloc] init];
        [parserOrderClientInfo mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserOrderClientInfo];
        
        block();
        
        
    }
}
@end
