//
//  ModelSectionTableOwner.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ModelSectionTableOwner.h"

@implementation ModelSectionTableOwner

+ (NSDictionary *) dictTableItems
{
    NSDictionary * dictTableData = [NSDictionary dictionaryWithObjectsAndKeys:
                                    //Массив URL
                                    [NSArray arrayWithObjects:@"1image.jpg", @"2image.jpg", @"3image.jpg",
                                                              @"4image.jpg", @"5image.jpg", @"6image.jpg",
                                                              @"7image.jpg", @"8image.jpg", @"9image.jpg",
                                                              @"10image.jpg", @"11image.jpg", nil],
                                    @"urlImage",
                                    //Массив Цен
                                    [NSArray arrayWithObjects:[NSNumber numberWithInteger:100],
                                                              [NSNumber numberWithInteger:200],
                                                              [NSNumber numberWithInteger:300],
                                                              [NSNumber numberWithInteger:400],
                                                              [NSNumber numberWithInteger:500],
                                                              [NSNumber numberWithInteger:600],
                                                              [NSNumber numberWithInteger:700],
                                                              [NSNumber numberWithInteger:800],
                                                              [NSNumber numberWithInteger:900],
                                                              [NSNumber numberWithInteger:1000],
                                                              [NSNumber numberWithInteger:1100],nil],
                                    @"price", nil];
    
    return dictTableData;
}

@end
