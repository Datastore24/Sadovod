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

@interface SectionTableViewController ()

@end

@implementation SectionTableViewController
{
    NSDictionary * dataTableItems; //Данные
    UIScrollView * mainScrollView; //Основной скрол вью
    NSInteger numerator; //Кастомный счетчик
    UIButton * buttonTableSelection; //Кнопка активации картинки
}

- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"Свитера и кардеганы";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    numerator = 0; //Инициализация счетчика строк----------------------------------
    
    //Инициализация анных----------------------------------------------------------
    dataTableItems = [ModelSectionTableOwner dictTableItems];
    
    //Инициализация скрол вью------------------------------------------------------
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:mainScrollView];
    
    //Вставляем товар в скрол вью---------------------------------------------------
    NSArray * arrayNameURL = [dataTableItems objectForKey:@"urlImage"];
    for (int i = 0; i < arrayNameURL.count; i ++) {
            if (i % 2 == 0) {
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(10, 75 * numerator, 150, 75)andImageURL:[arrayNameURL objectAtIndex:i] andLabelPrice:[NSString stringWithFormat:@"%ld", [dataTableItems[@"price"][i] integerValue]]];
                [mainScrollView addSubview:image];
                
                //Инициализация кнопок активации ячеек-------------------------------
                buttonTableSelection = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTableSelection addTarget:self
                                         action:@selector(buttonTableSelectionAction:)
                               forControlEvents:UIControlEventTouchUpInside];
                buttonTableSelection.backgroundColor = nil;
                buttonTableSelection.tag = i;
                buttonTableSelection.frame = CGRectMake(10, 75 * numerator, 150, 75);
                [mainScrollView addSubview:buttonTableSelection];
                
                NSLog(@"%ld", (long)buttonTableSelection.tag);
                
            } else {
                
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(160, 75 * numerator, 150, 75)andImageURL:[arrayNameURL objectAtIndex:i] andLabelPrice:[NSString stringWithFormat:@"%ld", [dataTableItems[@"price"][i] integerValue]]];
                [mainScrollView addSubview:image];                
                
                //Инициализация кнопок активации ячеек-------------------------------
                buttonTableSelection = [UIButton buttonWithType:UIButtonTypeCustom];
                [buttonTableSelection addTarget:self
                                         action:@selector(buttonTableSelectionAction:)
                               forControlEvents:UIControlEventTouchUpInside];
                buttonTableSelection.backgroundColor = nil;
                buttonTableSelection.tag = i;
                buttonTableSelection.frame = CGRectMake(160, 75 * numerator, 150, 75);
                [mainScrollView addSubview:buttonTableSelection];
                
                NSLog(@"%ld", (long)buttonTableSelection.tag);
                
                numerator += 1;
            }
    }
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 75 * numerator + 50);
    //Отображение тестового алерта
    
    [AlertClass showAlertViewWithMessage:@"Отображение тестового алерта!" view:self];
    //
    
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

@end
