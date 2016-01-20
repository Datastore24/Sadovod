//
//  ViewControllerProductDetails.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewControllerProductDetails.h"
#import "TitleClass.h"
#import "ViewProductDetails.h"

@implementation ViewControllerProductDetails
{
    UIScrollView * mainScrollView; //Основной скрол вью
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Джампер"];
    self.navigationItem.titleView = title;
    
    NSArray * array = [NSArray arrayWithObjects:@"1image.jpg", @"2image.jpg", @"3image.jpg",
                                                @"5image.jpg", @"6image.jpg", nil];
    
    //Инициализация scrollView-----------
    mainScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mainScrollView];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 200);
    
    ViewProductDetails * scrollViewImge = [[ViewProductDetails alloc] initWithFrame:CGRectMake(0, 0,
                                            self.view.frame.size.width,
                                            self.view.frame.size.height / 3) andArray:array];
    [mainScrollView addSubview:scrollViewImge];
}
                                           


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
