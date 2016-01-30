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
#import "SingleTone.h"
#import "DecorView.h"
#import "IssueViewController.h"
#import "CartUpdaterClass.h"

#import "APIGetClass.h"
#import "APIPostClass.h"
#import "SingleTone.h"
#import "ParserFullCart.h"
#import "ParserFullCartResponse.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>

@implementation BasketViewController
{
    UIScrollView * mainScrollView;
}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 2 && [[[[SingleTone sharedManager] orderCart] objectForKey:@"cost"] integerValue] >0)
    {
     [CartUpdaterClass updateCartWithApi:self.view];
    }
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Корзина"];
    self.navigationItem.titleView = title;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    

    
    
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    self.arrayCart = [NSMutableArray array];
    [self getApiFullCart:^{
        
        if(self.arrayCart && self.arrayCart>0){
            
            ParserFullCart * parserFullCart = [self.arrayCart objectAtIndex:0];
            NSArray * productArrayCartList = parserFullCart.list;
    
    for (int i = 0; i < productArrayCartList.count; i++) {
        
        NSDictionary * productDictCart = [productArrayCartList objectAtIndex:i];
        //Изобрадение предмета--------------------------------
        ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width / 2 * i, self.view.frame.size.width / 4 + 20, (self.view.frame.size.width / 2)) andImageURL:[productDictCart objectForKey:@"img"] isInternetURL:YES andResized:YES];
        
        [mainScrollView addSubview:image];
        
        
        //Размер предмета-------------------------------------
        UILabel * sizeObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 10 + self.view.frame.size.width / 2 * i, 250, 20)];
        sizeObjectLabel.text = [productDictCart objectForKey:@"name"];
        sizeObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainScrollView addSubview:sizeObjectLabel];
        
        //Колличество заказанного товара----------------------
        UILabel * numberObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 30 + self.view.frame.size.width / 2 * i, 150, 20)];
        numberObjectLabel.text = [NSString stringWithFormat:@"%@ руб", [productDictCart objectForKey:@"cost"]];
        numberObjectLabel.textColor = [UIColor colorWithHexString:@"3038a0"];
        numberObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [mainScrollView addSubview:numberObjectLabel];
        
        //Лейбл колличество-----------------------------------
        UILabel * labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 10 + self.view.frame.size.width / 2 * i, 80, 20)];
        labelNumber.text = @"Кол-во:";
        labelNumber.textColor = [UIColor colorWithHexString:@"acacac"];
        labelNumber.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [mainScrollView addSubview:labelNumber];
        
        //Вью колличества-------------------------------------
        UILabel * labelNumberAction = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 30 + self.view.frame.size.width / 2 * i, 30, 30)];
        labelNumberAction.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        labelNumberAction.text = [productDictCart objectForKey:@"count"];
        labelNumberAction.textColor = [UIColor colorWithHexString:@"b4b4b4"];
        labelNumberAction.textColor = [UIColor colorWithHexString:@"acacac"];
        labelNumberAction.textAlignment = NSTextAlignmentCenter;
        labelNumberAction.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainScrollView addSubview:labelNumberAction];
        
        //Кнопка удалить-------------------------------------
        UIButton * buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonDelete.frame = CGRectMake(self.view.frame.size.width - 65, 30 + self.view.frame.size.width / 2 * i, 30, 30);
        buttonDelete.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        buttonDelete.tag = i;
        [buttonDelete addTarget:self action:@selector(buttonDeleteAction:)
                           forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonDelete];
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 7, 12, 17)];
//        imageView.backgroundColor = [UIColor blueColor];
        imageView.image = [UIImage imageNamed:@"ic_delete"];
        [buttonDelete addSubview:imageView];
    }
         mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, ((self.view.frame.size.width / 2)* productArrayCartList.count)+ 70);
        }
 
    }];
    

    
    [CartUpdaterClass updateCartWithApi:self.view];
    if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 2 && [[SingleTone sharedManager] orderCart])
    {
        
        NSDictionary * cartOrder = [[SingleTone sharedManager] orderCart];
        
        DecorView * decor = [[DecorView alloc] initWithView:self.view andNumber:[cartOrder objectForKey:@"count"] andPrice:[cartOrder objectForKey:@"cost"] andWithBlock:NO];
        [self.view addSubview:decor];
        
        UIButton * buttonDecor = (UIButton *)[self.view viewWithTag:555];
        [buttonDecor addTarget:self action:@selector(buttonDecorAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void) buttonDeleteAction: (UIButton*) button
{
    for (int i = 0; i < 7; i ++) {
        if (button.tag == i) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.customViewColor = [UIColor colorWithHexString:@"3038a0"];
            //Using Selector
            //Using Block
            [alert addButton:@"ОК" actionBlock:^(void) {
                NSLog(@"Second button tapped");
            }];
            
            [alert showSuccess:self title:@"Удаление" subTitle:@"Вы действительно хотите удалить данный товар ??" closeButtonTitle:@"Отмена" duration:0.0f];
            

        }
    }


}

- (void) buttonDecorAction
{
    IssueViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"IssueViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Тащим заказы
-(void) getApiFullCart: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/cart_info" complitionBlock:^(id response) {
        
        ParserFullCartResponse * parsingResponce =[[ParserFullCartResponse alloc] init];
        
        [parsingResponce parsing:response andArray:self.arrayCart andBlock:^{
            
            
            NSLog(@"%@",response);
            block();
            
        }];
        
        
    }];
    
}

@end
