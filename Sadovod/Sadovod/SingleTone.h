//
//  SingleTone.h
//  Sadovod
//
//  Created by Кирилл Ковыршин on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTone : NSObject{
    NSString *someProperty;
}

@property (strong,nonatomic) NSMutableArray* parsingArray;
@property (strong,nonatomic) NSMutableArray* parsingArrayKey;
@property (strong,nonatomic) NSString* parsingToken;
@property (strong,nonatomic) NSString * typeOfUsers;

+ (id)sharedManager;

@end
