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
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    //Раздел заголовка---------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Заказ № 137"];
    self.navigationItem.titleView = title;
    
    self.arrayOrder = [NSMutableArray array];
    
    
    //Кнопка бара--------------------------------------------
    UIButton * buttonCustomer =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonCustomer setImage:[UIImage imageNamed:@"ic_order_info.png"] forState:UIControlStateNormal];
    [buttonCustomer addTarget:self action:@selector(buttonCustomerAction)forControlEvents:UIControlEventTouchUpInside];
    [buttonCustomer setFrame:CGRectMake(0, 0, 30, 30)];
    
    UIBarButtonItem *barButtonOrders = [[UIBarButtonItem alloc] initWithCustomView:buttonCustomer];
    self.navigationItem.rightBarButtonItem = barButtonOrders;
    
    //Инициализация скрол вью--------------------------------------------
    mainscrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainscrollView.contentSize = CGSizeMake(self.view.frame.size.width, 2000);
    [self.view addSubview:mainscrollView];
    
    for (int i = 0; i < 10; i ++) {
        //Изобрадение предмета--------------------------------
        ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width / 2 * i, self.view.frame.size.width / 4 + 20, (self.view.frame.size.width / 2)) andImageURL:@"10image.jpg" isInternetURL:NO andLabelPrice:@"400" andResized:NO];
        [mainscrollView addSubview:image];
        
        //Размер предмета-------------------------------------
        UILabel * sizeObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 10 + self.view.frame.size.width / 2 * i, 150, 20)];
        sizeObjectLabel.text = [NSString stringWithFormat:@"%@ (размер: %@)", @"Легинсы", @"42"];
        sizeObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainscrollView addSubview:sizeObjectLabel];
        
        //Колличество заказанного товара----------------------
        UILabel * numberObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 30 + self.view.frame.size.width / 2 * i, 150, 20)];
        numberObjectLabel.text = [NSString stringWithFormat:@"Количество: %@", @"1"];
        numberObjectLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [mainscrollView addSubview:numberObjectLabel];
        
        //Создание кнопки редактировать товар-----------------
        UIButton * buttonEditOrder = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonEditOrder.frame = CGRectMake((self.view.frame.size.width / 4) + 25,
                                           120 + self.view.frame.size.width / 2 * i, 25, 25);
        buttonEditOrder.tag = i;
        [buttonEditOrder setImage:[UIImage imageNamed:@"ic_order_edit.png"] forState:UIControlStateNormal];
        [buttonEditOrder addTarget:self action:@selector(buttonEditOrderAction:) forControlEvents:UIControlEventTouchUpInside];
        [mainscrollView addSubview:buttonEditOrder];
        
    }
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
    [self.navigationController pushViewController:detail animated:YES];
}

-(void) getApiOrder: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             self.orderID,@"order",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/product" complitionBlock:^(id response) {
        
        ParserOrderResponse * parsingResponce =[[ParserOrderResponse alloc] init];
        [parsingResponce parsing:response andArray:self.arrayOrder andBlock:^{
            
            
            block();
            
        }];
        
        
    }];
    
}

@end
