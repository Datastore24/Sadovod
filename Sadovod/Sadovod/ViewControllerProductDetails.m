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

#import "APIPostClass.h"
#import "APIGetClass.h"
#import "ParserProduct.h"
#import "ParserProductResponse.h"
#import "SingleTone.h"
#import "TextViewHeight.h"

@interface ViewControllerProductDetails ()
@property (strong, nonatomic) NSMutableArray * arrayProduct; //Массив с Товарами
@property (strong, nonatomic) ViewProductDetails * viewProductDetails; //Экземпляр класса
@property (strong, nonatomic) UIButton * buttonCloseZoom;
@property (strong, nonatomic) UIView * viewAddSize; //Экземпляр класса
@property (strong, nonatomic) UIButton * buttonCloseAddSize;
@property (strong, nonatomic) UILabel *  lableTitle;
@property (strong, nonatomic) UILabel *  lableAnnotation;

@end

@implementation ViewControllerProductDetails
{
    UIScrollView * mainScrollView; //Основной скрол вью
    UIButton * areAvailable; //Кнопка есть в наличии
    UIButton *notAvailable; //Кнопка нет в наличии
    UITableView * tableDetails; //Таблица деталей
}

- (void)viewDidLoad {
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:self.productName];
    self.navigationItem.titleView = title;
    
     self.arrayProduct = [NSMutableArray array];
    
    [self getApiProduct:^{
        
      NSDictionary * productInfo=[self.arrayProduct objectAtIndex:0];
        
        
    NSArray * array = [productInfo objectForKey:@"images"];
    
    //Инициализация scrollView-----------
    mainScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:mainScrollView];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 550);
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
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 30)];
    priceLabel.text = [NSString stringWithFormat:@"%@ руб.",[productInfo objectForKey:@"cost"]];
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
    UILabel * titleSize = [[UILabel alloc] initWithFrame:CGRectMake(10, notAvailable.frame.origin.y + 45, 150, 40)];
    titleSize.text = @"Доступные размеры";
    titleSize.textColor = [UIColor colorWithHexString:@"3038a0"];
    titleSize.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainScrollView addSubview:titleSize];
    
    //Вью доступных размеров---------------------------------------------------------------
    UIView * mainViewSize = [[UIView alloc] init];
    mainViewSize.backgroundColor = [UIColor whiteColor];
    mainViewSize.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    mainViewSize.layer.borderWidth = 2.f;
    [mainScrollView addSubview:mainViewSize];
        
    //Кнопки размеров---------------------------------------------------------------------
        NSArray * productSizes = [productInfo objectForKey:@"sizes"];
        NSLog(@"SIZE: %@",productSizes);
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
                NSLog(@"YES");
                buttonSize.frame = CGRectMake (2.5, 55+heightLine, (self.view.frame.size.width / 3) - 5, 35);
                heightLine += 45;
                countSizePerline = 1;
                countSizeLine += 1;
                
            }else{
                NSLog(@"NO");
                buttonSize.frame = CGRectMake ((2.5 + (self.view.frame.size.width / 3) * countSizePerline), 10+heightLine, (self.view.frame.size.width / 3) - 5, 35);
                countSizePerline += 1;
                
                
            }
            
            buttonSize.tag = i;
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
        }
        
        //Исправление высоты при необходимости
        int addMainViewSizeHeight=0;
        
        if(countSizePerline==3){
            heightLine+=45;//Увеличиваем отступ вниз
            countSizePerline=0;//Сбрасываем счетчик количество размеров в линию
            
        }
        //
        mainViewSize.frame=CGRectMake(0, titleSize.frame.origin.y + 40, self.view.frame.size.width, 55+heightLine+addMainViewSizeHeight);

        UIButton *buttonSizeAdd = [UIButton buttonWithType:UIButtonTypeSystem];
        [buttonSizeAdd addTarget:self
                       action:@selector(buttonSizeAddAction)
             forControlEvents:UIControlEventTouchUpInside];
        
        
        
        buttonSizeAdd.frame = CGRectMake ((2.5 + (self.view.frame.size.width / 3) * countSizePerline), 10+heightLine, (self.view.frame.size.width / 3) - 5, 35);
        [buttonSizeAdd setTitle:@"+" forState:UIControlStateNormal];
        [buttonSizeAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        buttonSizeAdd.backgroundColor = [UIColor colorWithHexString:@"e9eaf7"];
        buttonSizeAdd.titleLabel.font = [UIFont systemFontOfSize:15];

        [mainViewSize addSubview:buttonSizeAdd];

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
        
        UIView * viewDetails = [[UIView alloc] initWithFrame:CGRectMake(0, (titleDetails.frame.origin.y + 40) + 40 * i, self.view.frame.size.width, 40)];
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
    }
    
    }];

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



//Тащим товары категории
-(void) getApiProduct: (void (^)(void))block{
    //Передаваемые параметры
    
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             self.productID,@"product",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/product" complitionBlock:^(id response) {
        
        ParserProductResponse * parsingResponce =[[ParserProductResponse alloc] init];
        [parsingResponce parsing:response andArray:self.arrayProduct andBlock:^{
            
            
            block();
            
        }];
        
        
    }];
    
}

//Увеличиваем изображение
-(void) largeImage{
    NSLog(@"Large Image: %f",self.view.bounds.size.width);
    NSDictionary * productInfo=[self.arrayProduct objectAtIndex:0];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    NSArray * array = [productInfo objectForKey:@"images"];
    self.viewProductDetails = [[ViewProductDetails alloc] initWithFrame:CGRectMake(0, 0,
                                                                                               width,
                                                                                               height-64)
                               andArray:array
                               andFullScreen:YES];
    NSLog(@"Large Image2: %f",self.viewProductDetails.frame.size.width);
    mainScrollView.scrollEnabled=NO;
    self.viewProductDetails.alpha =0;
    
    
    //Кнопка закрыть
    self.buttonCloseZoom = [[UIButton alloc] init];
    [self.buttonCloseZoom addTarget:self
                          action:@selector(closeZoom)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonCloseZoom setTitle:@"X" forState:UIControlStateNormal];
    [self.buttonCloseZoom.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [self.buttonCloseZoom setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.buttonCloseZoom.backgroundColor= [UIColor clearColor];
    self.buttonCloseZoom.frame = CGRectMake(self.view.frame.size.width-45, 5, 40, 40);
    self.buttonCloseZoom.alpha = 0;
    self.buttonCloseZoom.layer.borderColor = [[UIColor grayColor] CGColor];
    self.buttonCloseZoom.layer.borderWidth = 2.0;
    self.buttonCloseZoom.layer.cornerRadius = 20; // this value vary as per your desire
    self.buttonCloseZoom.clipsToBounds = YES;
    
    //
    

    
    //Распознование нажатия на скролл
    UITapGestureRecognizer *tapRecognizer;
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeZoom)];
    [self.viewProductDetails addGestureRecognizer:tapRecognizer];
   
    self.viewProductDetails.userInteractionEnabled = YES;
    //
    
    [mainScrollView addSubview:self.viewProductDetails];
    [mainScrollView addSubview:self.buttonCloseZoom];

    [UIView animateWithDuration:1.0 animations:^(void) {
        self.viewProductDetails.alpha = 1;
        self.buttonCloseZoom.alpha = 1;
        
    }];
  
    
    
}

-(void) closeZoom{
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.viewProductDetails.alpha = 0;
        self.buttonCloseZoom.alpha = 0;
        
    }];
    self.viewProductDetails=nil;
    self.buttonCloseZoom=nil;
    mainScrollView.scrollEnabled=YES;
    
    
}


//Добавление размера
-(void) buttonSizeAddAction{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.viewAddSize = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    mainScrollView.scrollEnabled=NO;
    self.viewAddSize.alpha =0;
    self.viewAddSize.backgroundColor =[UIColor whiteColor];
    
    

    //Кнопка закрыть
    self.buttonCloseAddSize = [[UIButton alloc] init];
    [self.buttonCloseAddSize addTarget:self
                             action:@selector(closeAddSize)
                   forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonCloseAddSize setTitle:@"X" forState:UIControlStateNormal];
    [self.buttonCloseAddSize.titleLabel setFont:[UIFont systemFontOfSize:22]];
    [self.buttonCloseAddSize setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.buttonCloseAddSize.backgroundColor= [UIColor clearColor];
    self.buttonCloseAddSize.frame = CGRectMake(self.view.frame.size.width-45, 5, 40, 40);
    self.buttonCloseAddSize.alpha = 0;
    self.buttonCloseAddSize.layer.borderColor = [[UIColor grayColor] CGColor];
    self.buttonCloseAddSize.layer.borderWidth = 2.0;
    self.buttonCloseAddSize.layer.cornerRadius = 20; // this value vary as per your desire
    self.buttonCloseAddSize.clipsToBounds = YES;
    
    //
    
    //Заголовок
    self.lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 40)];
    self.lableTitle.text = @"Размеры";
    self.lableTitle.textColor = [UIColor colorWithHexString:@"3038a1"];
    self.lableTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    self.lableTitle.alpha =0;
    //
    
    //Анотация страницы
    self.lableAnnotation = [[UILabel alloc] initWithFrame:CGRectMake(5, 40, 250, 40)];
    self.lableAnnotation.text = @"Выберите нужный размер";
    self.lableAnnotation.textColor = [UIColor grayColor];
    self.lableAnnotation.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    self.lableAnnotation.alpha =0;
    //
    
    [mainScrollView addSubview:self.viewAddSize];
    [mainScrollView addSubview:self.buttonCloseAddSize];
    [mainScrollView addSubview:self.lableTitle];
    [mainScrollView addSubview:self.lableAnnotation];
    
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.viewAddSize.alpha = 0.8;
        self.buttonCloseAddSize.alpha = 0.8;
        self.lableTitle.alpha = 1;
        self.lableAnnotation.alpha = 1;
        
    }];
    
    
    
}

-(void) closeAddSize{
    [UIView animateWithDuration:1.0 animations:^(void) {
        self.viewAddSize.alpha = 0;
        self.buttonCloseAddSize.alpha = 0;
        self.lableTitle.alpha = 0;
        self.lableAnnotation.alpha = 0;
        
    }];
    self.viewAddSize=nil;
    self.buttonCloseAddSize=nil;
    self.lableTitle = nil;
    self.lableAnnotation = nil;
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
    for (int i = 0; i < 3; i ++) {
        if (button.tag == i) {
            NSLog(@"Button tag %d", i);
        }
    }
}


@end
