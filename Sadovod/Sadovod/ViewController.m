//
//  ViewController.m
//  Sadovod
//
//  Created by Viktor on 16.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"
#import "ModelMyShowcase.h"
#import "LabelViewMyShowcase.h"
#import "SectionTableViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewMyShowcase; // Таблица "Моя Витрина"

@end

@implementation ViewController
{
    NSDictionary * tableDict; //Директория хранения данных
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"Моя Витрина";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableDict = [ModelMyShowcase dictTableData];
    
    
    //Задаем цвет бара----------------------------------------
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    
    //Реализация кнопки бокового меню---------------------------
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Параметры моей таблицы------------------------------------
    self.tableViewMyShowcase.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableDict[@"title"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = tableDict[@"title"][indexPath.row];
    
    //Добаляет кастомный лейбл в ячейку-----------------------------
    LabelViewMyShowcase * viewLabel = [[LabelViewMyShowcase alloc]
                          initWichValue:[NSString stringWithFormat:@"%ld", [tableDict[@"value"][indexPath.row] integerValue]]];
    [cell addSubview:viewLabel];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SectionTableViewController * detail = [self.storyboard
                                           instantiateViewControllerWithIdentifier:@"SectionTableViewController"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
