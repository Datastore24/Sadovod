//
//  TextViewHeight.m
//  Sadovod
//
//  Created by Viktor on 21.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "TextViewHeight.h"

@implementation TextViewHeight

- (id)initWhithText: (NSString *) text
{
    self = [super init];
    if (self) {
//        // leave the width at 300 otherwise the height wont measure correctly
//        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 300.0f, 100.0f)];
//        // add text to the UITextView first so we know what size to make it
//        textView.text = text;
//        // get the size of the UITextView based on what it would be with the text
//        CGFloat fixedWidth = textView.frame.size.width;
//        CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//        CGRect newFrame = textView.frame;
//        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
//        textView.frame = newFrame;
    }
    return self;
}

@end
