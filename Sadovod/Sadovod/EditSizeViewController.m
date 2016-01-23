//
//  EditSizeViewController.m
//  Sadovod
//
//  Created by Viktor on 23.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "EditSizeViewController.h"
#import "TitleClass.h"
#import "UIColor+HexColor.h"

@implementation EditSizeViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Размеры"];
    self.navigationItem.titleView = title;

        int heightLine=0; //На каждую строку добавляется +45
        int countSizePerline=0; // Количество в строке от 0
        int countSizeLine=1; //Количество строк
        
        for (int i = 0; i < 20; i++) {
            
            UIButton *buttonSize = [UIButton buttonWithType:UIButtonTypeSystem];
            [buttonSize addTarget:self
                           action:@selector(buttonSizeAction:)
                 forControlEvents:UIControlEventTouchUpInside];
            if(i!=0 && countSizePerline==3){
                NSLog(@"YES");
                buttonSize.frame = CGRectMake (2.5, 50+heightLine, (self.view.frame.size.width / 3) - 5, 35);
                heightLine += 40;
                countSizePerline = 1;
                countSizeLine += 1;
                
            }else{
                NSLog(@"NO");
                buttonSize.frame = CGRectMake ((2.5 + (self.view.frame.size.width / 3) * countSizePerline), 10+heightLine, (self.view.frame.size.width / 3) - 5, 35);
                countSizePerline += 1;
                
                
            }
            
            buttonSize.tag = i;
            [buttonSize setTitle:[NSString stringWithFormat:@"%d", 45 + i] forState:UIControlStateNormal];
            [buttonSize setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.view addSubview:buttonSize];
            
            NSString * colorAviableSizes;
            if(buttonSize.tag % 2 == 0){
                colorAviableSizes = @"ffebee";
            }else{
                colorAviableSizes = @"3038a0";
            }
            
//            [UIColor colorWithHexString:@"3038a0"]
            
            buttonSize.backgroundColor = [UIColor colorWithHexString:colorAviableSizes];
            buttonSize.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.view addSubview:buttonSize];
        
    }
    
}


- (void) buttonSizeAction: (UIButton *) button
{
    for (int i = 0; i < 20; i++)
    {
        if (button.tag == i) {
            NSLog(@"Button TAG = %d", i);
        }
    }
}

@end
