//
//  BasketViewController.m
//  Sadovod
//
//  Created by Viktor on 28.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "BasketViewController.h"
#import "TitleClass.h"
#import "ViewSectionTable.h"
#import "IssueViewController.h"

@implementation BasketViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Корзина"];
    self.navigationItem.titleView = title;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    
//    //Изобрадение предмета--------------------------------
//    ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(-2.5, - 2.5, self.view.frame.size.width / 4 + 20, (self.view.frame.size.width / 2)) andImageURL:@"1image.jpg" isInternetURL:NO andLabelPrice:nil andResized:NO];
//    [self.view addSubview:image];
    
    
    
    UIScrollView * mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    mainScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainScrollView];
    
    //Вью Оформить-----------------------------------------------------------
    
    UIView * basketView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 100)];
    basketView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:basketView];
    
    //Кнопка оформить
    UIButton * issueButton = [UIButton buttonWithType:UIButtonTypeSystem];
    issueButton.frame = CGRectMake(270, 5, 90, 25);
    issueButton.backgroundColor = [UIColor blackColor];
    [issueButton setTitle:@"Оформить" forState:UIControlStateNormal];
    [issueButton addTarget:self action:@selector(issueButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [basketView addSubview:issueButton];
    
    
}

- (void) issueButtonAction
{
    IssueViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"IssueViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
