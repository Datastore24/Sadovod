//
//  CustomerViewController.h
//  Sadovod
//
//  Created by Viktor on 23.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerViewController : UIViewController
@property (strong,nonatomic) NSString * orderID;
@property (strong, nonatomic) NSMutableArray * arrayOrderClientInfo; //Массив с Товарами
@end
