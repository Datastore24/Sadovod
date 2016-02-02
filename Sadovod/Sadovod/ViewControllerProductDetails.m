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
#import "EditSizeViewController.h"
#import "AlertClass.h"
#import "DecorView.h"
#import "IssueViewController.h"
#import "Animation.h"

#import "APIPostClass.h"
#import "APIGetClass.h"
#import "ParserProduct.h"
#import "ParserProductResponse.h"
#import "ParserBuyProductInfo.h"
#import "ParserBuyProductInfoResponse.h"
#import "SingleTone.h"
#import "TextViewHeight.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>

#import "CartUpdaterClass.h"
#import "LabelProductDetail.h"

@interface ViewControllerProductDetails ()
@property (strong, nonatomic) NSMutableArray * arrayProduct; //Массив с Товарами
@property (strong, nonatomic) NSMutableArray * arrayBuyProductInfo; //Массив с Товарами
@property (strong, nonatomic) ViewProductDetails * viewProductDetails; //Экземпляр класса
@property (strong, nonatomic) UIButton * buttonCloseView;
@property (strong, nonatomic) UILabel * priceLabel;
@property (strong, nonatomic) NSMutableArray * tempArraySizes;

@property (strong,nonatomic) UIScrollView * addToCartView; //Всплывашка


@end

@implementation ViewControllerProductDetails
{
    UIScrollView * mainScrollView; //Основной скрол вью
    UIButton * areAvailable; //Кнопка есть в наличии
    UIButton *notAvailable; //Кнопка нет в наличии
    UITableView * tableDetails; //Таблица деталей
    
    NSArray * productSizes;
    UILabel * titleSize;
    
    NSArray * productBuySizes;
    BOOL isBool;
    UIView * viewMove;
    DecorView * decor;
    
    UIView * viewDetails;
    NSMutableArray * testMArray;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];

    TitleClass * title = [[TitleClass alloc]initWithTitle:self.productName];
    self.navigationItem.titleView = title;
    
    isBool = NO;
    testMArray = [[NSMutableArray alloc] init];
    
    //NOTIFICATION
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadView) name:@"ReloadView" object:nil];
    
    //
    
     self.arrayProduct = [NSMutableArray array];
    
    
    [self getApiProduct:^{
        
        
        
      NSDictionary * productInfo=[self.arrayProduct objectAtIndex:0];
        
        
        if([productInfo objectForKey:@"id"] != [NSNull null]){
            
        
        
    NSArray * array = [productInfo objectForKey:@"images"];
    
    //Инициализация scrollView-----------
    mainScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:mainScrollView];
    mainScrollView.showsVerticalScrollIndicator = NO;
    
    ViewProductDetails * scrollViewImge = [[ViewProductDetails alloc] initWithFrame:CGRectMake(0, 0,
                                            self.view.frame.size.width,
                                            self.view.frame.size.height / 3)
                                            andArray:array
                                            andFullScreen:NO];
        
       //Распознование нажатия на скролл
        UITapGestureRecognizer *tapRecognizer;
        tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(largeImage)];
        
        [scrollViewImge addGestureRecognizer:tapRecognizer];
        scrollViewImge.userInteractionEnabled = YES;
        //
        
    [mainScrollView addSubview:scrollViewImge];
    
    //Инициализация вью изменения цены---------------------------------------------------
    UIView * priceView = [[UIView alloc] initWithFrame:CGRectMake(0, scrollViewImge.frame.size.height + 20,
                                                                     self.view.frame.size.width, 40)];
    priceView.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
    [mainScrollView addSubview:priceView];
    //Лейбл цены------------------------------------------------
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 30)];
    self.priceLabel.text = [NSString stringWithFormat:@"%@ руб.",[productInfo objectForKey:@"cost"]];
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [priceView addSubview:self.priceLabel];
    //Кнопка изменения цены-------------------------------------
    //Кнопка доступна если пользователь владелец----------------
    if ([[[SingleTone sharedManager] typeOfUsers] integerValue] ==1)
    {
    UIButton *buttonChangePrice = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonChangePrice addTarget:self
               action:@selector(buttonChangePriceAction)
     forControlEvents:UIControlEventTouchUpInside];
    [buttonChangePrice setTitle:@"Изменить цену" forState:UIControlStateNormal];
    [buttonChangePrice.titleLabel setFont:[UIFont systemFontOfSize:12]];
    buttonChangePrice.frame = CGRectMake(self.view.frame.size.width - 100, 0, 100, 40.0);
    [priceView addSubview:buttonChangePrice];
    } else {
        UIButton * buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buyButton addTarget:self
                              action:@selector(buyButtonAction)
                    forControlEvents:UIControlEventTouchUpInside];
        [buyButton setTitle:@"Купить" forState:UIControlStateNormal];
        [buyButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        buyButton.frame = CGRectMake(self.view.frame.size.width - 100, 0, 100, 40.0);
        [priceView addSubview:buyButton];
        
    }
    
    //Вью границы-------------------------------------------------------------------------
    UIView * borderView = [[UIView alloc] initWithFrame:CGRectMake(0, priceView.frame.origin.y + 40, self.view.frame.size.width, 42)];
    borderView.backgroundColor = nil;
    borderView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    borderView.layer.borderWidth = 2;
    [mainScrollView addSubview:borderView];
        
        //Цвета в зависимости от статуса
        NSInteger status= [[productInfo objectForKey:@"status"] integerValue];
        NSString * colorAvailableStatus;
        NSString * colorNotAvailableStatus;
        UIColor * textColorAvailableStatus;
        UIColor * textColorNotAvailableStatus;
        if(status == 1){
            colorAvailableStatus = @"a0a7db";
            colorNotAvailableStatus = @"ffffff";
            textColorAvailableStatus = [UIColor whiteColor];
            textColorNotAvailableStatus = [UIColor blackColor];
        }else{
            colorAvailableStatus = @"ffffff";
            colorNotAvailableStatus = @"a0a7db";
            textColorAvailableStatus = [UIColor blackColor];
            textColorNotAvailableStatus = [UIColor whiteColor];
        }
        //
            
    if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 1) {
    //Инициализация вью есть в наличии---------------------------------------------------
    areAvailable = [UIButton buttonWithType:UIButtonTypeCustom];
    [areAvailable addTarget:self
                          action:@selector(areAvailableAction)
                forControlEvents:UIControlEventTouchUpInside];
    [areAvailable setTitle:@"Есть в наличии" forState:UIControlStateNormal];
    [areAvailable setTitleColor:textColorAvailableStatus forState:UIControlStateNormal];
    [areAvailable.titleLabel setFont:[UIFont systemFontOfSize:16]];
    areAvailable.frame = CGRectMake(0, priceView.frame.origin.y + 40, self.view.frame.size.width / 2, 40.0);
    areAvailable.backgroundColor = [UIColor colorWithHexString:colorAvailableStatus];
    [mainScrollView addSubview:areAvailable];
    
    //Инициализация нет в наличии--------------------------------------------------------
    notAvailable = [UIButton buttonWithType:UIButtonTypeCustom];
    [notAvailable addTarget:self
                     action:@selector(notAvailableAction)
           forControlEvents:UIControlEventTouchUpInside];
    [notAvailable setTitle:@"Нет в наличии" forState:UIControlStateNormal];
    [notAvailable setTitleColor:textColorNotAvailableStatus forState:UIControlStateNormal];
    [notAvailable.titleLabel setFont:[UIFont systemFontOfSize:16]];
    notAvailable.frame = CGRectMake(self.view.frame.size.width / 2, priceView.frame.origin.y + 40, self.view.frame.size.width / 2, 40.0);
    notAvailable.backgroundColor = [UIColor colorWithHexString:colorNotAvailableStatus];
    [mainScrollView addSubview:notAvailable];
        
    //Лейбл заголовка Доступные размеры---------------------------------------------------
    titleSize = [[UILabel alloc] initWithFrame:CGRectMake(10, priceView.frame.origin.y + 40 + 45, 150, 40)];
    titleSize.text = @"Доступные размеры";
    titleSize.textColor = [UIColor colorWithHexString:@"3038a0"];
    titleSize.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainScrollView addSubview:titleSize];
    } else {
            
    //Лейбл заголовка Доступные размеры---------------------------------------------------
    titleSize = [[UILabel alloc] initWithFrame:CGRectMake(10, priceView.frame.origin.y + 40, 150, 40)];
    titleSize.text = @"Доступные размеры";
    titleSize.textColor = [UIColor colorWithHexString:@"3038a0"];
    titleSize.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainScrollView addSubview:titleSize];
    
    }
    

    
    //Вью доступных размеров---------------------------------------------------------------
    UIView * mainViewSize = [[UIView alloc] init];
    mainViewSize.backgroundColor = [UIColor whiteColor];
    mainViewSize.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    mainViewSize.layer.borderWidth = 2.f;
    [mainScrollView addSubview:mainViewSize];
        
    //Кнопки размеров---------------------------------------------------------------------
        productSizes = [productInfo objectForKey:@"sizes"];
    
        
        int heightLine=0; //На каждую строку добавляется +45
        int countSizePerline=0; // Количество в строке от 0
        int countSizeLine=1; //Количество строк
        
        for (int i = 0; i < productSizes.count; i++) {
            
            NSDictionary * productSizesInfo = [productSizes objectAtIndex:i];
            UIButton *buttonSize = [UIButton buttonWithType:UIButtonTypeSystem];
            [buttonSize addTarget:self
                           action:@selector(buttonSizeAction:)
                 forControlEvents:UIControlEventTouchUpInside];
            if(i!=0 && countSizePerline==3){
               
                buttonSize.frame = CGRectMake (0, 55+heightLine, (self.view.frame.size.width / 3) - 2, 35);
                heightLine += 45;
                countSizePerline = 1;
                countSizeLine += 1;
                
            }else{
                if (i==0) {
                    buttonSize.frame = CGRectMake ((0 + (self.view.frame.size.width / 3) * countSizePerline), 10+heightLine, (self.view.frame.size.width / 3) - 2, 35);
                    countSizePerline += 1;
                    
                } else {
                    
                    buttonSize.frame = CGRectMake ((0.5 + (self.view.frame.size.width / 3) * countSizePerline), 10+heightLine, (self.view.frame.size.width / 3) - 2, 35);
                    countSizePerline += 1;
              
                }
            }
            
            buttonSize.tag = 300 + i;
            [buttonSize setTitle:[productSizesInfo objectForKey:@"value"] forState:UIControlStateNormal];
            [buttonSize setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            NSString * colorAviableSizes;
            if([[productSizesInfo objectForKey:@"aviable"] integerValue] == 0){
                colorAviableSizes = @"ffebee";
            }else{
                colorAviableSizes = @"e9eaf7";
            }
            
            buttonSize.backgroundColor = [UIColor colorWithHexString:colorAviableSizes];
            buttonSize.titleLabel.font = [UIFont systemFontOfSize:15];
            [mainViewSize addSubview:buttonSize];
            //Если клмент то кнопки размернов есть в наличии, нет в наличии не доступно----------------
            if ([[[SingleTone sharedManager] typeOfUsers] integerValue] ==2)
            {
                buttonSize.userInteractionEnabled = NO;
            }
        }
        
        //Исправление высоты при необходимости
        int addMainViewSizeHeight=0;
        
        if(countSizePerline==3){
            //Если клиент и копки добавить рамер в новой строке, то вью не увеличивается---------------
            if ([[[SingleTone sharedManager] typeOfUsers] integerValue] ==1)
            {
            heightLine+=45;//Увеличиваем отступ вниз
            countSizePerline=0;//Сбрасываем счетчик количество размеров в линию
            }
        }
        //
        mainViewSize.frame=CGRectMake(0, titleSize.frame.origin.y + 40, self.view.frame.size.width, 55+heightLine+addMainViewSizeHeight);

        //Если владелец то добавляем нопку добавить размер----------------------------------
            if ([[[SingleTone sharedManager] typeOfUsers] integerValue] ==1) {
                
                UIButton *buttonSizeAdd = [UIButton buttonWithType:UIButtonTypeSystem];
                [buttonSizeAdd addTarget:self
                                  action:@selector(buttonSizeAddAction)
                        forControlEvents:UIControlEventTouchUpInside];
                
                buttonSizeAdd.frame = CGRectMake ((0.5 + (self.view.frame.size.width / 3) * countSizePerline), 10+heightLine, (self.view.frame.size.width / 3) - 2, 35);
                [buttonSizeAdd setTitle:@"+" forState:UIControlStateNormal];
                [buttonSizeAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                buttonSizeAdd.backgroundColor = [UIColor colorWithHexString:@"e9eaf7"];
                buttonSizeAdd.titleLabel.font = [UIFont systemFontOfSize:15];
                
                [mainViewSize addSubview:buttonSizeAdd];
            }

        UILabel * titleDetails;
        if(![[productInfo objectForKey:@"mini_desc"] isEqualToString:@""]){
            
        
    //Лейбл заголовка Описание-------------------------------------------------------------
    UILabel * titleDescription = [[UILabel alloc] initWithFrame:CGRectMake(10, mainViewSize.frame.origin.y + mainViewSize.frame.size.height, 150, 40)];
    titleDescription.text = @"Описание";
    titleDescription.textColor = [UIColor colorWithHexString:@"3038a0"];
    titleDescription.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainScrollView addSubview:titleDescription];
    
    //Вью описания---------------------------------------------------------------------------
    TextViewHeight * viewDescription = [[TextViewHeight alloc] initWithFrame:CGRectMake(0, titleDescription.frame.origin.y + 42, self.view.frame.size.width, 40) andText:[productInfo objectForKey:@"mini_desc"]];
    viewDescription.backgroundColor = [UIColor whiteColor];
    viewDescription.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    viewDescription.layer.borderWidth = 2.f;
    [mainScrollView addSubview:viewDescription];
    
        titleDetails = [[UILabel alloc] initWithFrame:CGRectMake(10, viewDescription.frame.origin.y + viewDescription.frame.size.height, 150, 40)];
    }else{
        //Лейбл заголовка Описание-------------------------------------------------------------
        titleDetails = [[UILabel alloc] initWithFrame:CGRectMake(10,  mainViewSize.frame.origin.y + mainViewSize.frame.size.height, 150, 40)];
    }
    titleDetails.text = @"Детально";
    titleDetails.textColor = [UIColor colorWithHexString:@"3038a0"];
    titleDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainScrollView addSubview:titleDetails];
    
//    //Таблица деалей----------------------------------------------------------------------
//    CGRect frame = CGRectMake(0.f, titleDetails.frame.origin.y + 40, self.view.frame.size.width, 350);
//    tableDetails = [[UITableView alloc] initWithFrame:frame
//                                             style:UITableViewStyleGrouped];
//    tableDetails.delegate = self;
//    tableDetails.dataSource = self;
//    tableDetails.backgroundView = nil;
//    [mainScrollView addSubview:tableDetails];
    
    //Реализация таблицы деталей через цикл создваеммых вью-------------------------------------
        NSArray * productOptions = [[NSArray alloc] initWithArray:[productInfo objectForKey:@"opts"]];
        
    for (int i = 0; i < productOptions.count; i++) {
        NSDictionary * productOptionsInfo = [productOptions objectAtIndex:i];
        
        viewDetails = [[UIView alloc] initWithFrame:CGRectMake(0, (titleDetails.frame.origin.y + 40) + 40 * i, self.view.frame.size.width, 40)];
        viewDetails.backgroundColor = [UIColor whiteColor];
        viewDetails.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        viewDetails.layer.borderWidth = 0.5;
        [mainScrollView addSubview:viewDetails];
        
        //Создаем заголовки деталей-------------------------------------------------------------
        UILabel * labelDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
        labelDetail.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        labelDetail.layer.borderWidth = 1;
        labelDetail.textColor = [UIColor colorWithHexString:@"c6c6c6"];
        labelDetail.text = [NSString stringWithFormat:@"   %@",  [productOptionsInfo objectForKey:@"name"]];
        labelDetail.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [viewDetails addSubview:labelDetail];
        
        //Создаем заголовок данных--------------------------------------------------------------
        UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, self.view.frame.size.width - 120, 40)];
        labelData.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        labelData.layer.borderWidth = 1;
        labelData.text = [NSString stringWithFormat:@"      %@",  [productOptionsInfo objectForKey:@"value"]];
        labelData.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [viewDetails addSubview:labelData];
        
        
        if(i==productOptions.count-1){
            
            viewDetails = [[UIView alloc] initWithFrame:CGRectMake(0, (titleDetails.frame.origin.y + 40) + 40 * i, self.view.frame.size.width, 40)];
            viewDetails.backgroundColor = [UIColor whiteColor];
            viewDetails.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            viewDetails.layer.borderWidth = 0.5;
            [mainScrollView addSubview:viewDetails];
            
            //Создаем заголовки деталей-------------------------------------------------------------
            UILabel * labelDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
            labelDetail.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            labelDetail.layer.borderWidth = 1;
            labelDetail.textColor = [UIColor colorWithHexString:@"c6c6c6"];
            labelDetail.text = @"   ID";
            labelDetail.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            [viewDetails addSubview:labelDetail];
            
            //Создаем заголовок данных--------------------------------------------------------------
            UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, self.view.frame.size.width - 120, 40)];
            labelData.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
            labelData.layer.borderWidth = 1;
            labelData.text = [NSString stringWithFormat:@"      %@",  self.productID];
            labelData.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            [viewDetails addSubview:labelData];
            
        }
    }
            
             mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, viewDetails.frame.origin.y + viewDetails.frame.size.height);
            
        }else{
            [AlertClass showAlertViewWithMessage:@"Ошибка загрузки товара" view:self];
        }
        
       if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 2 && [[SingleTone sharedManager] orderCart])
        {
            NSDictionary * cartOrder = [[SingleTone sharedManager] orderCart];
            
            decor = [[DecorView alloc] initWithView:self.view andNumber:[cartOrder objectForKey:@"count"] andPrice:[cartOrder objectForKey:@"cost"] andWithBlock:NO];
            
            CGRect rect = decor.frame;
            rect.origin.y = rect.origin.y + 64;
            decor.frame = rect;
            
            if([[[[SingleTone sharedManager] orderCart] objectForKey:@"cost"]integerValue]>0){
                decor.alpha = 0.7;
            }else{
                decor.alpha = 0;
            }
            [self.view addSubview:decor];
            
            UIButton * buttonDecor = (UIButton *)[self.view viewWithTag:555];
            [buttonDecor addTarget:self action:@selector(buttonDecorAction) forControlEvents:UIControlEventTouchUpInside];
        }
    
    }];
        

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) buttonChangePriceAction
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    //Overwrite SCLAlertView (Buttons, top circle and borders) colors
    alert.customViewColor = [UIColor colorWithHexString:@"3038a0"];
    
    //Set custom tint color for icon image.
    alert.iconTintColor = [UIColor whiteColor];
    
    UITextField *textField = [alert addTextField:@"Новая цена"];
    
    [alert addButton:@"Изменить" actionBlock:^(void) {
        [self postApiPrice:textField.text];
       
    }];
    
    [alert showEdit:self title:@"Измените цену" subTitle:@"Введите новую цену" closeButtonTitle:@"Отмена" duration:0.0f];
    
}

- (void) areAvailableAction
{
    [self postApiAviable:@"1" andBlock:^{
        [UIView animateWithDuration:0.3 animations:^{
            notAvailable.backgroundColor = [UIColor whiteColor];
            [notAvailable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            areAvailable.backgroundColor = [UIColor colorWithHexString:@"a0a7db"];
            [areAvailable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }];
    }];
    
}

- (void) notAvailableAction
{
    [self postApiAviable:@"-5" andBlock:^{
    [UIView animateWithDuration:0.3 animations:^{
        areAvailable.backgroundColor = [UIColor whiteColor];
        [areAvailable setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        notAvailable.backgroundColor = [UIColor colorWithHexString:@"a0a7db"];
        [notAvailable setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];
        }];

}



//Тащим товары категории
-(void) getApiProduct: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             self.productID,@"product",
                             nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/product" complitionBlock:^(id response) {
        
        [activityIndicator setHidden:YES];
        [activityIndicator stopAnimating];
        ParserProductResponse * parsingResponce =[[ParserProductResponse alloc] init];
        [parsingResponce parsing:response andArray:self.arrayProduct andBlock:^{
            
            
            block();
            
        }];
        
        
    }];
    
}

//Данные для заполнения View "Купить"
-(void) getApiBuyProductInfo: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             self.productID,@"product",
                             nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/buy_product_info" complitionBlock:^(id response) {
        [activityIndicator setHidden:YES];
        [activityIndicator stopAnimating];
        
        ParserBuyProductInfoResponse * parsingResponce =[[ParserBuyProductInfoResponse alloc] init];
        [parsingResponce parsing:response andArray:self.arrayBuyProductInfo andBlock:^{
            NSLog(@"RESP %@",response);
            
            block();
            
        }];
        
        
    }];
    
}

//Отправляем цену на сервер
- (void)postApiPrice:(NSString *) price
{
    //Передаваемые параметры
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            self.productID,@"product",
                            price,@"cost",
                            nil];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params
                        andAddParam:nil
                             method:@"abpro/product_cost"
                    complitionBlock:^(id response) {
                        [activityIndicator setHidden:YES];
                        [activityIndicator stopAnimating];
                        NSDictionary* dict = (NSDictionary*)response;
                        if ([[dict objectForKey:@"status"] integerValue] == 1) {
                            
                            self.priceLabel.text = [NSString stringWithFormat:@"%@ руб.",price];
                            
                        }else {
                            
                        }
                    }];
}


#pragma mark - CART
//Работа с корзиной

//Добавляем единицу товара в корзину
- (void)postApiAddItemToCart:(NSString *) productID
{
    //Передаваемые параметры
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            productID,@"size",
                            nil];

    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params
                        andAddParam:nil
                             method:@"abpro/buy_product_add"
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

//Удаляем единцу товара из корзины
- (void)postApiDelItemToCart:(NSString *) productID
{
    //Передаваемые параметры
    
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            productID,@"size",
                            nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params
                        andAddParam:nil
                             method:@"abpro/buy_product_del"
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

//Удалить все все товарные предложения по этому товару
- (void)postApiDelAllItemToCart
{
    //Передаваемые параметры
    
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            self.productID,@"product",
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

//Добавить +1 ко всему
- (void)postApiOneAddAllItemToCart
{
    //Передаваемые параметры
    
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            self.productID,@"product",
                            nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params
                        andAddParam:nil
                             method:@"abpro/buy_product_plus_one"
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

//Добавить -1 ко всему
- (void)postApiOneDelAllItemToCart
{
    //Передаваемые параметры
    
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            self.productID,@"product",
                            nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params
                        andAddParam:nil
                             method:@"abpro/buy_product_minus_one"
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

#pragma mark -


//


//Отправляем цену на сервер
- (void)postApiAviable:(NSString*) aviable andBlock:(void (^)(void))block
{
    //Передаваемые параметры
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            self.productID,@"product",
                            aviable,@"status",
                            nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params andAddParam:nil
                             method:@"abpro/product_status"
                    complitionBlock:^(id response) {
                        
                        [activityIndicator setHidden:YES];
                        [activityIndicator stopAnimating];
                        
                        NSDictionary* dict = (NSDictionary*)response;
                        
                        if ([[dict objectForKey:@"status"] integerValue] == 1) {
                            
                            block();
                        }else {
                            
                        }
                    }];
}

//Отправляем доступность размера
- (void)postApiAviableSize:(NSString *) aviable andPriceID:(NSString *) priceID andBlock:(void (^)(void))block
{
    //Передаваемые параметры
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            priceID,@"price",

                            nil];
    NSString * addParam = [NSString stringWithFormat:@"aviable=%@",aviable];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center=CGPointMake(self.view.center.x, self.view.center.y-64);
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params andAddParam:addParam
                             method:@"abpro/price_aviable"
                    complitionBlock:^(id response) {
                        
                        [activityIndicator setHidden:YES];
                        [activityIndicator stopAnimating];
                        NSDictionary* dict = (NSDictionary*)response;
                        
                        if ([[dict objectForKey:@"status"] integerValue] == 1) {
                            
                            block();
                        }else {
                            
                        }
                    }];
}

//Увеличиваем изображение
-(void) largeImage{
   
    NSDictionary * productInfo=[self.arrayProduct objectAtIndex:0];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSArray * array = [productInfo objectForKey:@"images"];
    
    NSMutableArray * arrayFullImage = [NSMutableArray array];
    NSString * newURLImage;
    for (int i=0; i<array.count; i++) {
        NSString * oldURL = [array objectAtIndex:i];
         newURLImage = [oldURL stringByReplacingOccurrencesOfString:@"img_med"
                                             withString:@"img"];
        [arrayFullImage addObject:newURLImage];
        
    }
    
    
    self.viewProductDetails = [[ViewProductDetails alloc] initWithFrame:CGRectMake(0, 0,
                                                                                               width,
                                                                                               height-64)
                               andArray:arrayFullImage
                               andFullScreen:YES];
   
    mainScrollView.scrollEnabled=NO;
    self.viewProductDetails.alpha =0;
    
    
    //Кнопка закрыть
    self.buttonCloseView = [[UIButton alloc] init];
    [self.buttonCloseView addTarget:self
                          action:@selector(closeZoom)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonCloseView setTitle:@"X" forState:UIControlStateNormal];
    [self.buttonCloseView.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [self.buttonCloseView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.buttonCloseView.backgroundColor= [UIColor clearColor];
    self.buttonCloseView.frame = CGRectMake(self.view.frame.size.width-45, 5, 40, 40);
    self.buttonCloseView.alpha = 0;
    self.buttonCloseView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.buttonCloseView.layer.borderWidth = 2.0;
    self.buttonCloseView.layer.cornerRadius = 20; // this value vary as per your desire
    self.buttonCloseView.clipsToBounds = YES;
    
    //
    

    
    //Распознование нажатия на скролл
    UITapGestureRecognizer *tapRecognizer;
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeZoom)];
    [self.viewProductDetails addGestureRecognizer:tapRecognizer];
   
    self.viewProductDetails.userInteractionEnabled = YES;
    //
    
    [mainScrollView addSubview:self.viewProductDetails];
    [mainScrollView addSubview:self.buttonCloseView];

    [UIView animateWithDuration:1.0 animations:^(void) {
        self.viewProductDetails.alpha = 1;
        self.buttonCloseView.alpha = 1;
        
    }];
  
    
    
}

-(void) closeZoom{
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.viewProductDetails.alpha = 0;
        self.buttonCloseView.alpha = 0;
        
    }];
    self.viewProductDetails=nil;
    self.buttonCloseView=nil;
    mainScrollView.scrollEnabled=YES;
    
    
}







//#pragma mark - UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 7;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
//                                      reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = @"Привет";
//    cell.detailTextLabel.text = @"Как дела";
//    
//    return cell;
//}

- (void) buttonSizeAction: (UIButton *) button
{
    for (int i = 0; i < productSizes.count; i ++) {
        NSDictionary * testDict = [productSizes objectAtIndex:i];
        self.tempArraySizes = [NSMutableArray array];
        

        if (button.tag == 300 + i) {
            
            
            if([[testDict objectForKey:@"aviable"] integerValue] == 0){
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                alert.customViewColor = [UIColor colorWithHexString:@"3038a0"];
                //Using Selector
                
                [alert addButton:@"Ok" actionBlock:^{
                    [self postApiAviableSize:@"1" andPriceID:[testDict objectForKey:@"id"] andBlock:^{
                        
                        button.backgroundColor = [UIColor colorWithHexString:@"e9eaf7"];
                        
                        
                        
                    }];
                }];
                
                NSString * sizeText = [NSString stringWithFormat:@"Размера %@ нет в наличии, включить ?",[testDict objectForKey:@"value"]];
                [alert showSuccess:self title:@"Включение размера" subTitle:sizeText closeButtonTitle:@"Отмена" duration:0.0f];
                
            }else{
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                alert.customViewColor = [UIColor colorWithHexString:@"3038a0"];
                //Using Selector
                
                [alert addButton:@"Ok" actionBlock:^{
                    [self postApiAviableSize:@"0" andPriceID:[testDict objectForKey:@"id"] andBlock:^{
                        
                        button.backgroundColor = [UIColor colorWithHexString:@"ffebee"];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:self];
                        
                       
                    }];
                }];
                
                NSString * sizeText = [NSString stringWithFormat:@"Размера %@ в наличии, отключить ?",[testDict objectForKey:@"value"]];
                [alert showSuccess:self title:@"Отключение размера" subTitle:sizeText closeButtonTitle:@"Отмена" duration:0.0f];
                
            }
            
        }
    }
}

- (void)reloadView{
    [self viewDidLoad]; [self viewWillAppear:YES];
}



- (void) buttonSizeAddAction
{
    EditSizeViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"EditSizeViewController"];
    detail.productID=self.productID;
    [self.navigationController pushViewController:detail animated:YES];
}

//View для кнопки купить

- (void) buyButtonAction
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(buttonMainActionTuch)];
    
    [self.view addGestureRecognizer:tap];
    
    
    
    self.addToCartView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,
                                                                    width,
                                                                     height-40)];
    self.addToCartView.showsVerticalScrollIndicator = NO;
    self.addToCartView .backgroundColor =[UIColor whiteColor];
    
    mainScrollView.scrollEnabled=NO;
    self.addToCartView.alpha =0;
    
    
    //Кнопка закрыть
    self.buttonCloseView = [[UIButton alloc] init];
    [self.buttonCloseView addTarget:self
                             action:@selector(closeAddToCart)
                   forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonCloseView setTitle:@"X" forState:UIControlStateNormal];
    [self.buttonCloseView.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [self.buttonCloseView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.buttonCloseView.backgroundColor= [UIColor clearColor];
    self.buttonCloseView.frame = CGRectMake(self.view.frame.size.width-45, 10, 40, 40);
    self.buttonCloseView.alpha = 0;
    self.buttonCloseView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.buttonCloseView.layer.borderWidth = 2.0;
    self.buttonCloseView.layer.cornerRadius = 20; // this value vary as per your desire
    self.buttonCloseView.clipsToBounds = YES;
    
    //
    
    
    
    [mainScrollView addSubview:self.addToCartView ];
    [self.addToCartView addSubview:self.buttonCloseView];
    
    self.arrayBuyProductInfo = [NSMutableArray array];
    [self getApiBuyProductInfo:^{
        if(self.arrayBuyProductInfo && self.arrayBuyProductInfo.count>0){
            
            
            ParserBuyProductInfo * parserBuyProductInfo = [self.arrayBuyProductInfo objectAtIndex:0];
            NSDictionary * productBuyInfo = parserBuyProductInfo.product;
            productBuySizes = [productBuyInfo objectForKey:@"sizes"];
            
            UILabel * productTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 150, 40)];
//            productTitle.text= [productBuyInfo objectForKey:@"name"];
            productTitle.text = @"Цена товара:";
            productTitle.textColor = [UIColor colorWithHexString:@"3038a0"];
            productTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            productTitle.alpha = 1;
            [self.addToCartView addSubview:productTitle];
            
            
            
            
            UILabel * productCoast = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width- 120, 10, 150, 40)];
            productCoast.text= [productBuyInfo objectForKey:@"cost"];
            productCoast.textColor = [UIColor blackColor];
            productCoast.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
            productCoast.alpha = 1;
            [self.addToCartView addSubview:productCoast];
            
            
            for (int i=0; i<productBuySizes.count; i++) {
                NSDictionary * productBuySizesInfo = [productBuySizes objectAtIndex:i];
                
                UILabel * sizeTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 80+(i*40), 100, 40)];
                sizeTitle.text= [productBuySizesInfo objectForKey:@"value"];
                sizeTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
                sizeTitle.textColor = [UIColor colorWithHexString:@"757575"];
                sizeTitle.font = [UIFont systemFontOfSize:14];
                sizeTitle.alpha = 1;
                [self.addToCartView addSubview:sizeTitle];
                
                UIButton * buttonAdd = [UIButton buttonWithType:UIButtonTypeSystem];
                buttonAdd.frame = CGRectMake(self.view.frame.size.width - 50, 77+(i*40), 40, 40);
                buttonAdd.backgroundColor = nil;
                [buttonAdd setTitle:@"+" forState:UIControlStateNormal];
                [buttonAdd setTitleColor:[UIColor colorWithHexString:@"a6a0dd"] forState:UIControlStateNormal];
                buttonAdd.titleLabel.font = [UIFont systemFontOfSize:22];
                buttonAdd.tag = 100 + i;
                [buttonAdd addTarget:self action:@selector(buttonAddAction:)
                                forControlEvents:UIControlEventTouchUpInside];
                [self.addToCartView addSubview:buttonAdd];
              
                UIButton * buttonDel = [UIButton buttonWithType:UIButtonTypeSystem];
                buttonDel.frame = CGRectMake(self.view.frame.size.width - 100, 77+(i*40), 40, 40);
                buttonDel.backgroundColor = nil;
                [buttonDel setTitle:@"-" forState:UIControlStateNormal];
                [buttonDel setTitleColor:[UIColor colorWithHexString:@"a6a0dd"] forState:UIControlStateNormal];
                buttonDel.titleLabel.font = [UIFont systemFontOfSize:22];
                buttonDel.tag = 200 + i;
                [buttonDel addTarget:self action:@selector(buttonDelAction:)
                    forControlEvents:UIControlEventTouchUpInside];
                [self.addToCartView addSubview:buttonDel];
                
                
                LabelProductDetail * labelNumber = [[LabelProductDetail alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, 77+(i*40), 40, 40)];
                labelNumber.text = [productBuySizesInfo objectForKey:@"count"];  
                NSString * labelCount = [NSString stringWithFormat: @"321%@",[productBuySizesInfo objectForKey:@"id"]];
                labelNumber.customTag = labelCount;
                labelNumber.textColor = [UIColor colorWithHexString:@"acacac"];
                labelNumber.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
                [testMArray addObject:labelNumber];
                [self.addToCartView addSubview:labelNumber];
          
            }
            

            
            //Кнопка дл выезжаещего вью-----------------------------
            UIButton * buttonMain = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonMain.frame = CGRectMake(self.addToCartView.frame.size.width - 50, 250+(productBuySizes.count*40), 40, 40);
            buttonMain.backgroundColor = [UIColor colorWithHexString:@"a59edd"];
            buttonMain.layer.cornerRadius = 20;
            [buttonMain addTarget:self action:@selector(buttonMainAction)
                 forControlEvents:UIControlEventTouchUpInside];
            [self.addToCartView addSubview:buttonMain];
            
            UIImageView * imageViewMain = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            imageViewMain.backgroundColor = nil;
            imageViewMain.image = [UIImage imageNamed:@"ic_more.png"];
            [buttonMain addSubview:imageViewMain];
            
//            //Кнопка подтверждения----------------------------------
//            UIButton * buttonConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
//            buttonConfirm.frame = CGRectMake(10, buttonMain.frame.origin.y + 60, self.view.frame.size.width - 20, 35);
//            buttonConfirm.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
//            [buttonConfirm setTitle:@"Купить" forState:UIControlStateNormal];
//            [buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [buttonConfirm addTarget:self action:@selector(buttonConfirmAction)
//                    forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.addToCartView addSubview:buttonConfirm];
            
            self.addToCartView.contentSize = CGSizeMake(self.view.frame.size.width, buttonMain.frame.origin.y + 150);
            
            //Выезжающее вью----------------------------------------
            viewMove = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width + 10, buttonMain.frame.origin.y - 170, 160, 160)];
            viewMove.backgroundColor = nil;
            viewMove.layer.borderColor = [UIColor colorWithHexString:@"3038a0"].CGColor;
            viewMove.layer.borderWidth = 1.f;
            [self.addToCartView addSubview:viewMove];
            
            UIButton * buttonDeleteAll = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonDeleteAll.frame = CGRectMake(10, 10, 140, 40);
            buttonDeleteAll.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
            [buttonDeleteAll setTitle:@"Очистить" forState:UIControlStateNormal];
            [buttonDeleteAll setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buttonDeleteAll addTarget:self action:@selector(buttonDeleteAllAction)
                                  forControlEvents:UIControlEventTouchUpInside];
            [viewMove addSubview:buttonDeleteAll];
            
            UIButton * buttonAddAllOnOnce = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonAddAllOnOnce.frame = CGRectMake(10, 60, 140, 40);
            buttonAddAllOnOnce.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
            [buttonAddAllOnOnce setTitle:@"+ 1 Всего" forState:UIControlStateNormal];
            [buttonAddAllOnOnce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buttonAddAllOnOnce addTarget:self action:@selector(buttonAddAllOnOnceAction)
                      forControlEvents:UIControlEventTouchUpInside];
            [viewMove addSubview:buttonAddAllOnOnce];
            
            UIButton * buttonDelAllOnOnce = [UIButton buttonWithType:UIButtonTypeSystem];
            buttonDelAllOnOnce.frame = CGRectMake(10, 110, 140, 40);
            buttonDelAllOnOnce.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
            [buttonDelAllOnOnce setTitle:@"- 1 Всего" forState:UIControlStateNormal];
            [buttonDelAllOnOnce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [buttonDelAllOnOnce addTarget:self action:@selector(buttonDelAllOnOnceAction)
                         forControlEvents:UIControlEventTouchUpInside];
            [viewMove addSubview:buttonDelAllOnOnce];
            
        }
    }];
   
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.addToCartView.alpha = 1;
        self.buttonCloseView.alpha = 1;
        
    }];
}

-(void) closeAddToCart{
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.addToCartView.alpha = 0;
        self.buttonCloseView.alpha = 0;
        
    }];
    self.addToCartView=nil;
    self.buttonCloseView=nil;
    mainScrollView.scrollEnabled=YES;
    isBool = NO;
    
    
}

- (void) buttonDecorAction
{
    IssueViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"IssueViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Кнопка увеличить-------------------------------
- (void) buttonAddAction: (UIButton*) button
{
    for (int i = 0; i < productBuySizes.count; i++) {
        NSDictionary * productBuySizesInfo =[productBuySizes objectAtIndex:i];
        if (button.tag == 100 + i) {
            
            LabelProductDetail * labelCount= (LabelProductDetail *)testMArray[i];
            
                NSInteger count = [labelCount.text integerValue];
                count +=1;
                labelCount.text =[NSString stringWithFormat:@"%li",count];
                [self postApiAddItemToCart:[productBuySizesInfo objectForKey:@"id"]];

        }
    }
}

//Кнопка уменьшить-------------------------------
- (void) buttonDelAction: (UIButton*) button
{
    for (int i = 0; i < productBuySizes.count; i++) {
        NSDictionary * productBuySizesInfo =[productBuySizes objectAtIndex:i];
        if (button.tag == 200 + i) {
            NSString * labeltag = [NSString stringWithFormat:@"321%@",[productBuySizesInfo objectForKey:@"id"]];
            LabelProductDetail * labelCount= (LabelProductDetail *)testMArray[i];
            NSInteger count = [labelCount.text integerValue];
            if(count>0){
                count -=1;
            }else{
                count = 0;
            }
            labelCount.text =[NSString stringWithFormat:@"%li",count];
            
            [self postApiDelItemToCart:[productBuySizesInfo objectForKey:@"id"]];
        }
    }
}

//Кнопка выдвигаеммого вью----------------------
- (void) buttonMainActionTuch
{
    if (!isBool) {
        
    } else {
        [Animation animateTransformView:viewMove withScale:1 move_X:+ 180 move_Y:0 alpha:1 delay:0];
        isBool = NO;
    }
}

//Кнопка выдвигаеммого вью----------------------
- (void) buttonMainAction
{
    if (!isBool) {
        [Animation animateTransformView:viewMove withScale:1 move_X:- 180 move_Y:0 alpha:1 delay:0];
        isBool = YES;
    } else {
        [Animation animateTransformView:viewMove withScale:1 move_X:+ 180 move_Y:0 alpha:1 delay:0];
        isBool = NO;
    }
}

//Кнопка купить----------------------------------
- (void) buttonConfirmAction
{
    NSLog(@"Купить");
}

//Кнопка Очистить все-----------------------------
- (void) buttonDeleteAllAction
{
    [self postApiDelAllItemToCart];

        for (int i=0; i<testMArray.count; i++) {
            LabelProductDetail * labelCount= (LabelProductDetail *)testMArray[i];
            labelCount.text =@"0";
            
        }
    
}

//Кнопка увеличить все на еденицу-----------------
- (void) buttonAddAllOnOnceAction
{
    [self postApiOneAddAllItemToCart];
    for (int i=0; i<testMArray.count; i++) {
        LabelProductDetail * labelCount= (LabelProductDetail *)testMArray[i];
        
        NSInteger count = [labelCount.text integerValue];
        count +=1;
        labelCount.text =[NSString stringWithFormat:@"%li",count];
        
    }
    
}

//Кнопка уменьшить все на еденицу-----------------
- (void) buttonDelAllOnOnceAction
{
    [self postApiOneDelAllItemToCart];
    for (int i=0; i<testMArray.count; i++) {
        LabelProductDetail * labelCount= (LabelProductDetail *)testMArray[i];
        
        NSInteger count = [labelCount.text integerValue];
        if(count>0){
            count -=1;
        }else{
            count =0;
        }
        
        labelCount.text =[NSString stringWithFormat:@"%li",count];
        
    }
    
}


@end
