//
//  ViewProductDetails.m
//  Sadovod
//
//  Created by Viktor on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewProductDetails.h"
#import "UIColor+HexColor.h"
#import <SDWebImage/UIImageView+WebCache.h> //Загрузка изображения
#import "UIImage+Resize.h"//Ресайз изображения

@interface ViewProductDetails () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton *startButton;

@property (strong, nonatomic) UIImageView *viewOne;
@property (strong, nonatomic) UIImageView *viewTwo;
@property (strong, nonatomic) UIImageView *viewThree;

@property (strong, nonatomic) UITextField * addName;

@end

@implementation ViewProductDetails

- (id)initWithFrame:(CGRect)frame
           andArray: (NSArray *) array //Массив картинок
{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.pageControl];
        
        //Инициализация scrollView-----------------------------------------
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        [_scrollView setDelegate:self];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setContentSize:CGSizeMake(self.frame.size.width*array.count, self.scrollView.frame.size.height)]; // задаем количество слайдов
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setBackgroundColor:[UIColor whiteColor]]; // цвет фона скролвью
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        //Реализация вью-----------------
        for (int i = 0; i < array.count; i++) {
            
           
//            _viewOne.image = [UIImage imageNamed:[array objectAtIndex:i]];
            NSURL *imgURL = [NSURL URLWithString:[array objectAtIndex:i]];
            NSLog(@"COUNT: %i URL:%@",i,[array objectAtIndex:i]);
            //SingleTone с ресайз изображения
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadImageWithURL:imgURL
                                  options:0
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                     // progression tracking code
                                 }
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                    
                                    if (i == 0) {
                                        _viewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
                                    } else {
                                        _viewOne = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
                                    }
                                    
                                    if(image){
                                        
                                        CGSize targetSize = CGSizeMake(image.size.width, image.size.height);
                                        
                                        UIImage * imageResizing = [image resizedImage:targetSize interpolationQuality:kCGInterpolationHigh];
                                        
//
                                            _viewOne.contentMode = UIViewContentModeScaleAspectFit;

                                        UIImage * imageCropped = [imageResizing croppedImage:CGRectMake(35,0, frame.size.width, frame.size.height)];
                                        
                                        
                                        
                                        _viewOne.image = image;
                                        
                                        [_scrollView addSubview:_viewOne];
                                        
                                        
                                    }else{
                                        
                                    }
                                }];

//            [_scrollView addSubview:_viewOne];
            [self addSubview:_scrollView];
        }

        
        //Инициализация pageControl-------------------------------------------
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, self.frame.size.height-20, 60, 10)];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithHexString:@"303f9f"]]; //цвет "точек" при пролистывании экрана приветствия
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [_pageControl setNumberOfPages:array.count]; // задаем количетсво слайдов приветствия
        [self addSubview:_pageControl];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
    
}

@end
