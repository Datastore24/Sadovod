//
//  IssueViewController.m
//  Sadovod
//
//  Created by Viktor on 28.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "IssueViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"

@interface IssueViewController () <UITextFieldDelegate>

@end

@implementation IssueViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Оформление заказа"];
    self.navigationItem.titleView = title;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    //Контактные данные------------------------------------
    UILabel * labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 180, 20)];
    labelPhone.text = @"Контактные данные";
    labelPhone.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelPhone.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [self.view addSubview:labelPhone];
    
    //Ввод имени-------------------------------------------
    UIView * viewName = [[UIView alloc] initWithFrame:CGRectMake(10, 40, self.view.frame.size.width - 20, 40)];
    viewName.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewName];
    
    UITextField * textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
    textFieldName.backgroundColor = nil;
    [viewName addSubview:textFieldName];
    
  
}

//    UILabel * labelPhoneChange = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, 250, 20)];
//    labelPhoneChange.text = text;
//    labelPhoneChange.textColor = [UIColor colorWithHexString:@"a9a9a9"];
//    labelPhoneChange.font = [UIFont fontWithName:@"HelveticaNeue" size:13];


@end
