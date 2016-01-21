//
//  OrdersViewController.m
//  Sadovod
//
//  Created by Viktor on 21.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "OrdersViewController.h"
#import "TitleClass.h"

@implementation OrdersViewController
{
    UIScrollView * mainCrollView;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    //Раздел заголовка---------------------------------------------------
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Заказы"];
    self.navigationItem.titleView = title;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    
    //Раздел основного вью-----------------------------------------------
    mainCrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainCrollView.showsVerticalScrollIndicator = NO;
    
    //Раздел таблицы из вью----------------------------------------------
    for (int i; i < 7; i ++) {
        UIView * viewData = [UIView alloc] initWithFrame:CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    
}

@end
