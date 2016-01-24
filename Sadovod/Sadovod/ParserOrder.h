//
//  ParserOrder.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 24.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>
@interface ParserOrder : NSObject
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSDictionary * order;
@property (strong,nonatomic) NSArray * list;
@end
