//
//  CustomerViewController.m
//  Sadovod
//
//  Created by Viktor on 23.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "CustomerViewController.h"
#import "TitleClass.h"
#import "ViewCustomer.h"

#import "APIGetClass.h"
#import "ParserOrderClientInfo.h"
#import "ParserOrderClientInfoResponse.h"
#import "SingleTone.h"

@implementation CustomerViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.orderID);
    
    //Раздел заголовка---------------------------------------------------
    self.arrayOrderClientInfo =[NSMutableArray array];
    
    TitleClass * title = [[TitleClass alloc]initWithTitle:[NSString stringWithFormat:@"Заказ № %@", self.orderID]];
    self.navigationItem.titleView = title;
    
    [self getApiOrderClientInfo:^{
        
    
    if(self.arrayOrderClientInfo.count>0){
        ParserOrderClientInfo * parserOrderClientInfo = [self.arrayOrderClientInfo objectAtIndex:0];
    


    
    //Инициализация графического интерфейса------------------------------
    ViewCustomer * viewCustomer = [[ViewCustomer alloc] initWithPhone:parserOrderClientInfo.phone
                                                              andName:parserOrderClientInfo.name
                                                           andAddress:parserOrderClientInfo.address
                                                           andComment:parserOrderClientInfo.comment
                                                               andSum:parserOrderClientInfo.cost
                                                          andMainView:self.view];
    [self.view addSubview:viewCustomer];
        
        }
        }];
    
    //Создание селектора для кнопки с определенный тегом----------------
    UIButton *buttonConfirm = (UIButton *)[self.view viewWithTag:1068];
    [buttonConfirm addTarget:self action:@selector(buttonConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    //Создание селектора для кнопки с определенный тегом----------------
    UIButton *buttonCall = (UIButton *)[self.view viewWithTag:1070];
    [buttonCall addTarget:self action:@selector(buttonCallAction) forControlEvents:UIControlEventTouchUpInside];

    
}


- (void) buttonConfirmAction
{
    NSLog(@"Test");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) getApiOrderClientInfo: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             self.orderID,@"order",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/info_order" complitionBlock:^(id response) {
        
        ParserOrderClientInfoResponse * parsingResponce =[[ParserOrderClientInfoResponse alloc] init];
        [parsingResponce parsing:response andArray:self.arrayOrderClientInfo andBlock:^{
            NSLog(@"%@",response);
            
            block();
            
        }];
        
        
    }];
    
}


- (void) buttonCallAction
{
    NSLog(@"Дзынь дзынь");
}

@end
