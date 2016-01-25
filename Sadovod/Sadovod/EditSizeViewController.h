//
//  EditSizeViewController.h
//  Sadovod
//
//  Created by Viktor on 23.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditSizeViewController : UIViewController
@property (strong,nonatomic) NSMutableArray * arrayProductSizes;
@property (strong,nonatomic) NSString * productID;
@property (strong,nonatomic) NSMutableArray * postArray;
@property (strong,nonatomic) NSArray * postArraySorted;

@end
