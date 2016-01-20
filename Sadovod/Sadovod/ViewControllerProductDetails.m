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
    UIButton * areAvailable; //Кнопка есть в наличии
    UIButton *notAvailable; //Кнопка нет в наличии
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
    
    //Инициализация вью изменения цены---------------------------------------------------
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

    [priceView addSubview:buttonChangePrice];
    
    //Вью границы-------------------------------------------------------------------------
    UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0, priceView.frame.origin.y + 40, self.view.frame.size.width, 42)];
    borderView.backgroundColor = nil;
    borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    borderView.layer.borderWidth = 2;
    [mainScrollView addSubview:borderView];
    
    //Инициализация вью есть в наличии---------------------------------------------------
    areAvailable = [UIButton buttonWithType:UIButtonTypeCustom];
    [areAvailable addTarget:self
                          action:@selector(areAvailableAction)
                forControlEvents:UIControlEventTouchUpInside];
    [areAvailable setTitle:@"Есть в наличии" forState:UIControlStateNormal];
    [areAvailable.titleLabel setFont:[UIFont systemFontOfSize:16]];
    areAvailable.frame = CGRectMake(0, priceView.frame.origin.y + 40, self.view.frame.size.width / 2, 40.0);
    areAvailable.backgroundColor = [UIColor colorWithHexString:@"a0a7db"];
    [mainScrollView addSubview:areAvailable];
    
    //Инициализация нет в наличии--------------------------------------------------------
    notAvailable = [UIButton buttonWithType:UIButtonTypeCustom];
    [notAvailable addTarget:self
                     action:@selector(notAvailableAction)
           forControlEvents:UIControlEventTouchUpInside];
    [notAvailable setTitle:@"Нет в наличии" forState:UIControlStateNormal];
    [notAvailable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [notAvailable.titleLabel setFont:[UIFont systemFontOfSize:16]];
    notAvailable.frame = CGRectMake(self.view.frame.size.width / 2, priceView.frame.origin.y + 40, self.view.frame.size.width / 2, 40.0);
    notAvailable.backgroundColor = [UIColor whiteColor];
//    notAvailable.layer.borderColor = [UIColor blackColor].CGColor;
//    notAvailable.layer.borderWidth = 2;
    [mainScrollView addSubview:notAvailable];
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) buttonChangePriceAction
{
    NSLog(@"Изменить цену");
}

- (void) areAvailableAction
{
    [UIView animateWithDuration:0.3 animations:^{
        notAvailable.backgroundColor = [UIColor whiteColor];
        [notAvailable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        areAvailable.backgroundColor = [UIColor colorWithHexString:@"a0a7db"];
        [areAvailable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];
}

- (void) notAvailableAction
{
    
    [UIView animateWithDuration:0.3 animations:^{
        areAvailable.backgroundColor = [UIColor whiteColor];
        [areAvailable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        notAvailable.backgroundColor = [UIColor colorWithHexString:@"a0a7db"];
        [notAvailable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];

}

@end
