//
//  MyShowcaseViewController.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 19.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "MyShowcaseViewController.h"
#import "SWRevealViewController.h"
#import "ModelMyShowcase.h"
#import "LabelViewMyShowcase.h"
#import "SectionTableViewController.h"
#import "UIColor+HexColor.h"
#import "AlertClass.h"
#import "TitleClass.h"
#import "OrdersViewController.h"

#import "ParserCategory.h"
#import "ParserCategoryResponse.h"
#import "SingleTone.h"
#import "AuthDbClass.h"
#import "Auth.h"

#import "APIGetClass.h"
#import "ParserCategory.h"
#import "ParserCategoryResponse.h"


@interface MyShowcaseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewMyShowcase; // Таблица "Моя Витрина"

@property (strong, nonatomic) NSMutableArray * arrayCategory; //Массив с Категориями

@end

@implementation MyShowcaseViewController{
NSDictionary * tableDict; //Директория хранения данных
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Кнопка бара--------------------------------------------
    UIButton * buttonOrders =  [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonOrders setImage:[UIImage imageNamed:@"ic_orders.png"] forState:UIControlStateNormal];
    [buttonOrders addTarget:self action:@selector(buttonOrdersAction)forControlEvents:UIControlEventTouchUpInside];
    [buttonOrders setFrame:CGRectMake(0, 0, 30, 30)];

    UIBarButtonItem *barButtonOrders = [[UIBarButtonItem alloc] initWithCustomView:buttonOrders];
    self.navigationItem.rightBarButtonItem = barButtonOrders;
    
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Моя Витрина"];
    self.navigationItem.titleView = title;

    self.arrayCategory = [NSMutableArray array];
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
    
    [self getApiOrders];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayCategory.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * categoryInfo = [self.arrayCategory objectAtIndex:indexPath.row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [categoryInfo objectForKey:@"cat_name"];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"909090"];
    
    //Добаляет кастомный лейбл в ячейку-----------------------------
    LabelViewMyShowcase * viewLabel = [[LabelViewMyShowcase alloc]
                                       initWichValue:[NSString stringWithFormat:@"%ld", [[categoryInfo objectForKey:@"prod_cnt"] integerValue]]];
    if (self.view.bounds.size.height < 586.0f) {
        viewLabel.frame = CGRectMake(270, 10, 30, 30);
    } else {
        viewLabel.frame = CGRectMake(320, 10, 30, 30);
    }
    [cell addSubview:viewLabel];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    SectionTableViewController * detail = [self.storyboard
                                           instantiateViewControllerWithIdentifier:@"SectionTableViewController"];
         NSDictionary * categoryInfo = [self.arrayCategory objectAtIndex:indexPath.row];
    detail.catID=[categoryInfo objectForKey:@"cat_id"];
    detail.catName = [categoryInfo objectForKey:@"cat_name"];
    
    [self.navigationController pushViewController:detail animated:YES];
}



//Тащим Категории с сервера
-(void) getApiOrders{
    //Передаваемые параметры
   
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/cats_list" complitionBlock:^(id response) {
        
        ParserCategoryResponse * parsingResponce =[[ParserCategoryResponse alloc] init];
        
        [parsingResponce parsing:response andArray:self.arrayCategory andBlock:^{
            
            
            [self reloadTableViewWhenNewEvent];
            
            
        }];
        
        
    }];
    
}

//Обновление таблицы
- (void)reloadTableViewWhenNewEvent {
    
    
    [self.tableViewMyShowcase
     reloadSections:[NSIndexSet indexSetWithIndex:0]
     withRowAnimation:UITableViewRowAnimationFade];
    
    self.tableViewMyShowcase.scrollEnabled = YES;
    
    
    //После обновления
    
    
}

/*
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
 NSLog(@"EERRRR");
 LognViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"LognViewController"];
 [self.navigationController pushViewController:detail animated:YES];
 }else{
 
 
 [self getApiAuthCheck:authCoreData.login password:authCoreData.password key:authCoreData.key andBlock:^{
 ParserAuthKey * parse = [self.arrayCheck objectAtIndex:0];
 
 //Перенаправление пользоваетеля в слуачае если данные из базы и данные с сервера соответствуют
 
 if([parse.status isEqual: @"1"]){
 NSLog(@"Все хорошо");
 }else{
 [authDbClass deleteAuth];
 LognViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"LognViewController"];
 [self.navigationController pushViewController:detail animated:YES];
 }
 
 }];
 
 }
 }
 
 }
 
 
 
 }*/

- (void) buttonOrdersAction
{
    OrdersViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"OrdersViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
