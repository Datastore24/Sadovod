//
//  OrderViewController.m
//  Sadovod
//
//  Created by Viktor on 22.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "OrderViewController.h"
#import "ViewSectionTable.h"

@implementation OrderViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4, (self.view.frame.size.width / 2)) andImageURL:@"10image.jpg" isInternetURL:NO andLabelPrice:@"400" andResized:NO];
    [self.view addSubview:image];
    
}

@end
