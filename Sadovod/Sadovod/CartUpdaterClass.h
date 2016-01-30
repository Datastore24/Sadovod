//
//  CartUpdaterClass.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 29.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DecorView.h"
#import "ParserSimpleCart.h"

@interface CartUpdaterClass : NSObject
+(void) reloadCartWithApi: (void (^)(void))block;
+(void) updateCartWithApi: (UIView *) view;
+(void) updateCartWithApi: (UILabel *) labelCount andLabelPrice: (UILabel *) labelPrice andView:(UIView *) view;
@end
