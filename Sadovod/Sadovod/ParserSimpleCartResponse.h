//
//  ParserSimpleCartResponse.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 29.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParserSimpleCart.h"

@interface ParserSimpleCartResponse : NSObject

- (ParserSimpleCart *)parsing:(id)response;

@end
