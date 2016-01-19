//
//  ParserCategoryResponse.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 19.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ParserCategoryResponse.h"
#import "ParserCategory.h"

@implementation ParserCategoryResponse
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block {
    
   
if ([response isKindOfClass:[NSDictionary class]]) {
   
        ParserCategory *parserCategory = [[ParserCategory alloc] init];
        [parserCategory mts_setValuesForKeysWithDictionary:response];
        NSArray * list = parserCategory.list;
    

    for (int i = 0; i < list.count; i++) {
        
        [arrayResponse addObject:[list objectAtIndex:i]];

        //Отслеживаем конец цикла
        if ([[list objectAtIndex:i] isEqual:[list lastObject]]) {
          
            block();
            
        }
    
    }
    
 

    
    }
}
@end
