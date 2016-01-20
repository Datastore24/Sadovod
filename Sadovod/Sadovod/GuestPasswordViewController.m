//
//  GuestPasswordViewController.m
//  Sadovod
//
//  Created by Viktor on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "GuestPasswordViewController.h"
#import "ParserGuestPassword.h"
#import "ParserGuestPasswordResponse.h"
#import "APIGetClass.h"
#import "SingleTone.h"

@implementation GuestPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPassowrd:^{
        ParserGuestPassword * parserGuestPassword = [self.arrayResponce objectAtIndex:0];
        //Главный лейбл---------------------------
        UILabel * mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 240, 120)];
        if([parserGuestPassword.status isEqualToString:@"1"]){
            mailLabel.text = parserGuestPassword.password;
        }else{
            mailLabel.text = @"ОШИБКА(CODE: GP01]";
        }
        
        mailLabel.textColor = [UIColor blackColor];
        mailLabel.textAlignment = NSTextAlignmentCenter;
        mailLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:60];
        [mailLabel setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
        
        //mailLabel.backgroundColor = [UIColor blackColor];
        [self.view addSubview:mailLabel];
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(aMethod)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 50, 160.0, 40.0);
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) aMethod
{
    
    NSLog(@"Hello");
    [self.navigationController popViewControllerAnimated:YES];
}

////Авторизация пользователей
-(void) getPassowrd:(void (^)(void))block{
    
    
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/guest_password" complitionBlock:^(id response) {
        
        ParserGuestPasswordResponse * parsingGuestPassword =[[ParserGuestPasswordResponse alloc] init];
        
        
        //парсинг данных и запись в массив
        self.arrayResponce = [parsingGuestPassword parsing:response];
        
        block();
    }];
    
    
}
//

@end
