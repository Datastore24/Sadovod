//
//  ParserLoginPasswordResponse.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserLoginPasswordResponse : NSObject
- (NSMutableArray *)parsing:(id)response;
@end
