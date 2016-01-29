//
//  UserMenuViewController.m
//  Sadovod
//
//  Created by Viktor on 16.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "UserMenuViewController.h"
#import "SWRevealViewController.h"
#import "LognViewController.h"
#import "AuthDbClass.h"
#import "SingleTone.h"
#import "IssueViewController.h"

@interface UserMenuViewController ()

@end

@implementation UserMenuViewController
{
    NSArray * menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NOTIFICATION
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewWhenNewEvent) name:@"ReloadMenu" object:nil];
    //
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.menuTableView.backgroundColor = nil;
    self.menuTableView.scrollEnabled = NO;
    
    menu = [NSArray arrayWithObjects:@"first", @"second", @"third", @"five", @"fourth", nil];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menu count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [menu objectAtIndex:indexPath.row];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
////    if ([cellIdentifier  isEqual: @"goOut"]) {
//    
//        UIView * view = [[UIView alloc] initWithFrame:cell.frame];
//        view.backgroundColor = [UIColor blueColor];
//        [cell addSubview:view];
////    }
    
//    if ([cellIdentifier  isEqual: @"third"]) {
//        
//        cell.userInteractionEnabled = NO;
//    }
    
    cell.backgroundColor = nil;
    
//    //Изменение в таблице-----------------------------------------------------------------
    
    if([[[SingleTone sharedManager] typeOfUsers] integerValue] ==2){
    UILabel * labelCell1 = (UILabel *)[self.view viewWithTag:1001];
    if (labelCell1) {
        labelCell1.text = @"Мои Поставщеки";
    }
    
    UILabel * labelCell2 = (UILabel *)[self.view viewWithTag:1002];
    if (labelCell2) {
        labelCell2.alpha = 0.f;
        
    }
    
    if ([cellIdentifier isEqual:@"second"]) {
        
        cell.userInteractionEnabled = NO;
        
        UILabel * newLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -8, 130, 40)];
        newLabel.text = @"Покупки";
        newLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        newLabel.textColor = [UIColor blackColor];
        [cell addSubview:newLabel];
        
        //Create the button and add it to the cell
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag = 555;
        [button addTarget:self
                   action:@selector(customActionPressed:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Custom Action" forState:UIControlStateNormal];
        button.frame = CGRectMake(20.0f, 60.0f, 150.0f, 30.0f);
        [cell addSubview:button];
        
    }
    }
    
    
    if ([cellIdentifier isEqual:@"third"]) {
        UIImageView * imageTableViewCell = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
        imageTableViewCell.image = [UIImage imageNamed:@"ic_cart_grey.png"];
        [cell addSubview:imageTableViewCell];
        
        UILabel * labelNumber = [[UILabel alloc] initWithFrame:CGRectMake(45, 3, 80, 20)];
        labelNumber.text = @"2 товара";
        labelNumber.textColor = [UIColor blackColor];
        labelNumber.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        [cell addSubview:labelNumber];
        
        UILabel * labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(45, 20, 80, 20)];
        labelPrice.text = @"1000 руб";
        labelPrice.textColor = [UIColor lightGrayColor];
        labelPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        [cell addSubview:labelPrice];
    }
    
    return cell;
}

- (void) customActionPressed: (UIButton *) button
{
    if (button.tag == 555) {
        NSLog(@"Hello");
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 4) {
        NSLog(@"Сюда вставляем все что необходимо по нажатию на выход !!!");
        AuthDbClass * auth = [[AuthDbClass alloc] init];
        [auth DeleteUserWithOutKey];
        //Сюда вводит данные ---------------------------------------------------------
    }
}

//Реализация кнопки выхода-----------------------
- (void) buttonExitAction
{

    NSLog(@"Кнопка выхода");
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return 25.f;
    } else if (indexPath.row == 2){
        if ([[[SingleTone sharedManager] typeOfUsers] integerValue] ==1) {
            return 0;
        } else {
    
    return 45.f;
        }
    } else {
        
        return 44.f;
    }
}

//Обновление таблицы
- (void)reloadTableViewWhenNewEvent {
    
    NSLog(@"RELOAD MENU");
    NSLog(@"TYPE: %@",[[SingleTone sharedManager] typeOfUsers]);
    
   // [self viewDidLoad]; [self viewWillAppear:YES];
    [self.menuTableView
     reloadSections:[NSIndexSet indexSetWithIndex:0]
     withRowAnimation:UITableViewRowAnimationFade];
    
    
    //После обновления
   
}

@end
