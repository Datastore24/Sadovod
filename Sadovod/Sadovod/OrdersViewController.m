//
//  OrdersViewController.m
//  Sadovod
//
//  Created by Viktor on 21.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "OrdersViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"

#import "APIGetClass.h"
#import "ParserCategory.h"
#import "ParserCategoryResponse.h"
#import "SingleTone.h"

@implementation OrdersViewController
{
    UIScrollView * mainScrollView;
    CGFloat heightScrollView;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.arrayOrders = [NSMutableArray array];
    //Раздел заголовка---------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Заказы"];
    self.navigationItem.titleView = title;
   
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    
    //Раздел основного вью-----------------------------------------------
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:mainScrollView];
    
    [self getApiOrders:^{
        
        NSLog(@"ARRAY %@",self.arrayOrders);
        
    
    //Раздел таблицы из вью----------------------------------------------
    for (int i = 0; i < self.arrayOrders.count; i ++) {
        NSDictionary * ordersInfo = [self.arrayOrders objectAtIndex:i];
        //Лейбл ID ---------------------------
        UILabel * labelID = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 + 40 * i, self.view.frame.size.width / 5, 40)];
        labelID.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        labelID.layer.borderWidth = 1;
        labelID.text = [ordersInfo objectForKey:@"id"];
        labelID.textColor = [UIColor colorWithHexString:@"626262"];
        labelID.textAlignment = NSTextAlignmentCenter;
        labelID.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelID.backgroundColor = [UIColor whiteColor];
        [mainScrollView addSubview:labelID];
        
        //Лейбл даты--------------------------
        UILabel * labelDate = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 5, 0 + 40 * i, (self.view.frame.size.width / 5) * 2, 40)];
        labelDate.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        labelDate.layer.borderWidth = 1;
        labelDate.text = [ordersInfo objectForKey:@"dt"];;
        labelDate.textColor = [UIColor colorWithHexString:@"d9d9d9"];
        labelDate.textAlignment = NSTextAlignmentCenter;
        labelDate.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelDate.backgroundColor = [UIColor whiteColor];
        [mainScrollView addSubview:labelDate];
        
        //Лейбл кол-ва и цена------------------
        UILabel * labelNumber = [[UILabel alloc] initWithFrame:CGRectMake (labelDate.frame.origin.x + ((self.view.frame.size.width / 5) * 2), 0 + 40 * i, (self.view.frame.size.width / 5) * 2, 40)];
        labelNumber.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        labelNumber.layer.borderWidth = 1;
        labelNumber.text = [NSString stringWithFormat:@"%@ шт. на %@ руб.",[ordersInfo objectForKey:@"cnt"],[ordersInfo objectForKey:@"cost"]];
        labelNumber.textColor = [UIColor colorWithHexString:@"626262"];
        labelNumber.textAlignment = NSTextAlignmentCenter;
        labelNumber.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelNumber.backgroundColor = [UIColor whiteColor];
        [mainScrollView addSubview:labelNumber];
        
        //Кнопка заказа------------------------
        UIButton *buttonOrder = [UIButton buttonWithType:UIButtonTypeSystem];
        [buttonOrder addTarget:self
                        action:@selector(buttonOrderAction:)
         forControlEvents:UIControlEventTouchUpInside];
        buttonOrder.frame = CGRectMake(0, 0 + 40 * i, self.view.frame.size.width, 40.0);
        buttonOrder.tag = [[ordersInfo objectForKey:@"id"] integerValue];
        buttonOrder.backgroundColor = nil;
        [mainScrollView addSubview:buttonOrder];
    }
        }];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 0 + 40 * self.arrayOrders.count);
    
}

//Тащим заказы
-(void) getApiOrders: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/get_orders" complitionBlock:^(id response) {
        
        ParserCategoryResponse * parsingResponce =[[ParserCategoryResponse alloc] init];
        
        [parsingResponce parsing:response andArray:self.arrayOrders andBlock:^{
            
            NSLog(@"%@",response);
            block();
            
        }];
        
        
    }];
    
}

- (void) buttonOrderAction: (UIButton *) button
{
    for (int i = 0; i < 7; i ++) {
        if (button.tag == i) {
            NSLog(@"Button tag ID = %d", i);
        }
    }
}

@end
