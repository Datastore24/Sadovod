//
//  ParserBuyProductInfo.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 28.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>
@interface ParserBuyProductInfo : NSObject
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSDictionary * product;
@property (strong,nonatomic) NSString * total;
@property (strong,nonatomic) NSString * global_count;
@property (strong,nonatomic) NSString * global_cost;

@end
