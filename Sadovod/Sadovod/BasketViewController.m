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

@implementation BasketViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Корзина"];
    self.navigationItem.titleView = title;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    
    //Изобрадение предмета--------------------------------
    ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(-2.5, - 2.5, self.view.frame.size.width / 4 + 20, (self.view.frame.size.width / 2)) andImageURL:@"1image.jpg" isInternetURL:NO andLabelPrice:nil andResized:NO];
    [self.view addSubview:image];
}

@end
