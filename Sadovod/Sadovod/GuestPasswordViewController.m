//
//  GuestPasswordViewController.m
//  Sadovod
//
//  Created by Viktor on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "GuestPasswordViewController.h"

@implementation GuestPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(aMethod)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    button.frame = CGRectMake(80.0, 50, 160.0, 40.0);
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    
    
    //Главный лейбл---------------------------
    UILabel * mailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 240, 120)];
    mailLabel.text = @"TEST";
    mailLabel.textColor = [UIColor whiteColor];
    mailLabel.textAlignment = NSTextAlignmentCenter;
    mailLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:60];
    mailLabel.center = self.view.center;
    mailLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:mailLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) aMethod
{
    
    NSLog(@"Hello");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
