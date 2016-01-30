//
//  ParserFullCartResponse.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 30.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserFullCartResponse : NSObject
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block;
@end
