//
//  ViewCustomer.h
//  Sadovod
//
//  Created by Viktor on 23.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewCustomer : UIView

- (id)initWithPhone: (NSString *) phone
            andName: (NSString *) name
         andAddress: (NSString*) address
         andComment: (NSString *) comment
             andSum: (NSString *) sum
        andMainView: (UIView*) view;

@end
