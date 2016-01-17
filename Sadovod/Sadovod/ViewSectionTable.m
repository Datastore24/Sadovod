//
//  ViewSectionTable.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

//Создание изображения товара

#import "ViewSectionTable.h"

@implementation ViewSectionTable
{
    UIImageView * imageView; //Создаем картинку
    UILabel * labelPrice; //Лейбл цены
}

- (instancetype)initWithFrame:(CGRect)frame
                  andImageURL: (NSString*) imageUrl
                andLabelPrice: (NSString*) price
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = nil;
        
        //Создаем изображение с небольшим отступом - 5 пикселей открая:
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5f, 2.5f, frame.size.width - 5, frame.size.height - 5)];
        imageView.image = [UIImage imageNamed:imageUrl];
        [self addSubview:imageView];
        
        //Создаем ценник----------------------------------------
        labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(110, 58.5, 35, 12)];
        labelPrice.backgroundColor = [UIColor lightGrayColor];
        labelPrice.text = price;
        labelPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelPrice.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:labelPrice];
        
        
    }
    return self;
}

@end
