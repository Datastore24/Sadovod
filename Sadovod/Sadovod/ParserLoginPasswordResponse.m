//
//  ParserLoginPasswordResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserLoginPasswordResponse.h"
#import "ParserLoginPassword.h"

@implementation ParserLoginPasswordResponse
- (NSMutableArray *)parsing:(id)response

{
    NSMutableArray * arrayResponse = [[NSMutableArray alloc] init];
    //Если это обновление удаляем все объекты из массива и грузим заного
    
    //
    ParserLoginPassword *parserLoginPassword = [[ParserLoginPassword alloc] init];
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        [parserLoginPassword mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserLoginPassword];
        return arrayResponse;
    }
    return nil;
}

@end
