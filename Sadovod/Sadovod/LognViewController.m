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
#import "TitleClass.h"

@interface LognViewController () <UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray * arrayResponce; //Массив с данными API
@property (strong, nonatomic) NSMutableArray * arrayCheck; //Массив с данными API
@property (strong, nonatomic) NSString * super_key; //Ключ
@property (strong, nonatomic) NSString * catalog_key; //Каталожный ключ
@property (strong, nonatomic) NSString * type; //Каталожный ключ


@end

@implementation LognViewController
{
    LoginTextField * textFielsLoggin;
    LoginTextField * textFielsPassword;
    UIButton * buttonLoggin;
    UIView * loadView;
    UILabel * label;
    UILabel * labelTwo;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NOTIFICATION
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideView) name:@"CheckUser" object:nil];
    
    //

    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Логин"];
    self.navigationItem.titleView = title;
    
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
    textFielsPassword.secureTextEntry = YES;
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
    
    loadView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y-64, 260, 200)];
    loadView.center = CGPointMake(self.view.center.x, self.view.center.y-64);
    loadView.layer.cornerRadius = 10;
    loadView.layer.masksToBounds = YES;
    loadView.backgroundColor = [UIColor lightGrayColor];
    loadView.alpha = 1;
    [self.view addSubview:loadView];
    
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(loadView.frame.size.width/2 - 110 ,40, 250, 40)];
    //label.center = CGPointMake(self.view.center.x, self.view.center.y-64);
    label.textColor = [UIColor whiteColor];
    label.text = @"Проверка логина и пароля";
    
    [loadView addSubview:label];
    
    
    labelTwo = [[UILabel alloc] initWithFrame:CGRectMake(loadView.frame.size.width/2 - 110 ,80, 250, 40)];
    //label.center = CGPointMake(self.view.center.x, self.view.center.y-64);
    labelTwo.textColor = [UIColor whiteColor];
    labelTwo.text = @"Проверка ключей доступа";
    labelTwo.alpha = 0;
    [loadView addSubview:labelTwo];
    
    
    [UIView animateWithDuration:0.9 animations:^{
        labelTwo.alpha = 1;
    }];
    
    
    
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.tag=666;
    activityIndicator.center=CGPointMake(loadView.frame.size.width/2,loadView.frame.size.width/2+20);
    [activityIndicator startAnimating];
    [loadView addSubview:activityIndicator];

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
             [self getAuth:textFielsLoggin.text password:textFielsPassword.text andKey:self.super_key andBlock:^{
                 
                 ParserLoginPassword * parse = [self.arrayResponce objectAtIndex:0];
                 NSLog(@"STATUS:%@",parse.status);
                 NSLog(@"TOKEN:%@",parse.token);
                 NSLog(@"TYPE:%@",parse.type);
                 
                 //Проверка главного ключа входа 1- успешно, 0 - неуспешно
                 if([parse.status isEqualToString:@"1"]){
                     AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
                     
                     //Проверка существует ли пользователь в CoreData
                     
                     if(![authDbClass checkUsers:textFielsLoggin.text andPassword:textFielsPassword.text]){
                         
                         //Добавление данных успешно вошедшего пользователя в CoreData
                         NSLog(@"CATALOGK :%@ KEY:%@",self.catalog_key,self.super_key);
                         [authDbClass authFist:textFielsLoggin.text andPassword:textFielsPassword.text andEnter:@"1" andKey:self.super_key andCatalogKey:self.catalog_key];
                         [authDbClass updateToken:parse.token];
                         [[SingleTone sharedManager] setParsingToken:parse.token];
                         [[SingleTone sharedManager] setLoginUser:textFielsLoggin.text];
                         
                         
                         
                     }
                     //Переход в меню
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadMenu" object:self];
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
//          BOOL keyTrue=[auth checkKey:authCoreData.key andCatalogKey:authCoreData.catalogkey];
            [self getAuth:textFielsLoggin.text password:textFielsPassword.text andKey:authCoreData.key andBlock:^{
                ParserLoginPassword * parse = [self.arrayResponce objectAtIndex:0];
                NSLog(@"STATUS:%@",parse.status);
                NSLog(@"TOKEN:%@",parse.token);
                NSLog(@"authCoreData.key: %@ CATALOG %@",authCoreData.key,authCoreData.catalogkey);
                
                
                //Проверка главного ключа входа 1- успешно, 0 - неуспешно
                if([parse.status isEqualToString:@"1"]){
                    
                    AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
                    
                    //Проверка существует ли пользователь в CoreData
                    
                    if(![authDbClass checkUsers:textFielsLoggin.text andPassword:textFielsPassword.text]){
                        
                        //Добавление данных успешно вошедшего пользователя в CoreData
                        [authDbClass UpdateUserWithOutKey:textFielsLoggin.text password:textFielsPassword.text];
                        [authDbClass updateToken:parse.token];
                        [self sendKey:authCoreData.key andCatalogKey:authCoreData.catalogkey];
                        [[SingleTone sharedManager] setParsingToken:parse.token];
                        [[SingleTone sharedManager] setLoginUser:textFielsLoggin.text];
                        
                        
                        
                    }
                    //Переход в меню
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadMenu" object:self];
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
    [api getDataFromServerWithParams:params method:@"abpro/check_keys" complitionBlock:^(id response) {
        ParserAuthResponse * parsingResponce = [[ParserAuthResponse alloc] init];
        NSLog(@"RESPONSE %@",response);
        ParserAuthKey * parserAuthKey =[[parsingResponce parsing:response] objectAtIndex:0];
        //                //Проверка существует ли пользователь в CoreData
        self.super_key=parserAuthKey.super_key;
        self.catalog_key=parserAuthKey.catalog_key;
        if(parserAuthKey.catalog_key){
                block();
        }
        
        

    }];
    
}
//Отправление ключа при авторизации
-(void) sendKey: (NSString*) superKey andCatalogKey: (NSString*) catalogKey{
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             superKey,@"super_key",
                             catalogKey,@"catalog_key",
                             nil];
    APIPostClass * apiPost = [APIPostClass new]; //Создаем экземпляр API
    [apiPost postDataToServerWithParams:params andAddParam:nil method:@"abpro/check_keys" complitionBlock:^(id response) {
        
    }];
    
}

////Авторизация пользователей
-(void) getAuth:(NSString *) login password: (NSString *) password andKey:(NSString*) super_key andBlock:(void (^)(void))block{
    

    //Передаваемые параметры

   NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             login,@"login",
                             password,@"password",
                             super_key,@"key",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/auth" complitionBlock:^(id response) {
        
        ParserLoginPasswordResponse * parsingLoginPasswordResponce =[[ParserLoginPasswordResponse alloc] init];
        
        
        //парсинг данных и запись в массив
        self.arrayResponce = [parsingLoginPasswordResponce parsing:response];
        
        NSDictionary * userInfoDict =[[NSDictionary alloc] initWithDictionary:response];
        NSLog(@"SG TYPE:%@",[userInfoDict objectForKey:@"type"]);
        
        [[SingleTone sharedManager] setTypeOfUsers:[userInfoDict objectForKey:@"type"]];
       
        
        block();
    }];
    
    
}
//

//Проверка существует ли такой пользователь или нет
-(void) getApiAuthCheck:(NSString *) login password: (NSString *) password key: (NSString*) super_key andBlock:(void (^)(void))block{
    //Передаваемые параметры
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             login,@"login",
                             password,@"password",
                             super_key,@"key",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/auth" complitionBlock:^(id response) {
        
        ParserAuthResponse * parsingResponce =[[ParserAuthResponse alloc] init];
        
        //парсинг данных и запись в массив
        self.arrayCheck = [parsingResponce parsing:response];
        
        NSDictionary * userInfoDict =[[NSDictionary alloc] initWithDictionary:response];
        
        [[SingleTone sharedManager] setTypeOfUsers:[userInfoDict objectForKey:@"type"]];
        
        
        [[SingleTone sharedManager] setParsingArray:self.arrayCheck];
        
        block();
    }];
    
}

//Проверяем входил ли пользователь, если входил перекидывай на меню
-(void) CheckAuth{
    
    
    
    
    AuthDbClass * authDbClass = [[AuthDbClass alloc] init];
    NSArray * arrayUser = [authDbClass showAllUsers]; //Массив данных CoreData
    if(arrayUser.count>0){
    Auth * authCoreData = [arrayUser objectAtIndex:0];
   
    if (![authCoreData.enter isEqualToString:@"0"]){
        NSLog(@"ENTER: 1");
        if(arrayUser.count>1){
            
            [authDbClass deleteAuth];
            
        }
        for (int i=0; i<arrayUser.count; i++) {
            
            Auth * authCoreData = [arrayUser objectAtIndex:i];
            
            //Проверка существования пользователя
            
            if(authCoreData.login != nil && authCoreData.password != nil && authCoreData.key != nil && authCoreData.catalogkey != nil){
               NSLog(@"COREDATA KEY %@, CatalogKEY: %@ TOKEN: %@",authCoreData.key,authCoreData.catalogkey,authCoreData.token);
                [self getApiAuthCheck:authCoreData.login password:authCoreData.password key:authCoreData.key andBlock:^{

                    
                    
                    ParserAuthKey * parse = [self.arrayCheck objectAtIndex:0];
                   
          
                    
                    //Перенаправление пользоваетеля в слуачае если данные из базы и данные с сервера соответствуют
                    
                    if([parse.status isEqual: @"1"]){
                        [UIView animateWithDuration:0.3 animations:^{
                            loadView.alpha = 0;
                        }];
                        
                        [[SingleTone sharedManager] setLoginUser:authCoreData.login];
                        [[SingleTone sharedManager] setParsingToken:authCoreData.token];
                       
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadMenu" object:self];
                        ViewController * mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyShowcase"];
                        [self.navigationController pushViewController:mainView animated:YES];
                        
                    } else {
                       [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckUser" object:self];
                    }
                    
                }];
                
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckUser" object:self];
            }

                
            }
        
        
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckUser" object:self];
    }
    
    }else{
       [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckUser" object:self];
        
    }
    
}

-(void)hideView{
    
            UIActivityIndicatorView *  activityIndicator = (UIActivityIndicatorView *)[loadView viewWithTag:666];
            [activityIndicator setHidden:YES];
            [activityIndicator stopAnimating];
    
    [UIView animateWithDuration:0.3 animations:^{

        
        loadView.alpha = 0;
        loadView = nil;
    
        
    }];
    
}


@end
