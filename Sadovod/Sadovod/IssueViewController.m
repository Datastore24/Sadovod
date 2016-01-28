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

@interface IssueViewController () <UITextViewDelegate>

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
    UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 180, 20)];
    labelData.text = @"Контактные данные";
    labelData.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelData.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [self.view addSubview:labelData];
    
    //Ввод имени-------------------------------------------
    UITextView * viewName = [[UITextView alloc] initWithFrame:
                             CGRectMake(10, 40, self.view.frame.size.width - 20, 40)];
    viewName.delegate = self;
    viewName.text = @"Имя";
    viewName.tag = 1;
    viewName.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    viewName.layer.borderWidth = 0.5f;
    viewName.textColor = [UIColor lightGrayColor]; //optional
    [self.view addSubview:viewName];
    
    //Ввод телефона----------------------------------------
    UITextView * viewPhone = [[UITextView alloc] initWithFrame:
                              CGRectMake(10, 80, self.view.frame.size.width - 20, 40)];
    viewPhone.delegate = self;
    viewPhone.text = @"Телефон";
    viewPhone.tag = 2;
    viewPhone.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    viewPhone.layer.borderWidth = 0.5f;
    viewPhone.textColor = [UIColor lightGrayColor]; //optional
    [self.view addSubview:viewPhone];
    
    //Ввод адрема------------------------------------------
    UITextView * textView = [[UITextView alloc] initWithFrame:
                             CGRectMake(10, 120, self.view.frame.size.width - 20, 80)];
    textView.delegate = self;
    textView.text = @"Адрес";
    textView.tag = 3;
    textView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    textView.layer.borderWidth = 0.5f;
    textView.textColor = [UIColor lightGrayColor]; //optional
    [self.view addSubview:textView];
    
    //Лейбл комментариев-----------------------------------
    
    UILabel * labelComment = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 180, 20)];
    labelComment.text = @"Комментарии к заказу";
    labelComment.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelComment.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [self.view addSubview:labelComment];
    
    //Ввод адрема------------------------------------------
    UITextView * commentView = [[UITextView alloc] initWithFrame:
                             CGRectMake(10, 240, self.view.frame.size.width - 20, 80)];
    commentView.delegate = self;
    commentView.text = @"Введите комментарий";
    commentView.tag = 4;
    commentView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    commentView.layer.borderWidth = 0.5f;
    commentView.textColor = [UIColor lightGrayColor]; //optional
    [self.view addSubview:commentView];
    
    //Кнопка подтверждения----------------------------------
    UIButton * buttonConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonConfirm.frame = CGRectMake(10, 330, self.view.frame.size.width - 20, 35);
    buttonConfirm.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
    [buttonConfirm setTitle:@"Оформить заказ" forState:UIControlStateNormal];
    [buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonConfirm addTarget:self action:@selector(buttonConfirmAction)
            forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonConfirm];
    
    
  
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
    NSLog(@"buttonConfirmAction");
}


@end
