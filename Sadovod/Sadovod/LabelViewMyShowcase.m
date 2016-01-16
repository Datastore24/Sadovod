//
//  LabelViewMyShowcase.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "LabelViewMyShowcase.h"

@implementation LabelViewMyShowcase

- (id)initWichValue: (NSString *) stringValue
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(270, 10, 30, 30);
        self.backgroundColor = [UIColor blueColor];
        self.alpha = 0.8;
        self.text = stringValue;
        self.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.cornerRadius = 10.f;
        
    }
    return self;
}

@end
