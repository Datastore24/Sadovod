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
#import "DecorView.h"
#import "IssueViewController.h"

#import "APIGetClass.h"
#import "ParserCategory.h"
#import "ParserCategoryResponse.h"
#import "SingleTone.h"

#import "CartUpdaterClass.h"

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

-(void)viewWillAppear:(BOOL)animated{
    
    if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 2 && [[SingleTone sharedManager] orderCart])
    {
        [CartUpdaterClass updateCartWithApi:self.view];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:self.catName];
    self.navigationItem.titleView = title;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    
    
    self.arrayCategoryItems = [NSMutableArray array];
    
    [self getApiProductOfCategory:^{
    
    
    numerator = 0; //Инициализация счетчика строк----------------------------------
    
    //Инициализация анных----------------------------------------------------------
    dataTableItems = [ModelSectionTableOwner dictTableItems];
    
    //Инициализация скрол вью------------------------------------------------------
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:mainScrollView];
    
    //Вставляем товар в скрол вью---------------------------------------------------
        
    if(self.view.bounds.size.height < 586.0f) //Если пишем под 5ку и ниже
    {
        for (int i = 0; i < self.arrayCategoryItems.count; i ++) {
            
            NSDictionary * itemsInfo=[self.arrayCategoryItems objectAtIndex:i];
          
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:
                                            CGRectMake(0,
                                                       320 * i - 2.5,
                                                       self.view.bounds.size.width + 2.5,
                                                       320)andImageURL:[itemsInfo objectForKey:@"img"]
                                            isInternetURL:YES
                                                                     andLabelPrice:[NSString stringWithFormat:@"%ld", [[itemsInfo objectForKey:@"cost"] integerValue]]andResized:NO];
                [mainScrollView addSubview:image];
                
                //Инициализация кнопок активации ячеек-------------------------------
                buttonTableSelection = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTableSelection addTarget:self
                                         action:@selector(buttonTableSelectionAction:)
                               forControlEvents:UIControlEventTouchUpInside];
                buttonTableSelection.backgroundColor = nil;
                buttonTableSelection.tag = i;
                buttonTableSelection.frame = CGRectMake(0,
                                                        320 * i,
                                                        self.view.bounds.size.width,
                                                        320);
                [mainScrollView addSubview:buttonTableSelection];
            
            
        }
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 320 * self.arrayCategoryItems.count + 50);
        
    } else { //Если выше то--------------------------------------------
        
    for (int i = 0; i < self.arrayCategoryItems.count; i ++) {
        
        NSDictionary * itemsInfo=[self.arrayCategoryItems objectAtIndex:i];
            if (i % 2 == 0) {
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:
                                            CGRectMake(0,
                                                       self.view.frame.size.width /2 * numerator,
                                                       self.view.frame.size.width / 2,
                                                       self.view.frame.size.width/2 ) andImageURL:[itemsInfo objectForKey:@"img"]
                                             isInternetURL:YES
                                                                     andLabelPrice:[NSString stringWithFormat:@"%ld", [[itemsInfo objectForKey:@"cost"] integerValue]] andResized:YES];
                [mainScrollView addSubview:image];
                
                //Инициализация кнопок активации ячеек-------------------------------
                buttonTableSelection = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTableSelection addTarget:self
                                         action:@selector(buttonTableSelectionAction:)
                               forControlEvents:UIControlEventTouchUpInside];
                buttonTableSelection.backgroundColor = nil;
                buttonTableSelection.tag = i;
                buttonTableSelection.frame = CGRectMake(10,
                                                        self.view.frame.size.width/2 * numerator,
                                                        self.view.frame.size.width / 2 ,
                                                        self.view.frame.size.width/2 );
                [mainScrollView addSubview:buttonTableSelection];

                
            } else {
                
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:
                                            CGRectMake(self.view.frame.size.width / 2 + 2.5,
                                                       self.view.frame.size.width /2  * numerator,
                                                       self.view.frame.size.width / 2 ,
                                                       self.view.frame.size.width /2 )andImageURL:[itemsInfo objectForKey:@"img"]
                                             isInternetURL:YES
                                                                     andLabelPrice:[NSString stringWithFormat:@"%ld", [[itemsInfo objectForKey:@"cost"] integerValue]] andResized:YES];
                [mainScrollView addSubview:image];                
                
                //Инициализация кнопок активации ячеек-------------------------------
                buttonTableSelection = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTableSelection addTarget:self
                                         action:@selector(buttonTableSelectionAction:)
                               forControlEvents:UIControlEventTouchUpInside];
                buttonTableSelection.backgroundColor = nil;
                buttonTableSelection.tag = i;
                buttonTableSelection.frame = CGRectMake(self.view.frame.size.width / 2,
                                                        self.view.frame.size.width /2  * numerator,
                                                        self.view.frame.size.width / 2 ,
                                                        self.view.frame.size.width/2 );
                [mainScrollView addSubview:buttonTableSelection];
                
                numerator += 1;
            }
    }
    
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width /2 * numerator + 50);
    }
        
        
        if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 2 && [[SingleTone sharedManager] orderCart])
        {
            NSDictionary * cartOrder = [[SingleTone sharedManager] orderCart];
            
            DecorView * decor = [[DecorView alloc] initWithView:self.view andNumber:[cartOrder objectForKey:@"count"] andPrice:[cartOrder objectForKey:@"cost"] andWithBlock:NO];
            [self.view addSubview:decor];
            CGRect rect = decor.frame;
            rect.origin.y = rect.origin.y + 64;
            decor.frame = rect;
            
            if([[cartOrder objectForKey:@"cost"] integerValue] ==0){
                decor.alpha = 0;
            }else{
               decor.alpha = 0.7;
            }

            
            [self.view addSubview:decor];
            
            UIButton * buttonDecor = (UIButton *)[self.view viewWithTag:555];
            [buttonDecor addTarget:self action:@selector(buttonDecorAction) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    }];
    
    }
     

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//Метод активации кнопок в ячейках----------------------------------
- (void) buttonTableSelectionAction: (UIButton *) button;
{

    NSDictionary * itemsInfo=[self.arrayCategoryItems objectAtIndex:button.tag];
    
    
    ViewControllerProductDetails * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewControllerProductDetails"];
    detail.productID = [itemsInfo objectForKey:@"id"];
    detail.productName = [itemsInfo objectForKey:@"name"];
    
    [self.navigationController pushViewController:detail animated:YES];
}

//Тащим товары категории
-(void) getApiProductOfCategory: (void (^)(void))block{
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

- (void) buttonDecorAction
{
    IssueViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"IssueViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
