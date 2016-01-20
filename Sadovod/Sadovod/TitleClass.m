//
//  TitleClass.m
//  Sadovod
//
//  Created by Viktor on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "TitleClass.h"

@implementation TitleClass

- (id)initWithTitle: (NSString*) title
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont fontWithName:@"GoodMobiPro-CondBold" size:24];
        self.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.textAlignment = UITextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
        self.text = title;
        [self sizeToFit];
    }
    return self;
}

@end
