//
//  SectionTableViewController.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "SectionTableViewController.h"
#import "ModelSectionTableOwner.h"
#import "ViewSectionTable.h"
#import "ViewControllerProductDetails.h"
#import "AlertClass.h" //Подключение Алертов
#import "TitleClass.h"

#import "APIGetClass.h"
#import "ParserCategory.h"
#import "ParserCategoryResponse.h"
#import "SingleTone.h"

@interface SectionTableViewController ()

@property (strong, nonatomic) NSMutableArray * arrayCategoryItems; //Массив с Товарами

@end

@implementation SectionTableViewController
{
    NSDictionary * dataTableItems; //Данные
    UIScrollView * mainScrollView; //Основной скрол вью
    NSInteger numerator; //Кастомный счетчик
    UIButton * buttonTableSelection; //Кнопка активации картинки
    
    //Размер картинки-------------------------------------------------
    CGRect imageRact;
}



- (void) viewWillAppear:(BOOL)animated
{
    TitleClass * title = [[TitleClass alloc]initWithTitle:self.catName];
    self.navigationItem.titleView = title;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    
    NSLog(@"%@", self.catName);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayCategoryItems = [NSMutableArray array];
    
    [self getApiOrders:^{
//        NSLog(@"COUNT %i",self.arrayCategoryItems.count);
//        NSLog(@"INF: %@",[self.arrayCategoryItems objectAtIndex:0]);
    
    
    numerator = 0; //Инициализация счетчика строк----------------------------------
    
    //Инициализация анных----------------------------------------------------------
    dataTableItems = [ModelSectionTableOwner dictTableItems];
    
    //Инициализация скрол вью------------------------------------------------------
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:mainScrollView];
    
    //Вставляем товар в скрол вью---------------------------------------------------
        
    if(self.view.bounds.size.height < 586.0f) //Если пишем под 5ку и ниже
    {
        for (int i = 0; i < self.arrayCategoryItems.count; i ++) {
            
            NSDictionary * itemsInfo=[self.arrayCategoryItems objectAtIndex:i];
            
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:
                                            CGRectMake(10,
                                                       150 * i,
                                                       300,
                                                       150)andImageURL:[itemsInfo objectForKey:@"img"] andLabelPrice:[NSString stringWithFormat:@"%ld", [[itemsInfo objectForKey:@"cost"] integerValue]]];
                [mainScrollView addSubview:image];
                
                //Инициализация кнопок активации ячеек-------------------------------
                buttonTableSelection = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTableSelection addTarget:self
                                         action:@selector(buttonTableSelectionAction:)
                               forControlEvents:UIControlEventTouchUpInside];
                buttonTableSelection.backgroundColor = nil;
                buttonTableSelection.tag = i;
                buttonTableSelection.frame = CGRectMake(10,
                                                        150 * i,
                                                        300,
                                                        150);
                [mainScrollView addSubview:buttonTableSelection];
            
            
        }
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 150 * self.arrayCategoryItems.count + 50);
        
    } else { //Если выше то--------------------------------------------
        
    for (int i = 0; i < self.arrayCategoryItems.count; i ++) {
        
        NSDictionary * itemsInfo=[self.arrayCategoryItems objectAtIndex:i];
            if (i % 2 == 0) {
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:
                                            CGRectMake(10,
                                                       self.view.frame.size.width / 4 * numerator,
                                                       self.view.frame.size.width / 2 - 10,
                                                       self.view.frame.size.width / 4) andImageURL:[itemsInfo objectForKey:@"img"] andLabelPrice:[NSString stringWithFormat:@"%ld", [[itemsInfo objectForKey:@"cost"] integerValue]]];
                [mainScrollView addSubview:image];
                
                //Инициализация кнопок активации ячеек-------------------------------
                buttonTableSelection = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTableSelection addTarget:self
                                         action:@selector(buttonTableSelectionAction:)
                               forControlEvents:UIControlEventTouchUpInside];
                buttonTableSelection.backgroundColor = nil;
                buttonTableSelection.tag = i;
                buttonTableSelection.frame = CGRectMake(10,
                                                        self.view.frame.size.width / 4 * numerator,
                                                        self.view.frame.size.width / 2 - 10,
                                                        self.view.frame.size.width / 4);
                [mainScrollView addSubview:buttonTableSelection];

                
            } else {
                
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:
                                            CGRectMake(self.view.frame.size.width / 2,
                                                       self.view.frame.size.width / 4 * numerator,
                                                       self.view.frame.size.width / 2 - 10,
                                                       self.view.frame.size.width / 4)andImageURL:[itemsInfo objectForKey:@"img"] andLabelPrice:[NSString stringWithFormat:@"%ld", [[itemsInfo objectForKey:@"cost"] integerValue]]];
                [mainScrollView addSubview:image];                
                
                //Инициализация кнопок активации ячеек-------------------------------
                buttonTableSelection = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTableSelection addTarget:self
                                         action:@selector(buttonTableSelectionAction:)
                               forControlEvents:UIControlEventTouchUpInside];
                buttonTableSelection.backgroundColor = nil;
                buttonTableSelection.tag = i;
                buttonTableSelection.frame = CGRectMake(self.view.frame.size.width / 2,
                                                        self.view.frame.size.width / 4 * numerator,
                                                        self.view.frame.size.width / 2 - 10,
                                                        self.view.frame.size.width / 4);
                [mainScrollView addSubview:buttonTableSelection];
                
                numerator += 1;
            }
    }
    
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 93.75 * numerator + 50);
    }
    }];
    }
     

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//Метод активации кнопок в ячейках----------------------------------
- (void) buttonTableSelectionAction: (UIButton *) button;
{
    for (int i = 0; i < [dataTableItems[@"price"]count]; i++) {
        if (button.tag == i) {
            NSLog(@"%d", i);
           
        }
    }
    ViewControllerProductDetails * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerProductDetails"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Тащим заказы с сервера
-(void) getApiOrders: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             self.catID,@"cat",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/products_list" complitionBlock:^(id response) {
        
        ParserCategoryResponse * parsingResponce =[[ParserCategoryResponse alloc] init];
        
        [parsingResponce parsing:response andArray:self.arrayCategoryItems andBlock:^{
            
            
            block();
            
        }];
        
        
    }];
    
}

@end
