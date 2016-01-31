//
//  ViewSectionTable.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

//Создание изображения товара

#import "ViewSectionTable.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "UIImage+Resize.h"//Ресайз изображения


@implementation ViewSectionTable
{
    UIImageView * imageView; //Создаем картинку
    UILabel * labelPrice; //Лейбл цены
}

- (instancetype)initWithFrame:(CGRect)frame
                  andImageURL: (NSString*) imageUrl
                isInternetURL: (BOOL) isInternetURL
                andLabelPrice: (NSString*) price
                   andResized: (BOOL) resized
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = nil;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5f, 2.5f, frame.size.width - 5, frame.size.height - 5)];
        
        //Создаем изображение с небольшим отступом - 5 пикселей открая:
        if(isInternetURL){
        
        NSURL *imgURL = [NSURL URLWithString:imageUrl];
        
        
        //SingleTone с ресайз изображения
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:imgURL
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                              
                                if(image){
                                    imageView.frame=CGRectMake(0, 0, frame.size.width - 2.5, frame.size.height - 5);
                                    imageView.contentMode = UIViewContentModeScaleAspectFill; // Растягивает, но режет ноги
                                    //_viewOne.contentMode = UIViewContentModeScaleAspectFit; // Пропорционально на весь экран
                                    
                                    [imageView setClipsToBounds:YES];
                                    
                                    if(resized){
                                        imageView.contentMode = UIViewContentModeScaleAspectFill;
                                        imageView.clipsToBounds =YES;
                                    }
                               
                
                                    
                                    imageView.image = image;
                                    
                                    [self addSubview:imageView];
                                    
                                    
                                }else{
                                    
                                }
                            }];

       
        
        }else{
            if(resized){
                imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
            imageView.image = [UIImage imageNamed:imageUrl];
            [self addSubview:imageView];
            
        }
        
        //Создаем ценник----------------------------------------
        if (frame.size.width == 300) {
        labelPrice = [[UILabel alloc] initWithFrame:
                      CGRectMake(imageView.frame.origin.x + imageView.frame.size.width - 67.5,
                                 imageView.frame.origin.y + imageView.frame.size.height - 27.5,
                                 65, 25)];
        } else {
        labelPrice = [[UILabel alloc] initWithFrame:
                      CGRectMake(imageView.frame.origin.x + imageView.frame.size.width - 52.5,
                                 imageView.frame.origin.y + imageView.frame.size.height - 14.5,
                                 50, 12)];
        }
        labelPrice.backgroundColor = [UIColor grayColor];
        labelPrice.text = [NSString stringWithFormat:@"%@ руб.",price];
        labelPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        [labelPrice setTextColor:[UIColor whiteColor]];
        labelPrice.textAlignment = NSTextAlignmentCenter;
        labelPrice.tag = 222;
        [imageView addSubview:labelPrice];
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  andImageURL: (NSString*) imageUrl
                isInternetURL: (BOOL) isInternetURL
                   andResized: (BOOL) resized
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = nil;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5f, 2.5f, frame.size.width - 5, frame.size.height - 5)];
        
        //Создаем изображение с небольшим отступом - 5 пикселей открая:
        if(isInternetURL){
            
            NSURL *imgURL = [NSURL URLWithString:imageUrl];
            
            
            //SingleTone с ресайз изображения
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadImageWithURL:imgURL
                                  options:0
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                     // progression tracking code
                                 }
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                    
                                    if(image){
                                        imageView.frame=CGRectMake(0, 0, frame.size.width - 2.5, frame.size.height - 5);
                                        
                                        
                                        if(resized){
                                            imageView.contentMode = UIViewContentModeScaleAspectFill;
                                            imageView.clipsToBounds =YES;
                                        }
                                        
                                        
                                        
                                        imageView.image = image;
                                        
                                        [self addSubview:imageView];
                                        
                                        
                                    }else{
                                        
                                    }
                                }];
            
            
            
        }else{
            if(resized){
                imageView.contentMode = UIViewContentModeScaleAspectFit;
            }
            imageView.image = [UIImage imageNamed:imageUrl];
            [self addSubview:imageView];
            
        }
        
        //Создаем ценник----------------------------------------
        if (frame.size.width == 300) {
            labelPrice = [[UILabel alloc] initWithFrame:
                          CGRectMake(imageView.frame.origin.x + imageView.frame.size.width - 67.5,
                                     imageView.frame.origin.y + imageView.frame.size.height - 27.5,
                                     65, 25)];
        } else {
            labelPrice = [[UILabel alloc] initWithFrame:
                          CGRectMake(imageView.frame.origin.x + imageView.frame.size.width - 52.5,
                                     imageView.frame.origin.y + imageView.frame.size.height - 14.5,
                                     50, 12)];
        }
        labelPrice.backgroundColor = [UIColor grayColor];
        labelPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
        [labelPrice setTextColor:[UIColor whiteColor]];
        labelPrice.textAlignment = NSTextAlignmentCenter;
        labelPrice.tag = 222;
        
        
    }
    return self;
}



@end
