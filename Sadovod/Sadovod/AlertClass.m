//
//  AlertClass.m
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "AlertClass.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "UIColor+HexColor.h"


@implementation AlertClass
//Создание AlertView---------------------------------------------------------

+ (void)showAlertViewWithMessage:(NSString*)message view:(UIViewController *) view
{
    SCLAlertView* alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [UIColor colorWithHexString:@"3038a0"];
    
    [alert showSuccess:view title:@"Внимание!!!" subTitle:message closeButtonTitle:@"Ок" duration:0.f];
}
@end
