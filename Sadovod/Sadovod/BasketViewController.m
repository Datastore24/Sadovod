//
//  BasketViewController.m
//  Sadovod
//
//  Created by Viktor on 28.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "BasketViewController.h"
#import "TitleClass.h"
#import "ViewSectionTable.h"
#import "IssueViewController.h"
#import "UIColor+HexColor.h"
#import "SingleTone.h"
#import "DecorView.h"
#import "IssueViewController.h"

@implementation BasketViewController
{
    UIScrollView * mainScrollView;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    TitleClass * title = [[TitleClass alloc]initWithTitle:@"Корзина"];
    self.navigationItem.titleView = title;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
    

    
    
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    [self.view addSubview:mainScrollView];
    
    for (int i = 0; i < 7; i++) {
        //Изобрадение предмета--------------------------------
        ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width / 2 * i, self.view.frame.size.width / 4 + 20, (self.view.frame.size.width / 2)) andImageURL:@"1image.jpg" isInternetURL:NO andResized:NO];
        
        [mainScrollView addSubview:image];
        
        
        //Размер предмета-------------------------------------
        UILabel * sizeObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 10 + self.view.frame.size.width / 2 * i, 250, 20)];
        sizeObjectLabel.text = @"Предмет";
        sizeObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainScrollView addSubview:sizeObjectLabel];
        
        //Колличество заказанного товара----------------------
        UILabel * numberObjectLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width / 4) + 25, 30 + self.view.frame.size.width / 2 * i, 150, 20)];
        numberObjectLabel.text = [NSString stringWithFormat:@"%@ руб", @"400"];
        numberObjectLabel.textColor = [UIColor colorWithHexString:@"3038a0"];
        numberObjectLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [mainScrollView addSubview:numberObjectLabel];
        
        //Лейбл колличество-----------------------------------
        UILabel * labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 10 + self.view.frame.size.width / 2 * i, 80, 20)];
        labelNumber.text = @"Кол-во:";
        labelNumber.textColor = [UIColor colorWithHexString:@"acacac"];
        labelNumber.font = [UIFont fontWithName:@"Helvetica-Bold" size:9];
        [mainScrollView addSubview:labelNumber];
        
        //Вью колличества-------------------------------------
        UILabel * labelNumberAction = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 30 + self.view.frame.size.width / 2 * i, 30, 30)];
        labelNumberAction.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        labelNumberAction.text = @"5";
        labelNumberAction.textColor = [UIColor colorWithHexString:@"b4b4b4"];
        labelNumberAction.textColor = [UIColor colorWithHexString:@"acacac"];
        labelNumberAction.textAlignment = NSTextAlignmentCenter;
        labelNumberAction.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        [mainScrollView addSubview:labelNumberAction];
        
        //Кнопка удалить-------------------------------------
        UIButton * buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonDelete.frame = CGRectMake(self.view.frame.size.width - 65, 30 + self.view.frame.size.width / 2 * i, 30, 30);
        buttonDelete.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        buttonDelete.tag = i;
        [buttonDelete addTarget:self action:@selector(buttonDeleteAction:)
                           forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonDelete];
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 7, 12, 17)];
//        imageView.backgroundColor = [UIColor blueColor];
        imageView.image = [UIImage imageNamed:@"ic_delete"];
        [buttonDelete addSubview:imageView];
    }
    
    
    if ([[[SingleTone sharedManager] typeOfUsers] integerValue] == 2 && [[SingleTone sharedManager] orderCart])
    {
        
        NSDictionary * cartOrder = [[SingleTone sharedManager] orderCart];
        
        DecorView * decor = [[DecorView alloc] initWithView:self.view andNumber:[cartOrder objectForKey:@"count"] andPrice:[cartOrder objectForKey:@"cost"]];
        [self.view addSubview:decor];
        
        UIButton * buttonDecor = (UIButton *)[self.view viewWithTag:555];
        [buttonDecor addTarget:self action:@selector(buttonDecorAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void) buttonDeleteAction: (UIButton*) button
{
    for (int i = 0; i < 7; i ++) {
        if (button.tag == i) {
            NSLog(@"button %d", i);
        }
    }


}

- (void) buttonDecorAction
{
    IssueViewController * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"IssueViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
