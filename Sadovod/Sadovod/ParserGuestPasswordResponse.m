//
//  ParserGuestPasswordResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserGuestPasswordResponse.h"
#import "ParserGuestPassword.h"

@implementation ParserGuestPasswordResponse
- (NSMutableArray *)parsing:(id)response

{
    NSMutableArray * arrayResponse = [[NSMutableArray alloc] init];
    //Если это обновление удаляем все объекты из массива и грузим заного
    
    //
    ParserGuestPassword *parserLoginPassword = [[ParserGuestPassword alloc] init];
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        [parserLoginPassword mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserLoginPassword];
        return arrayResponse;
    }
    return nil;
}
@end
