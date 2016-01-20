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
#import "UIColor+HexColor.h"

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
    mainScrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:mainScrollView];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 200);
    
    ViewProductDetails * scrollViewImge = [[ViewProductDetails alloc] initWithFrame:CGRectMake(0, 0,
                                            self.view.frame.size.width,
                                            self.view.frame.size.height / 3) andArray:array];
    [mainScrollView addSubview:scrollViewImge];
    
    //Инициализация вью изменения цены-------------------------
    UIView * priceView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollViewImge.frame.size.height + 20,
                                                                     self.view.frame.size.width, 40)];
    priceView.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
    [mainScrollView addSubview:priceView];
    //Лейбл цены------------------------------------------------
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 30)];
    priceLabel.text = @"400 руб";
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [priceView addSubview:priceLabel];
    //Кнопка изменения цены-------------------------------------
    UIButton *buttonChangePrice = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonChangePrice addTarget:self
               action:@selector(buttonChangePriceAction)
     forControlEvents:UIControlEventTouchUpInside];
    [buttonChangePrice setTitle:@"Изменить цену" forState:UIControlStateNormal];
    [buttonChangePrice.titleLabel setFont:[UIFont systemFontOfSize:12]];
    buttonChangePrice.frame = CGRectMake(self.view.frame.size.width - 100, 0, 100, 40.0);
//    buttonChangePrice.backgroundColor = [UIColor whiteColor];
    [priceView addSubview:buttonChangePrice];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) buttonChangePriceAction
{
    NSLog(@"Изменить цену");
}

@end
