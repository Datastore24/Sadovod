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
#import "UIColor+HexColor.h"

@implementation BasketViewController
{
    UIScrollView * mainScrollView;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Корзина"];
    self.navigationItem.titleView = title;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    

    
    
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    [self.view addSubview:mainScrollView];
    
    for (int i = 0; i < 7; i++) {
        //Изобрадение предмета--------------------------------
        ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width / 2 * i, self.view.frame.size.width / 4 + 20, (self.view.frame.size.width / 2)) andImageURL:@"1image.jpg" isInternetURL:NO andResized:NO];
        
        [mainScrollView addSubview:image];
        
        
        //Размер предмета-------------------------------------
        UILabel * sizeObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 10 + self.view.frame.size.width / 2 * i, 250, 20)];
        sizeObjectLabel.text = @"Предмет";
        sizeObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainScrollView addSubview:sizeObjectLabel];
        
        //Колличество заказанного товара----------------------
        UILabel * numberObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 30 + self.view.frame.size.width / 2 * i, 150, 20)];
        numberObjectLabel.text = [NSString stringWithFormat:@"%@ руб", @"400"];
        numberObjectLabel.textColor = [UIColor colorWithHexString:@"3038a0"];
        numberObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [mainScrollView addSubview:numberObjectLabel];
        
        //
    }
    
}

@end
