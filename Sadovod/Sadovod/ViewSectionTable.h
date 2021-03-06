//
//  ViewSectionTable.h
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

//инициализация картинки в ячейке--------------------


#import <UIKit/UIKit.h>

@interface ViewSectionTable : UIView

//Инициализация картинок-----------------------------
- (instancetype)initWithFrame:(CGRect)frame
                  andImageURL: (NSString*) imageUrl
                isInternetURL: (BOOL) isInternetURL
                andLabelPrice: (NSString*) price
                   andResized: (BOOL) resized;

//Инициализация картинок без цены---------------------
- (instancetype)initWithFrame:(CGRect)frame
                  andImageURL: (NSString*) imageUrl
                isInternetURL: (BOOL) isInternetURL
                   andResized: (BOOL) resized;
@end
