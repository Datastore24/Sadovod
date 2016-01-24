//
//  ParserOrderClientInfoResponse.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 24.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserOrderClientInfoResponse : NSObject
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block;
@end
