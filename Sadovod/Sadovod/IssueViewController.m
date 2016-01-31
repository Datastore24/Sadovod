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
#import "APIPostClass.h"
#import "SingleTone.h"
#import "AlertClass.h"

@interface IssueViewController () <UITextViewDelegate>

@end

@implementation IssueViewController
{
    UIScrollView * mainScrollView;
    UITextView * viewName;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Оформление заказа"];
    self.navigationItem.titleView = title;
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    mainScrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:mainScrollView];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    
//    self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    
    //Контактные данные------------------------------------
    UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 180, 20)];
    labelData.text = @"Контактные данные";
    labelData.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelData.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [mainScrollView addSubview:labelData];
    
    //Ввод имени-------------------------------------------
    UITextView * viewName = [[UITextView alloc] initWithFrame:
                             CGRectMake(10, 40, self.view.frame.size.width - 20, 40)];
    viewName.delegate = self;
    viewName.text = @"Имя";
    viewName.tag = 1;
    viewName.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    viewName.layer.borderWidth = 0.5f;
    viewName.textColor = [UIColor lightGrayColor]; //optional
    [mainScrollView addSubview:viewName];
    
    //Ввод телефона----------------------------------------
    UITextView * viewPhone = [[UITextView alloc] initWithFrame:
                              CGRectMake(10, 80, self.view.frame.size.width - 20, 40)];
    viewPhone.delegate = self;
    viewPhone.text = @"Телефон";
    viewPhone.tag = 2;
    viewPhone.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    viewPhone.layer.borderWidth = 0.5f;
    viewPhone.textColor = [UIColor lightGrayColor]; //optional
    [mainScrollView addSubview:viewPhone];
    
    //Ввод адреcа------------------------------------------
    UITextView * textView = [[UITextView alloc] initWithFrame:
                             CGRectMake(10, 120, self.view.frame.size.width - 20, 80)];
    textView.delegate = self;
    textView.text = @"Адрес";
    textView.tag = 3;
    textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    textView.layer.borderWidth = 0.5f;
    textView.textColor = [UIColor lightGrayColor]; //optional
    [mainScrollView addSubview:textView];
    
    //Лейбл комментариев-----------------------------------
    
    UILabel * labelComment = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 180, 20)];
    labelComment.text = @"Комментарии к заказу";
    labelComment.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelComment.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [mainScrollView addSubview:labelComment];
    
    //Ввод комментария------------------------------------------
    UITextView * commentView = [[UITextView alloc] initWithFrame:
                             CGRectMake(10, 240, self.view.frame.size.width - 20, 80)];
    commentView.delegate = self;
    commentView.text = @"Введите комментарий";
    commentView.tag = 4;
    commentView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    commentView.layer.borderWidth = 0.5f;
    commentView.textColor = [UIColor lightGrayColor]; //optional
    [mainScrollView addSubview:commentView];
    
    //Кнопка подтверждения----------------------------------
    UIButton * buttonConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonConfirm.frame = CGRectMake(10, 330, self.view.frame.size.width - 20, 35);
    buttonConfirm.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
    [buttonConfirm setTitle:@"Оформить заказ" forState:UIControlStateNormal];
    [buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonConfirm addTarget:self action:@selector(buttonConfirmAction)
            forControlEvents:UIControlEventTouchUpInside];
    
    [mainScrollView addSubview:buttonConfirm];
    
    
  
}


#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView.tag == 1) {
        if ([textView.text isEqualToString:@"Имя"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor]; //optional
        }
       
    } else if (textView.tag == 2) {
        if ([textView.text isEqualToString:@"Телефон"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor]; //optional
        }
        } else if (textView.tag == 3) {
            if ([textView.text isEqualToString:@"Адрес"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor]; //optional
        }
        } else if (textView.tag == 4) {
            if ([textView.text isEqualToString:@"Введите комментарий"]) {
                textView.text = @"";
                textView.textColor = [UIColor blackColor]; //optional
            }
        }
    [textView becomeFirstResponder];
    
    
    mainScrollView.contentOffset = (CGPoint){
        0, // ось x нас не интересует
        CGRectGetMinY(textView.frame) // Скроллим скролл к верхней границе текстового поля - Вы можете настроить эту величину по своему усмотрению
    };

}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.tag == 1) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Имя";
            textView.textColor = [UIColor lightGrayColor]; //optional
        }
        
    } else if (textView.tag == 2) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Телефон";
            textView.textColor = [UIColor lightGrayColor]; //optional
        }
    } else if (textView.tag == 3) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Адрес";
            textView.textColor = [UIColor lightGrayColor]; //optional
        }
    } else if (textView.tag == 4) {
        if ([textView.text isEqualToString:@""]) {
            textView.text = @"Введите комментарий";
            textView.textColor = [UIColor lightGrayColor]; //optional
        }
    }
    [textView resignFirstResponder];
    
    mainScrollView.contentOffset = (CGPoint){0, 0}; // Возвращаем скролл в начало, так как редактирование текстового поля закончено
}

- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}



- (void) buttonConfirmAction
{
    UITextView * viewName = (UITextView *)[self.view viewWithTag:1];
    UITextView * viewPhone = (UITextView *)[self.view viewWithTag:2];
    UITextView * textView = (UITextView *)[self.view viewWithTag:3];
    UITextView * commentView = (UITextView *)[self.view viewWithTag:4];
    
    [self postApiDelItemToCart:viewName.text andPhone:viewPhone.text andAddress:textView.text andComment:commentView.text];
    
    NSLog(@"buttonConfirmAction");
}

//Удаление одного товара
- (void)postApiDelItemToCart:(NSString *) name andPhone: (NSString *) phone andAddress:(NSString *) address
                  andComment:(NSString *) comment;
{
    //Передаваемые параметры
    
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            name,@"name",
                            phone,@"phone",
                            address,@"address",
                            comment,@"comment",
                            nil];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params
                        andAddParam:nil
                             method:@"abpro/send_order"
                    complitionBlock:^(id response) {
                        
                        [activityIndicator setHidden:YES];
                        [activityIndicator stopAnimating];
                        
                        NSDictionary* dict = (NSDictionary*)response;
                        if ([[dict objectForKey:@"status"] integerValue] == 1) {
                            
                            [AlertClass showAlertViewWithMessage:@"Ваш заказ успешно создан" view:self];
                            
                        }else {
                            
                        }
                    }];
}


@end
