//
//  ParserProductResponse.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 21.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserProductResponse : NSObject
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block;
@end
