//
//  APIPostClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "APIPostClass.h"
#import <AFNetworking/AFNetworking.h>

#define MAIN_URL @"http://adm.limelin.com/" //Адрес сервера


@implementation APIPostClass
-(void) postDataToServerWithParams: (NSDictionary *) params andAddParam: (NSString *) addParam method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack{
    
    NSString * url = [NSString stringWithFormat:@"%@/%@/?%@",MAIN_URL,method,addParam];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    //Запрос
    [manager POST: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //Вызов блока
        compitionBack (responseObject);
        
        
        //Ошибки
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
@end
