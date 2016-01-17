//
//  ViewControllerProductDetails.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewControllerProductDetails.h"

@implementation ViewControllerProductDetails
{
    UIScrollView * mainScrollView; //Основной скрол вью
}

- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"Джампер";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Инициализация scrollView-----------
    mainScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mainScrollView];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 200);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
