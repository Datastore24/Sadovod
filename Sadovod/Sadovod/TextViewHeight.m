//
//  TextViewHeight.m
//  Sadovod
//
//  Created by Viktor on 21.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "TextViewHeight.h"

@implementation TextViewHeight

- (instancetype)initWithFrame:(CGRect)frame
                      andText: (NSString *) text
{
    self = [super initWithFrame:frame];
    if (self) {

        self.text = text;
        // get the size of the UITextView based on what it would be with the text
        CGFloat fixedWidth = self.frame.size.width;
        CGSize newSize = [self sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = self.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        self.frame = newFrame;
    }
    return self;
}

@end
