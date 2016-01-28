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
#import "TitleClass.h"
#import "UIColor+HexColor.h"

@interface GuestPasswordViewController ()

@end

@implementation GuestPasswordViewController
{
    UIScrollView * mailScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 1) {
        
        TitleClass * title = [[TitleClass alloc]initWithTitle:@"Гостевой пароль"];
        self.navigationItem.titleView = title;
        
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
    } else {
        
        TitleClass * title = [[TitleClass alloc]initWithTitle:@"Поставщици"];
        self.navigationItem.titleView = title;
        
        mailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.view addSubview:mailScrollView];
        
        for (int i = 0; i < 7; i ++) {
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 30 * i + 10 * i, self.view.frame.size.width - 20, 30)];
            label.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
            label.text = [NSString stringWithFormat: @"Самый крутой поствщик № %d", i];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            label.textAlignment = NSTextAlignmentCenter;
            
            [mailScrollView addSubview:label];
        }
        
        mailScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 30 * 7 + 10);
        

        
    }
    

    
}

-(void)viewWillAppear:(BOOL)animated{
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style: UIBarButtonItemStylePlain target:self action:@selector(aMethod:)];
//    self.navigationItem.leftBarButtonItem = backButton;
    
    UIButton *favBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favBackButton.frame = CGRectMake(0, 0, 35, 35);
    
    [favBackButton setImage:[UIImage imageNamed:@"backImage.png"] forState:UIControlStateNormal];
    [favBackButton addTarget:self action:@selector(aMethod:)
            forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithCustomView:favBackButton];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) aMethod:(id)sender
{
    
    //Переход в меню
    GuestPasswordViewController * mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MyShowcase"];
    [self.navigationController pushViewController:mainView animated:YES];
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

@end
