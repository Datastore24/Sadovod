//
//  DecorView.m
//  Sadovod
//
//  Created by Viktor on 28.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "DecorView.h"
#import "UIColor+HexColor.h"

@implementation DecorView

- (id)initWithView: (UIView *) view
         andNumber: (NSString*) number
          andPrice: (NSString*) prise
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, view.frame.size.height - 104, view.frame.size.width, 40);
        self.backgroundColor = [UIColor colorWithHexString:@"5f5f5f"];
        self.layer.borderColor = [UIColor colorWithHexString:@"5f5f5f"].CGColor;
        self.layer.borderWidth = 0.5;
        
        UILabel * labelDecor = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 220, 40)];
        labelDecor.text = [NSString stringWithFormat:@"Итого %@ товаров на %@ руб", number, prise];
        labelDecor.textColor = [UIColor whiteColor];
        labelDecor.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        [self addSubview:labelDecor];
        
        UIButton * buttonDecor = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonDecor.frame = CGRectMake(view.frame.size.width - 100, 0, 100, 40);
        buttonDecor.backgroundColor = nil;
        [buttonDecor setTitle:@"Оформить" forState:UIControlStateNormal];
        [buttonDecor setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonDecor.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        buttonDecor.layer.borderWidth = 0.5;
        buttonDecor.tag = 555;
        [self addSubview:buttonDecor];
    }
    return self;
}

@end
