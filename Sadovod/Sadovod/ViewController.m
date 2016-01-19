//
//  ViewController.m
//  Sadovod
//
//  Created by Viktor on 16.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewController.h"



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
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
