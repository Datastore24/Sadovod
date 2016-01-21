//
//  ViewControllerProductDetails.h
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewController.h"

@interface ViewControllerProductDetails : ViewController
@property (strong,nonatomic) NSString * productID;
@property (strong,nonatomic) NSString * productName;
-(void) largeImage;
@end
