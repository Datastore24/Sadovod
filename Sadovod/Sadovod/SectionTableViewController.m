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

@interface SectionTableViewController ()

@end

@implementation SectionTableViewController
{
    NSDictionary * dataTableItems; //Данные
    UIScrollView * mainScrollView; //Основной скрол вью
    NSInteger numerator; //Кастомный счетчик
}

- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"Свитера и кардеганы";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    numerator = 0;
    
    dataTableItems = [ModelSectionTableOwner dictTableItems];
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:mainScrollView];
    
    
    //Вставляем товар в скрол вью----------------------------------------
    NSArray * arrayNameURL = [dataTableItems objectForKey:@"urlImage"];
    for (int i = 0; i < arrayNameURL.count; i ++) {
            if (i % 2 == 0) {
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(10, 75 * numerator, 150, 75)andImageURL:[arrayNameURL objectAtIndex:i] andLabelPrice:[NSString stringWithFormat:@"%ld", [dataTableItems[@"price"][i] integerValue]]];
                [mainScrollView addSubview:image];
            } else {
                ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(160, 75 * numerator, 150, 75)andImageURL:[arrayNameURL objectAtIndex:i] andLabelPrice:[NSString stringWithFormat:@"%ld", [dataTableItems[@"price"][i] integerValue]]];
                [mainScrollView addSubview:image];
                numerator += 1;
            }
    }
        mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 150 * numerator + 50);
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
