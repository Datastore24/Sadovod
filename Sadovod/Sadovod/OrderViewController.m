//
//  OrderViewController.m
//  Sadovod
//
//  Created by Viktor on 22.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "OrderViewController.h"
#import "ViewSectionTable.h"
#import "TitleClass.h"
#import "CustomerViewController.h"

#import "ParserOrder.h"
#import "ParserOrderResponse.h"
#import "APIGetClass.h"
#import "APIPostClass.h"
#import "SingleTone.h"

@implementation OrderViewController
{
    UIScrollView * mainscrollView;
    ViewSectionTable * image;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
     self.arrayOrder = [NSMutableArray array];
    TitleClass * title = [[TitleClass alloc]initWithTitle:[NSString stringWithFormat:@"Заказ №%@", self.orderID]];
    self.navigationItem.titleView = title;
    
    
    //Кнопка бара--------------------------------------------
    UIButton * buttonCustomer =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCustomer setImage:[UIImage imageNamed:@"ic_order_info.png"] forState:UIControlStateNormal];
    [buttonCustomer addTarget:self action:@selector(buttonCustomerAction)forControlEvents:UIControlEventTouchUpInside];
    [buttonCustomer setFrame:CGRectMake(0, 0, 30, 30)];
    
    UIBarButtonItem *barButtonOrders = [[UIBarButtonItem alloc] initWithCustomView:buttonCustomer];
    self.navigationItem.rightBarButtonItem = barButtonOrders;
    
    //Инициализация скрол вью--------------------------------------------
    mainscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainscrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainscrollView];
  
    
   
    
        [self getApiOrder:^{
        
    
    if(self.arrayOrder.count > 0 ){
        ParserOrder * parserOrder = [self.arrayOrder objectAtIndex:0];
        NSArray * listOrderItems = parserOrder.list;
        
 

    
    for (int i = 0; i < listOrderItems.count; i ++) {
        
        NSDictionary * infoOrderItems = [listOrderItems objectAtIndex:i];
        
        //Изобрадение предмета--------------------------------
        image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width / 2 * i, self.view.frame.size.width / 4 + 20, (self.view.frame.size.width / 2)) andImageURL:[infoOrderItems objectForKey:@"img"] isInternetURL:YES andLabelPrice:[infoOrderItems objectForKey:@"cost"] andResized:YES];
        [mainscrollView addSubview:image];
        
        //Размер предмета-------------------------------------
        UILabel * sizeObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 10 + self.view.frame.size.width / 2 * i, 250, 20)];
        sizeObjectLabel.text = [infoOrderItems objectForKey:@"name"];
        sizeObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainscrollView addSubview:sizeObjectLabel];
        
        //Колличество заказанного товара----------------------
        UILabel * numberObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 30 + self.view.frame.size.width / 2 * i, 150, 20)];
        numberObjectLabel.text = [NSString stringWithFormat:@"Количество: %@", [infoOrderItems objectForKey:@"count"]];
        numberObjectLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [mainscrollView addSubview:numberObjectLabel];
        
        //Создание кнопки редактировать товар-----------------
//        UIButton * buttonEditOrder = [UIButton buttonWithType:UIButtonTypeSystem];
//        buttonEditOrder.frame = CGRectMake((self.view.frame.size.width / 4) + 25,
//                                           120 + self.view.frame.size.width / 2 * i, 25, 25);
//        buttonEditOrder.tag = [[infoOrderItems objectForKey:@"id"] integerValue];
//        [buttonEditOrder setImage:[UIImage imageNamed:@"ic_order_edit.png"] forState:UIControlStateNormal];
//        [buttonEditOrder addTarget:self action:@selector(buttonEditOrderAction:) forControlEvents:UIControlEventTouchUpInside];
//        [mainscrollView addSubview:buttonEditOrder];
        
    }
        
            mainscrollView.contentSize = CGSizeMake(self.view.frame.size.width, (image.frame.size.height * listOrderItems.count) + 65);
        
         }
        }];
}

- (void) buttonEditOrderAction: (UIButton*) button
{
    for (int i = 0; i < 10; i ++) {
        if (button.tag == i) {
            NSLog(@"Редактируем заказ № %d", i);
        }
    }
    
}

- (void) buttonCustomerAction
{
    CustomerViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
    detail.orderID=self.orderID;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void) getApiOrder: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             self.orderID,@"order",
                             nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/detail_order" complitionBlock:^(id response) {
        
        [activityIndicator setHidden:YES];
        [activityIndicator stopAnimating];
        
        ParserOrderResponse * parsingResponce =[[ParserOrderResponse alloc] init];
        [parsingResponce parsing:response andArray:self.arrayOrder andBlock:^{
            
            
            block();
            
        }];
        
        
    }];
    
}

@end
