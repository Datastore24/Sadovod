//
//  ParserGuestPasswordResponse.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 20.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserGuestPasswordResponse : NSObject
- (NSMutableArray *)parsing:(id)response;
@end
