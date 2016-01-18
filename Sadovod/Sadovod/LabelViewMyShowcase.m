//
//  LabelViewMyShowcase.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "LabelViewMyShowcase.h"
#import "UIColor+HexColor.h"

@implementation LabelViewMyShowcase

- (id)initWichValue: (NSString *) stringValue
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(270, 10, 30, 30);
        self.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
        self.alpha = 0.8;
        self.text = stringValue;
        self.textColor = [UIColor colorWithHexString:@"909090"];
        self.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
        
    }
    return self;
}

@end
