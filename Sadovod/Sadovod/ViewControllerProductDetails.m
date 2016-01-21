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

@interface ViewControllerProductDetails ()
@property (strong, nonatomic) NSMutableArray * arrayProduct; //Массив с Товарами

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
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Джампер"];
    self.navigationItem.titleView = title;
    
    NSArray * array = [NSArray arrayWithObjects:@"1image.jpg", @"2image.jpg", @"3image.jpg",
                                                @"5image.jpg", @"6image.jpg", nil];
    
    //Инициализация scrollView-----------
    mainScrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    [self.view addSubview:mainScrollView];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 350);
    mainScrollView.showsVerticalScrollIndicator = NO;
    
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
    borderView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
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
    [mainScrollView addSubview:notAvailable];
    
    //Лейбл заголовка Доступные размеры---------------------------------------------------
    UILabel * titleSize = [[UILabel alloc] initWithFrame:CGRectMake(10, notAvailable.frame.origin.y + 45, 150, 40)];
    titleSize.text = @"Доступные размеры";
    titleSize.textColor = [UIColor colorWithHexString:@"3038a0"];
    titleSize.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainScrollView addSubview:titleSize];
    
    //Вью доступных размеров---------------------------------------------------------------
    UIView * mainViewSize = [[UIView alloc] initWithFrame:CGRectMake(0, titleSize.frame.origin.y + 40, self.view.frame.size.width, 100)];
    mainViewSize.backgroundColor = [UIColor whiteColor];
    mainViewSize.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    mainViewSize.layer.borderWidth = 2.f;
    [mainScrollView addSubview:mainViewSize];
    
    //Лейбл заголовка Описание-------------------------------------------------------------
    UILabel * titleDescription = [[UILabel alloc] initWithFrame:CGRectMake(10, mainViewSize.frame.origin.y + 105, 150, 40)];
    titleDescription.text = @"Описание";
    titleDescription.textColor = [UIColor colorWithHexString:@"3038a0"];
    titleDescription.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [mainScrollView addSubview:titleDescription];
    
    //Вью описания---------------------------------------------------------------------------
    UIView * viewDescription = [[UIView alloc] initWithFrame:CGRectMake(0, titleDescription.frame.origin.y + 40, self.view.frame.size.width, 40)];
    viewDescription.backgroundColor = [UIColor whiteColor];
    viewDescription.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    viewDescription.layer.borderWidth = 2.f;
    [mainScrollView addSubview:viewDescription];
    
    //Лейбл заголовка Описание-------------------------------------------------------------
    UILabel * titleDetails = [[UILabel alloc] initWithFrame:CGRectMake(10, viewDescription.frame.origin.y + 45, 150, 40)];
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
    for (int i = 0; i < 7; i++) {
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
        labelDetail.text = @"   Цвет";
        labelDetail.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [viewDetails addSubview:labelDetail];
        
        //Создаем заголовок данных--------------------------------------------------------------
        UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, self.view.frame.size.width - 120, 40)];
        labelData.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        labelData.layer.borderWidth = 1;
        labelData.text = @"  Черный";
        labelData.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [viewDetails addSubview:labelData];
    }
    
    

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
                             self.catID,@"cat",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/products_list" complitionBlock:^(id response) {
        
        ParserProductResponse * parsingResponce =[[ParserProductResponse alloc] init];
        
        [parsingResponce parsing:response andArray:self.arrayProduct andBlock:^{
            
            
            block();
            
        }];
        
        
    }];
    
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

@end
