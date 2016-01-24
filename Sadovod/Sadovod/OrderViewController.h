//
//  OrderViewController.h
//  Sadovod
//
//  Created by Viktor on 22.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController
@property (strong,nonatomic) NSString * orderID;
@property (strong, nonatomic) NSMutableArray * arrayOrder; //Массив с Товарами
@end
