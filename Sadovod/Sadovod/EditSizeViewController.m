//
//  EditSizeViewController.m
//  Sadovod
//
//  Created by Viktor on 23.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "EditSizeViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"
#import "ViewControllerProductDetails.h"

#import "SingleTone.h"
#import "APIGetClass.h"
#include "APIPostClass.h"
#import "ParserProductSize.h"
#import "ParserProductSizeResponse.h"

@implementation EditSizeViewController

-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style: UIBarButtonItemStylePlain target:self action:@selector(aMethod:)];
    self.navigationItem.rightBarButtonItem = backButton;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Размеры"];
    self.navigationItem.titleView = title;
    self.arrayProductSizes =[NSMutableArray array];
    
    
    [self getApiProductSize:^{
        
        if(self.arrayProductSizes.count>0){
        
        ParserProductSize * parserProductSize = [self.arrayProductSizes objectAtIndex:0];
            
            NSArray * arraySizes = parserProductSize.sizes;
            NSArray * arrayAviableSizes = parserProductSize.aviable;
            self.postArray = [[NSMutableArray alloc] initWithArray:arrayAviableSizes];
        
        int heightLine=0; //На каждую строку добавляется +45
        int countSizePerline=0; // Количество в строке от 0
        int countSizeLine=1; //Количество строк
        
        for (int i = 0; i < arraySizes.count; i++) {
            
            
            UIButton *buttonSize = [UIButton buttonWithType:UIButtonTypeSystem];
            [buttonSize addTarget:self
                           action:@selector(buttonSizeAction:)
                 forControlEvents:UIControlEventTouchUpInside];
            if(i!=0 && countSizePerline==3){
                
                buttonSize.frame = CGRectMake (2.5, 50+heightLine, (self.view.frame.size.width / 3) - 5, 35);
                heightLine += 40;
                countSizePerline = 1;
                countSizeLine += 1;
                
            }else{
                
                buttonSize.frame = CGRectMake ((2.5 + (self.view.frame.size.width / 3) * countSizePerline), 10+heightLine, (self.view.frame.size.width / 3) - 5, 35);
                countSizePerline += 1;
                
                
            }
            
            buttonSize.tag = [[arraySizes objectAtIndex:i] integerValue];
            [buttonSize setTitle:[arraySizes objectAtIndex:i] forState:UIControlStateNormal];
            
            NSString * colorAviableSizes;
            UIColor * colorTextAviableSizes;
            
            BOOL isAviableSize = [arrayAviableSizes containsObject: [arraySizes objectAtIndex:i]];
            if(isAviableSize){
                colorAviableSizes = @"3038a0";
                colorTextAviableSizes = [UIColor whiteColor];
            }else{
                colorAviableSizes = @"ffebee";
                colorTextAviableSizes = [UIColor blackColor];
                
            }
            

            NSLog(@"SIZE: %@, color: %@",[arraySizes objectAtIndex:i],colorAviableSizes);
            
            buttonSize.backgroundColor = [UIColor colorWithHexString:colorAviableSizes];
            [buttonSize setTitleColor:colorTextAviableSizes forState:UIControlStateNormal];
            
            
            buttonSize.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.view addSubview:buttonSize];
        
    }
        }
        
        }];
    
}


- (void) buttonSizeAction: (UIButton *) button
{
     ParserProductSize * parserProductSize = [self.arrayProductSizes objectAtIndex:0];
    NSArray * arraySizes = parserProductSize.sizes;
    NSArray * arrayAviableSizes = parserProductSize.aviable;
    
    
    
    for (int i = 0; i < arraySizes.count; i++)
    {
        if (button.tag == [[arraySizes objectAtIndex:i] integerValue]) {
            
            
            BOOL isAviableSize = [arrayAviableSizes containsObject: [arraySizes objectAtIndex:i]];
            BOOL isAviableSizeInTempory = [self.postArray containsObject: [arraySizes objectAtIndex:i]];
            if(isAviableSize && isAviableSizeInTempory){
            
                [self.postArray removeObject:[arraySizes objectAtIndex:i]];
                button.backgroundColor = [UIColor colorWithHexString:@"ffebee"];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            }else  if(isAviableSizeInTempory){
                
                [self.postArray removeObject:[arraySizes objectAtIndex:i]];
                button.backgroundColor = [UIColor colorWithHexString:@"ffebee"];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }else if(isAviableSize && !isAviableSizeInTempory){
                [self.postArray addObject:[arraySizes objectAtIndex:i]];
                button.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
            }else if (!isAviableSizeInTempory){
                [self.postArray addObject:[arraySizes objectAtIndex:i]];
                button.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
    }
     NSArray * arrayPost = self.postArray;
    arrayPost = [arrayPost sortedArrayUsingSelector: @selector(compare:)];
    self.postArraySorted = arrayPost;

}

-(void) getApiProductSize: (void (^)(void))block{
    //Передаваемые параметры
    NSLog(@"%@",self.productID);
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             [[SingleTone sharedManager] parsingToken],@"token",
                             self.productID,@"product",
                             nil];
    
    APIGetClass * api =[APIGetClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"abpro/get_sizes" complitionBlock:^(id response) {
        
        ParserProductSizeResponse * parsingResponce =[[ParserProductSizeResponse alloc] init];
        [parsingResponce parsing:response andArray:self.arrayProductSizes andBlock:^{
            NSLog(@"%@",response);
            
            block();
            
        }];
        
        
    }];
    
}

//Отправляем размеры
- (void)postApiOrder:(NSArray *) arraySizes
{
    //Передаваемые параметры
    
    NSString * result = [[arraySizes valueForKey:@"description"] componentsJoinedByString:@","];
    NSString * addParam = [NSString stringWithFormat:@"sizes=%@",result];
    
    NSLog(@"ARRAY %@ PRODUCT ID %@",result,self.productID);
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [[SingleTone sharedManager] parsingToken],@"token",
                            self.productID,@"product",
                            nil];
    
    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params andAddParam:addParam
                             method:@"abpro/set_sizes"
                    complitionBlock:^(id response) {
                        NSDictionary* dict = (NSDictionary*)response;
                        NSLog(@"DICT %@",dict);
                        if ([[dict objectForKey:@"status"] integerValue] == 1) {
                            NSLog(@"ВСЕ ХОРОШО");
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadView" object:self];
                            
                        }else {
                            
                        }
                    }];
}

- (void) aMethod:(id)sender
{
    [self postApiOrder:self.postArraySorted];
   [self.navigationController popViewControllerAnimated:YES];
    
    
}



@end
