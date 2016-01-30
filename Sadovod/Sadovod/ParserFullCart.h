//
//  ParserFullCart.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 30.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>
@interface ParserFullCart : NSObject
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSString * global_count;
@property (strong,nonatomic) NSString * global_cost;
@property (strong,nonatomic) NSArray * list;
@end
