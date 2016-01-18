//
//  ParserResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserResponse.h"
#import "ParserAuthKey.h"

@implementation ParserResponse
- (NSMutableArray *)parsing:(id)response

{
    NSMutableArray * arrayResponse = [[NSMutableArray alloc] init];
    //Если это обновление удаляем все объекты из массива и грузим заного
    
    //
    ParserAuthKey *parserAuthKey = [[ParserAuthKey alloc] init];
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        [parserAuthKey mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserAuthKey];
        return arrayResponse;
    }
    return nil;
}
@end
