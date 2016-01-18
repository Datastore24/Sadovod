//
//  LognViewController.m
//  Sadovod
//
//  Created by Viktor on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "LognViewController.h"
#import "LoginTextField.h"

@interface LognViewController () <UITextFieldDelegate>

@end

@implementation LognViewController
{
    LoginTextField * textFielsLoggin;
    LoginTextField * textFielsPassword;
    UIButton * buttonLoggin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Инициализация ввода логина----------------------------------
    textFielsLoggin = [[LoginTextField alloc]
                     initWithFrame:CGRectMake(40, 200, 200, 30)
                                        placeholder:@"Loggin"];
    [self.view addSubview:textFielsLoggin];
    textFielsLoggin.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    textFielsLoggin.delegate = self;
    
    //Инициализация ввода пароля-----------------------------------
    textFielsPassword = [[LoginTextField alloc]
                         initWithFrame:CGRectMake(40, 200, 200, 30)
                         placeholder:@"Password"];
    [self.view addSubview:textFielsPassword];
    textFielsPassword.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
    textFielsPassword.delegate = self;
    
    //Инициализации кнопки запуска---------------------------------
    buttonLoggin = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLoggin addTarget:self
               action:@selector(buttonLogginAction)
     forControlEvents:UIControlEventTouchUpInside];
    [buttonLoggin setTitle:@"Show View" forState:UIControlStateNormal];
    buttonLoggin.backgroundColor = [UIColor blackColor];
    buttonLoggin.frame = CGRectMake(40, 200, 160, 50);
    buttonLoggin.center = CGPointMake(self.view.center.x, self.view.center.y);
    buttonLoggin.layer.cornerRadius = 5.f;
    [self.view addSubview:buttonLoggin];
    

}


#pragma mark - UITextFieldDelegate ViewDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *) returnKeyborad {  // метод делегата, который убирает клавиатуру, когда пользоатель завершил ввод текста и нажал клавишу "ввод"
    [returnKeyborad resignFirstResponder];
    
    
    return YES;
}

- (void) buttonLogginAction
{
    NSLog(@"Запускаем");
}

@end
