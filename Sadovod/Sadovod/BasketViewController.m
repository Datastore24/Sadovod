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
#import "Animation.h"
#import "MyShowcaseViewController.h"


@implementation BasketViewController
{
    UIScrollView * mainScrollView;
    NSArray * productArrayCartList;
    NSMutableArray * testArray;
}


-(void)viewWillAppear:(BOOL)animated{
    
    if (self.navigationItem.leftBarButtonItem) {
        
        
    } else {
    
    UIButton *favBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    favBackButton.frame = CGRectMake(0, 0, 35, 35);
    
    [favBackButton setImage:[UIImage imageNamed:@"backImage.png"] forState:UIControlStateNormal];
    [favBackButton addTarget:self action:@selector(aMethod:)
            forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithCustomView:favBackButton];
    
    self.navigationItem.leftBarButtonItem = backButton;
        
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) aMethod:(id)sender
{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.type = kCATransitionMoveIn;
    animation.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    MyShowcaseViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MyShowcase"];
    [self.navigationController pushViewController:detail animated:NO];
    self.view.alpha = 0;
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Корзина"];
    self.navigationItem.titleView = title;
    
    testArray = [[NSMutableArray alloc] init];

    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    

    
    
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    self.arrayCart = [NSMutableArray array];
    [self getApiFullCart:^{
        
        if(self.arrayCart && self.arrayCart>0){
            
            ParserFullCart * parserFullCart = [self.arrayCart objectAtIndex:0];
            productArrayCartList = parserFullCart.list;
    
    for (int i = 0; i < productArrayCartList.count; i++) {
        
        NSDictionary * productDictCart = [productArrayCartList objectAtIndex:i];
        
        //Основное вью---------------------------------------
        UIView * mainView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.width / 2) * i, self.view.frame.size.width, self.view.frame.size.width / 2)];
        NSLog(@"%f", (self.view.frame.size.width / 2) * i);
//        mainView.backgroundColor = [UIColor lightGrayColor];
        mainView.tag = 700 + i;
        
        [testArray addObject:mainView];
        [mainScrollView addSubview:mainView];
        
        
        //Изобрадение предмета--------------------------------
        ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4 + 20, (self.view.frame.size.width / 2)) andImageURL:[productDictCart objectForKey:@"img"] isInternetURL:YES andResized:YES];
        
        [mainView addSubview:image];
        
        
        //Размер предмета-------------------------------------
        UILabel * sizeObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 10, 250, 20)];
        sizeObjectLabel.text = [productDictCart objectForKey:@"name"];
        sizeObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainView addSubview:sizeObjectLabel];
        
        //Колличество заказанного товара----------------------
        UILabel * numberObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 30, 150, 20)];
        numberObjectLabel.text = [NSString stringWithFormat:@"%@ руб", [productDictCart objectForKey:@"cost"]];
        numberObjectLabel.textColor = [UIColor colorWithHexString:@"3038a0"];
        numberObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [mainView addSubview:numberObjectLabel];
        
        
        if(self.view.bounds.size.height < 586.0f) //Если пишем под 5ку и ниже
        {
            
        //Лейбл колличество-----------------------------------
        UILabel * labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 10, 80, 20)];
        labelNumber.text = @"Кол-во:";
        labelNumber.textColor = [UIColor colorWithHexString:@"acacac"];
        labelNumber.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [mainView addSubview:labelNumber];
         
        //Вью колличества-------------------------------------
        UILabel * labelNumberAction = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 30, 30, 30)];
        labelNumberAction.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        labelNumberAction.text = [productDictCart objectForKey:@"count"];
        labelNumberAction.textColor = [UIColor colorWithHexString:@"b4b4b4"];
        labelNumberAction.textColor = [UIColor colorWithHexString:@"acacac"];
        labelNumberAction.textAlignment = NSTextAlignmentCenter;
        labelNumberAction.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainView addSubview:labelNumberAction];
        
        //Кнопка удалить-------------------------------------
        UIButton * buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonDelete.frame = CGRectMake(self.view.frame.size.width - 65, 30, 30, 30);
        buttonDelete.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        buttonDelete.tag = i;
        [buttonDelete addTarget:self action:@selector(buttonDeleteAction:)
                           forControlEvents:UIControlEventTouchUpInside];
        
        [mainView addSubview:buttonDelete];
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 7, 12, 17)];
//        imageView.backgroundColor = [UIColor blueColor];
        imageView.image = [UIImage imageNamed:@"ic_delete"];
        [buttonDelete addSubview:imageView];
        } else {
            
            //Лейбл колличество-----------------------------------
            UILabel * labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 130, 5, 120, 30)];
            labelNumber.text = @"Кол-во:";
            labelNumber.textColor = [UIColor colorWithHexString:@"acacac"];
            labelNumber.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            [mainView addSubview:labelNumber];
            
            
            //Вью колличества-------------------------------------
            UILabel * labelNumberAction = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 130, 30, 50, 50)];
            labelNumberAction.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            labelNumberAction.text = [productDictCart objectForKey:@"count"];
            labelNumberAction.textColor = [UIColor colorWithHexString:@"b4b4b4"];
            labelNumberAction.textColor = [UIColor colorWithHexString:@"acacac"];
            labelNumberAction.textAlignment = NSTextAlignmentCenter;
            labelNumberAction.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
            [mainView addSubview:labelNumberAction];
            
            //Кнопка удалить-------------------------------------
            UIButton * buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
            buttonDelete.frame = CGRectMake(self.view.frame.size.width - 75, 30, 50, 50);
            buttonDelete.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
            buttonDelete.tag = i;
            [buttonDelete addTarget:self action:@selector(buttonDeleteAction:)
                   forControlEvents:UIControlEventTouchUpInside];
            
            [mainView addSubview:buttonDelete];
            
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 15, 15, 20)];
            //        imageView.backgroundColor = [UIColor blueColor];
            imageView.image = [UIImage imageNamed:@"ic_delete"];
            [buttonDelete addSubview:imageView];
        }
    }
         mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, ((self.view.frame.size.width / 2)* productArrayCartList.count)+ 70);
        }
 
    }];
    

    
    [CartUpdaterClass updateCartWithApi:self.view];
    if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 2 && [[SingleTone sharedManager] orderCart])
    {
        
        NSDictionary * cartOrder = [[SingleTone sharedManager] orderCart];
        
        DecorView * decor = [[DecorView alloc] initWithView:self.view andNumber:[cartOrder objectForKey:@"count"] andPrice:[cartOrder objectForKey:@"cost"] andWithBlock:NO];
        if([[[[SingleTone sharedManager] orderCart] objectForKey:@"cost"]integerValue]>0){
            decor.alpha = 0.7;
        }else{
            decor.alpha = 0;
        }
        [self.view addSubview:decor];
        
        UIButton * buttonDecor = (UIButton *)[self.view viewWithTag:555];
        [buttonDecor addTarget:self action:@selector(buttonDecorAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void) buttonDeleteAction: (UIButton*) button
{
    for (int i = 0; i < productArrayCartList.count; i++) {
        
        NSDictionary * productDictCart = [productArrayCartList objectAtIndex:i];
        
        
        
        if (button.tag == i) {
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.customViewColor = [UIColor colorWithHexString:@"3038a0"];
            
            //Достаем нужную кнопку---------------------------------------------
            
            [alert addButton:@"ОК" actionBlock:^(void) {
                [self postApiDelItemToCart:[productDictCart objectForKey:@"id"]];
                [CartUpdaterClass updateCartWithApi:self.view];
                
                
                UIView * testView = (UIView*)[self.view viewWithTag:700 + i];
                [Animation animateTransformView:testView withScale:1.f move_X:-self.view.frame.size.width + 10 move_Y:0 alpha:1.f delay:0.5f];
                
                NSLog(@"Animation %ld", (long)testView.tag);
                
                
                
                
                for (int i = 0; i < productArrayCartList.count; i++) {
                    UIView * upsView = (UIView*)[self.view viewWithTag:700 + i];
                    if (upsView.tag > testView.tag) {
                        
                        NSLog(@"Animation up %ld", (long)upsView.tag);

                        [Animation animationTestView:upsView move_Y:- (self.view.frame.size.width / 2)];
                    }
                }


                [testArray insertObject:testView atIndex:i];
                
                
                
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
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/cart_info" complitionBlock:^(id response) {
        
        [activityIndicator setHidden:YES];
        [activityIndicator stopAnimating];
        
        ParserFullCartResponse * parsingResponce =[[ParserFullCartResponse alloc] init];
        
        [parsingResponce parsing:response andArray:self.arrayCart andBlock:^{
            
            
            NSLog(@"%@",response);
            block();
            
        }];
        
        
    }];
    
}

//Удаление одного товара
- (void)postApiDelItemToCart:(NSString *) productID
{
    //Передаваемые параметры
    
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            productID,@"product",
                            nil];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params
                        andAddParam:nil
                             method:@"abpro/buy_product_clear_all"
                    complitionBlock:^(id response) {
                        
                        [activityIndicator setHidden:YES];
                        [activityIndicator stopAnimating];
                        
                        NSDictionary* dict = (NSDictionary*)response;
                        if ([[dict objectForKey:@"status"] integerValue] == 1) {
                            
                            //[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCart" object:self];
                            
                            [CartUpdaterClass updateCartWithApi:self.view];
                            
                        }else {
                            
                        }
                    }];
}
//

@end
