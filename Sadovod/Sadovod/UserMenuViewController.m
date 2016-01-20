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

@interface UserMenuViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonExit;


@end

@implementation UserMenuViewController
{
    NSArray * menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.menuTableView.backgroundColor = nil;
    
    //Инициализация селектора кнопки выхода-----------------------------
    [self.buttonExit addTarget:self action:@selector(buttonExitAction)
              forControlEvents:UIControlEventTouchUpInside];
    
    menu = [NSArray arrayWithObjects:@"first", @"second", @"third", @"fourth", nil];

    
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
    
    cell.backgroundColor = nil;
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
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

@end
