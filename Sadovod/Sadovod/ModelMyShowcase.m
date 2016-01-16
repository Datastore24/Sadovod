//
//  ModelMyShowcase.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ModelMyShowcase.h"

@implementation ModelMyShowcase

+ (NSDictionary *) dictTableData
{
    NSDictionary * dictTableData = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSArray arrayWithObjects:@"Свитеры и кардеганы",
                                                     @"Капри и бриджи",
                                                     @"Джинсы",
                                                     @"Брюки", nil],
                           @"title",
                           [NSArray arrayWithObjects:[NSNumber numberWithInteger:18],
                                                     [NSNumber numberWithInteger:3],
                                                     [NSNumber numberWithInteger:21],
                                                     [NSNumber numberWithInteger:52], nil],
                           @"value", nil];
    
    return dictTableData;
}

@end
