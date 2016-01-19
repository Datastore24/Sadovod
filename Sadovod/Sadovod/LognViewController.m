//
//  LognViewController.m
//  Sadovod
//
//  Created by Viktor on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "LognViewController.h"
#import "LoginTextField.h"
#import "AlertClass.h"
#import "ViewController.h"

#import "AuthDbClass.h"
#import "APIGetClass.h"
#import "APIPostClass.h"
#import "ParserAuthKey.h"
#import "ParserAuthResponse.h"
#import "ParserLoginPassword.h"
#import "ParserLoginPasswordResponse.h"
#import "Auth.h"
#import "SingleTone.h"
#import <MagicalRecord/MagicalRecord.h>

@interface LognViewController () <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray * arrayResponce; //Массив с данными API
@property (strong, nonatomic) NSMutableArray * arrayCheck; //Массив с данными API
@property (strong, nonatomic) NSString * key; //Массив с данными API


@end

@implementation LognViewController
{
    LoginTextField * textFielsLoggin;
    LoginTextField * textFielsPassword;
    UIButton * buttonLoggin;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    self.navigationController.navigationBar.userInteractionEnabled = NO;
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    //Инициализация ввода логина----------------------------------
    textFielsLoggin = [[LoginTextField alloc]
                     initWithFrame:CGRectMake(40, 200, 200, 30)
                                        placeholder:@"Логин"];
    [self.view addSubview:textFielsLoggin];
    textFielsLoggin.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    textFielsLoggin.delegate = self;
    
    //Инициализация ввода пароля-----------------------------------
    textFielsPassword = [[LoginTextField alloc]
                         initWithFrame:CGRectMake(40, 200, 200, 30)
                         placeholder:@"Пароль"];
    [self.view addSubview:textFielsPassword];
    textFielsPassword.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
    textFielsPassword.delegate = self;
    
    //Инициализации кнопки запуска---------------------------------
    buttonLoggin = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonLoggin addTarget:self
               action:@selector(buttonLogginAction)
     forControlEvents:UIControlEventTouchUpInside];
    [buttonLoggin setTitle:@"Войти" forState:UIControlStateNormal];
    buttonLoggin.backgroundColor = [UIColor blackColor];
    buttonLoggin.frame = CGRectMake(40, 200, 160, 50);
    buttonLoggin.center = CGPointMake(self.view.center.x, self.view.center.y);
    buttonLoggin.layer.cornerRadius = 5.f;
    [self.view addSubview:buttonLoggin];

    [self CheckAuth];

}


#pragma mark - UITextFieldDelegate ViewDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *) returnKeyborad {  // метод делегата, который убирает клавиатуру, когда пользоатель завершил ввод текста и нажал клавишу "ввод"
    [returnKeyborad resignFirstResponder];
    
    
    return YES;
}

- (void) buttonLogginAction
{
    NSLog(@"Запускаем");

    
    if (textFielsLoggin.text.length == 0 && textFielsPassword.text.length == 0) {
        
        [AlertClass showAlertViewWithMessage:@"Введите Логин и Пароль" view:self];
    }
    
    else if (textFielsLoggin.text.length == 0) {
        [AlertClass showAlertViewWithMessage:@"Введите Логин" view:self];
      
    }
    
    else if (textFielsPassword.text.length == 0) {
        [AlertClass showAlertViewWithMessage:@"Введите Пароль" view:self];
    }
    
    else {
        
        //
        
        AuthDbClass * auth = [[AuthDbClass alloc] init];
        NSArray * array = [auth showAllUsers]; //Массив данных CoreData
        NSLog(@"Счетчик кнопки: %i",array.count);
        
        if (!array || !array.count){
         [self getKey:^{
             [self getAuth:textFielsLoggin.text password:textFielsPassword.text andKey:self.key andBlock:^{
                 
                 ParserLoginPassword * parse = [self.arrayResponce objectAtIndex:0];
                 NSLog(@"STATUS:%@",parse.status);
                 NSLog(@"TOKEN:%@",parse.token);
                 
                 //Проверка главного ключа входа 1- успешно, 0 - неуспешно
                 if([parse.status isEqualToString:@"1"]){
                     AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
                     
                     //Проверка существует ли пользователь в CoreData
                     
                     if(![authDbClass checkUsers:textFielsLoggin.text andPassword:textFielsPassword.text]){
                         
                         //Добавление данных успешно вошедшего пользователя в CoreData
                         [authDbClass authFist:textFielsLoggin.text andPassword:textFielsPassword.text andEnter:@"1" andKey:self.key];
                         [authDbClass updateToken:parse.token];
                         
                         
                         
                     }
                     //Переход в меню
                     ViewController * mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyShowcase"];
                     [self.navigationController pushViewController:mainView animated:YES];
                    
                     
                 }else{
                     
                     [AlertClass showAlertViewWithMessage:@"Не верный логин или пароль" view:self];
                 }
             }];
         }];
        }else{
            
            //Необходимо спрограммировать смену пользователя с удалением текущего,
            //Необходимо обновить все кроме самомго KEY
            
            
            NSLog(@"В базе найдены сочетания");
            Auth * authCoreData = [array objectAtIndex:0];
            BOOL keyTrue=[auth checkKey:authCoreData.key];
            [self getAuth:textFielsLoggin.text password:textFielsPassword.text andKey:authCoreData.key andBlock:^{
                ParserLoginPassword * parse = [self.arrayResponce objectAtIndex:0];
                NSLog(@"STATUS:%@",parse.status);
                NSLog(@"TOKEN:%@",parse.token);
                
                //Проверка главного ключа входа 1- успешно, 0 - неуспешно
                if([parse.status isEqualToString:@"1"]){
                    AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
                    
                    //Проверка существует ли пользователь в CoreData
                    
                    if(![authDbClass checkUsers:textFielsLoggin.text andPassword:textFielsPassword.text]){
                        
                        //Добавление данных успешно вошедшего пользователя в CoreData
                        [authDbClass UpdateUserWithOutKey:textFielsLoggin.text password:textFielsPassword.text];
                        [authDbClass updateToken:parse.token];
                        
                        
                        
                    }
                    //Переход в меню
                    ViewController * mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyShowcase"];
                    [self.navigationController pushViewController:mainView animated:YES];
                    
                    
                }else{
                    
                    [AlertClass showAlertViewWithMessage:@"Не верный логин или пароль" view:self];
                }

            }];

            
        }
        
        
        
        
        
    }
}

#pragma mark - API

-(void) getKey:(void (^)(void))block{
    NSDictionary * params = nil;
    APIGetClass * api = [APIGetClass new]; //Создаем экземпляр API
    [api getDataFromServerWithParams:params method:@"abpro/check_superkey" complitionBlock:^(id response) {
        ParserAuthResponse * parsingResponce = [[ParserAuthResponse alloc] init];
        
        ParserAuthKey * parserAuthKey =[[parsingResponce parsing:response] objectAtIndex:0];
        //                //Проверка существует ли пользователь в CoreData
        self.key=parserAuthKey.key;
       
        block();
        

    }];
    
}
//Отправление ключа при авторизации
-(void) sendKey: (NSString*) key{
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             key,@"key",
                             nil];
    APIPostClass * apiPost = [APIPostClass new]; //Создаем экземпляр API
    [apiPost postDataToServerWithParams:params method:@"abpro/check_superkey" complitionBlock:^(id response) {
        
    }];
    
}

////Авторизация пользователей
-(void) getAuth:(NSString *) login password: (NSString *) password andKey:(NSString*) key andBlock:(void (^)(void))block{
    

    //Передаваемые параметры

   NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             login,@"login",
                             password,@"password",
                             key,@"key",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/auth" complitionBlock:^(id response) {
        
        ParserLoginPasswordResponse * parsingLoginPasswordResponce =[[ParserLoginPasswordResponse alloc] init];
        
        
        //парсинг данных и запись в массив
        self.arrayResponce = [parsingLoginPasswordResponce parsing:response];
       
        NSLog(@"RESPONSE: %@",response);
        
        block();
    }];
    
    
}
//

//Проверка существует ли такой пользователь или нет
-(void) getApiAuthCheck:(NSString *) login password: (NSString *) password key: (NSString*) key andBlock:(void (^)(void))block{
    //Передаваемые параметры
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             login,@"login",
                             password,@"password",
                             key,@"key",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/auth" complitionBlock:^(id response) {
        
        ParserAuthResponse * parsingResponce =[[ParserAuthResponse alloc] init];
        
        //парсинг данных и запись в массив
        self.arrayCheck = [parsingResponce parsing:response];
        [[SingleTone sharedManager] setParsingArray:self.arrayCheck];
        block();
    }];
    
}

//Проверяем входил ли пользователь, если входил перекидывай на меню
-(void) CheckAuth{
    
    
    AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
    //[authDbClass deleteAuth];
    NSArray * arrayUser = [authDbClass showAllUsers]; //Массив данных CoreData
    NSLog(@"ARRAY COUNT %i",arrayUser.count);
    for (int i; i<arrayUser.count; i++) {
        Auth * authCoreData = [arrayUser objectAtIndex:i];
        NSLog(@"KEY %@",authCoreData.key);
        NSLog(@"UID %@",authCoreData.uid);
        NSLog(@"LOGIN %@",authCoreData.login);
        NSLog(@"PASSWORD %@",authCoreData.password);
        NSLog(@"TOKEN %@",authCoreData.token);
        NSLog(@"ENTER %@",authCoreData.enter);
    }
    
    Auth * authCoreData = [arrayUser objectAtIndex:0];
    if ((arrayUser || arrayUser.count) && ![authCoreData.enter isEqualToString:@"0"]){
        if(arrayUser.count>1){
            NSLog(@"Больше чем нужно");
            [authDbClass deleteAuth];
            
        }
        for (int i; i<arrayUser.count; i++) {
            NSLog(@"ЦИКЛ");
            Auth * authCoreData = [arrayUser objectAtIndex:i];
            
            //Проверка существования пользователя
            
            if(authCoreData.login != nil || authCoreData.password != nil || authCoreData.key != nil){
                
                [self getApiAuthCheck:authCoreData.login password:authCoreData.password key:authCoreData.key andBlock:^{
                    ParserAuthKey * parse = [self.arrayCheck objectAtIndex:0];
                    
                    //Перенаправление пользоваетеля в слуачае если данные из базы и данные с сервера соответствуют
                    
                    if([parse.status isEqual: @"1"]){
                        ViewController * mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyShowcase"];
                        [self.navigationController pushViewController:mainView animated:YES];
                    }
                    
                }];
                
            }

                
            }
        
        
    }
    
    
    
}


@end
