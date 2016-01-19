//
//  ViewController.m
//  Sadovod
//
//  Created by Viktor on 16.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+HexColor.h"


@interface ViewController ()


@end

@implementation ViewController
{
    NSDictionary * tableDict; //Директория хранения данных
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Моя Витрина";
//     [self CheckAuth];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"3038a0"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
