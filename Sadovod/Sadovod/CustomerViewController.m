//
//  CustomerViewController.m
//  Sadovod
//
//  Created by Viktor on 23.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "CustomerViewController.h"
#import "TitleClass.h"
#import "ViewCustomer.h"

@implementation CustomerViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    //Раздел заголовка---------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Заказ № 137"];
    self.navigationItem.titleView = title;
    
    //Инициализация графического интерфейса------------------------------
    ViewCustomer * viewCustomer = [[ViewCustomer alloc] initWithPhone:@"+7 988 503 52 28"
                                                              andName:nil
                                                           andAddress:@"Hello how are you ?? "
                                                           andComment:@"Ogogogogogog ogogogogogogo Ogogogogogog ogogogogogogoOgogogogogog ogogogogogogoOgogogogogog ogogogogogogoOgogogogogog ogogogogogogoOgogogogogog"
                                                               andSum:nil
                                                          andMainView:self.view];
    [self.view addSubview:viewCustomer];
    
}

@end
