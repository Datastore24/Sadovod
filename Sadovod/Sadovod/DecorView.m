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
      andWithBlock: (BOOL) block
{
    self = [super init];
    if (self) {
        int atherSize;
        if(block){
            atherSize = 40;
        }else{
            atherSize = 104;
        }
        self.frame = CGRectMake(0, view.frame.size.height - atherSize, view.frame.size.width, 40);
        self.tag=554;
        self.backgroundColor = [UIColor colorWithHexString:@"5f5f5f"];
        self.layer.borderColor = [UIColor colorWithHexString:@"5f5f5f"].CGColor;
        self.layer.borderWidth = 0.5;
        
        UILabel * labelDecor = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 220, 40)];
        labelDecor.text = [NSString stringWithFormat:@"Итого %@ на %@ руб", number, prise];
        labelDecor.textColor = [UIColor whiteColor];
        labelDecor.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        labelDecor.tag=556;
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
