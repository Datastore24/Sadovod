//
//  ParserOrderClientInfo.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 24.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>

@interface ParserOrderClientInfo : NSObject
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSString * order_id;
@property (strong,nonatomic) NSString * phone;
@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSString * address;
@property (strong,nonatomic) NSString * comment;
@property (strong,nonatomic) NSString * cost;

@end
