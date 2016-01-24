//
//  ParserAuth.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface ParserAuthKey : NSObject
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSString * super_key;
@property (strong,nonatomic) NSString * catalog_key;

@end
