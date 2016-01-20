//
//  ViewProductDetails.m
//  Sadovod
//
//  Created by Viktor on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewProductDetails.h"

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
        [_scrollView setBackgroundColor:[UIColor clearColor]]; // цвет фона скролвью
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        //Реализация вью-----------------
        for (int i = 0; i < array.count; i++) {
            if (i == 0) {
            _viewOne = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            } else {
            _viewOne = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
            }
            _viewOne.image = [UIImage imageNamed:[array objectAtIndex:i]];


            [_scrollView addSubview:_viewOne];
            [self addSubview:_scrollView];
        }

        
        //Инициализация pageControl-------------------------------------------
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, self.frame.size.height-20, 60, 10)];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]]; //цвет "точек" при пролистывании экрана приветствия
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
