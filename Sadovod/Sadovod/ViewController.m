//
//  ViewController.m
//  Sadovod
//
//  Created by Viktor on 16.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "ModelMyShowcase.h"
#import "LabelViewMyShowcase.h"
#import "SectionTableViewController.h"
#import "UIColor+HexColor.h"
#import "AlertClass.h"

#import <MagicalRecord/MagicalRecord.h>

#import "AuthDbClass.h"
#import "APIGetClass.h"
#import "ParserAuthKey.h"
#import "ParserAuthResponse.h"
#import "Auth.h"
#import "SingleTone.h"
#import "LognViewController.h"



@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewMyShowcase; // Таблица "Моя Витрина"

@property (strong, nonatomic) NSMutableArray * arrayResponce; //Массив с данными API
@property (strong, nonatomic) NSMutableArray * arrayCheck; //Массив с данными API

@end

@implementation ViewController
{
    NSDictionary * tableDict; //Директория хранения данных
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Моя Витрина";
     [self CheckAuth];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    tableDict = [ModelMyShowcase dictTableData]; //передача данных    
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3038a0"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    //Реализация кнопки бокового меню---------------------------
    
    UIImage *imageBarButton = [UIImage imageNamed:@"menu.png"];
    [_barButton setImage:imageBarButton];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, imageBarButton.size.width, imageBarButton.size.height );
    [button setImage:imageBarButton forState:UIControlStateNormal];
    [button addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    _barButton.customView=button;

//    _barButton.target = self.revealViewController;
//    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Параметры моей таблицы------------------------------------
    self.tableViewMyShowcase.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableDict[@"title"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = tableDict[@"title"][indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"909090"];
    
    //Добаляет кастомный лейбл в ячейку-----------------------------
    LabelViewMyShowcase * viewLabel = [[LabelViewMyShowcase alloc]
                          initWichValue:[NSString stringWithFormat:@"%ld", [tableDict[@"value"][indexPath.row] integerValue]]];
    [cell addSubview:viewLabel];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SectionTableViewController * detail = [self.storyboard
                                           instantiateViewControllerWithIdentifier:@"SectionTableViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

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
   

    if (!arrayUser || !arrayUser.count){
        LognViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"LognViewController"];
        [self.navigationController pushViewController:detail animated:YES];
        
    }else{
        if(arrayUser.count>1){
           
            [authDbClass deleteAuth];

        }
        for (int i; i<arrayUser.count; i++) {
            Auth * authCoreData = [arrayUser objectAtIndex:i];
            
            //Проверка существования пользователя
            
            if(authCoreData.login == nil || authCoreData.password == nil || authCoreData.key == nil){
                LognViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"LognViewController"];
                [self.navigationController pushViewController:detail animated:YES];
            }else{
                
            
            [self getApiAuthCheck:authCoreData.login password:authCoreData.password key:authCoreData.key andBlock:^{
                ParserAuthKey * parse = [self.arrayCheck objectAtIndex:0];
                
                //Перенаправление пользоваетеля в слуачае если данные из базы и данные с сервера соответствуют
                
                if([parse.status isEqual: @"1"]){
                    NSLog(@"Все хорошо");
                }else{
                    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Auth.sqlite"];
                    [Auth MR_truncateAll];
                    LognViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"LognViewController"];
                    [self.navigationController pushViewController:detail animated:YES];
                }
                
            }];
                
            }
    }
        
    
   
        
     
        
        
        
        
        
    }
    
    
    
}

@end
