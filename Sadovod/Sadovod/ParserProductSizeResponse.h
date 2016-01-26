//
//  ParserProductSizeResponse.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 25.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserProductSizeResponse : NSObject
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block;
@end
