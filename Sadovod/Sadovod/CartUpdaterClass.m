//
//  CartUpdaterClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 29.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "CartUpdaterClass.h"
#import "ParserSimpleCart.h"
#import "ParserSimpleCartResponse.h"
#import "APIGetClass.h"
#import "SingleTone.h"
#import "DecorView.h"


@implementation CartUpdaterClass



//Тащим краткие данные о товаре
+(void) reloadCartWithApi: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/cart_total" complitionBlock:^(id response) {
        
        ParserSimpleCartResponse * parsingResponce =[[ParserSimpleCartResponse alloc] init];
        
        ParserSimpleCart * parse = [parsingResponce parsing:response];
        
        NSDictionary * orderCart = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    parse.count,@"count",
                                    parse.cost,@"cost",
                                    nil];
        [[SingleTone sharedManager] setOrderCart:orderCart];
      
        
        block();
    }];
    
}

+(void) updateCartWithApi: (UIView *) view{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/cart_total" complitionBlock:^(id response) {
        
        ParserSimpleCartResponse * parsingResponce =[[ParserSimpleCartResponse alloc] init];
        
        ParserSimpleCart * parse = [parsingResponce parsing:response];
        
        NSDictionary * orderCart = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    parse.count,@"count",
                                    parse.cost,@"cost",
                                    nil];
        [[SingleTone sharedManager] setOrderCart:orderCart];
        
     
        
       
        UILabel * labelDecor = (UILabel *)[view viewWithTag:556];
        
        UIView * decor = (UIView *)[view viewWithTag:554];
        NSLog(@"ИТОГО %@",parse.cost);
        if([parse.cost integerValue] ==0){
            NSLog(@"DECOR 0 ");
            [UIView animateWithDuration:0.5 animations:^{
                decor.alpha = 0;
            }];
        }else{
            NSLog(@"DECOR 0,7 ");
            [UIView animateWithDuration:0.5 animations:^{
                decor.alpha = 0.7;
            }];
        }
        
        labelDecor.text = [NSString stringWithFormat:@"Итого %@ на %@ руб", parse.count, parse.cost];

       
    }];
    
}

+(void) updateCartWithApi: (UILabel *) labelCount andLabelPrice: (UILabel *) labelPrice andView:(UIView *) view{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/cart_total" complitionBlock:^(id response) {
        
        ParserSimpleCartResponse * parsingResponce =[[ParserSimpleCartResponse alloc] init];
        
        ParserSimpleCart * parse = [parsingResponce parsing:response];
        
        NSDictionary * orderCart = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    parse.count,@"count",
                                    parse.cost,@"cost",
                                    nil];
        [[SingleTone sharedManager] setOrderCart:orderCart];
        
        NSDictionary * cartInfo = [[SingleTone sharedManager] orderCart];
        labelCount.text = [cartInfo objectForKey:@"count"];
        labelPrice.text = [cartInfo objectForKey:@"cost"];
        DecorView * decor = (DecorView *)[view viewWithTag:554];
        NSLog(@"ИТОГО %@",[cartInfo objectForKey:@"cost"]);
        if([[cartInfo objectForKey:@"cost"] integerValue]==0){
            
            decor.alpha = 0;
        }else{
            decor.alpha = 0.7;
        }
        
    }];
    
}



@end
