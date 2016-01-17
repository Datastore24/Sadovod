//
//  SectionTableViewController.m
//  Sadovod
//
//  Created by Viktor on 17.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "SectionTableViewController.h"
#import "ModelSectionTableOwner.h"
#import "ViewSectionTable.h"
#import "ViewControllerProductDetails.h"

@interface SectionTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SectionTableViewController
{
    UITableView * tableItems;
    NSDictionary * dataTableItems;
}

- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"Свитера и кардеганы";
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment: UIOffsetMake(10.f, -100.f) forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataTableItems = [ModelSectionTableOwner dictTableItems];
    
    //Параметры таблицы------------------
    // UITableView, который отображает данные альбома
    CGRect frame = CGRectMake(0.f, -35.f, self.view.frame.size.width, self.view.frame.size.height);
    tableItems = [[UITableView alloc] initWithFrame:frame
                                             style:UITableViewStyleGrouped];
    tableItems.delegate = self;
    tableItems.dataSource = self;
    tableItems.backgroundView = nil;
    [self.view addSubview:tableItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataTableItems[@"urlImage"] count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"];
    }
    
    ViewSectionTable * image = [[ViewSectionTable alloc] initWithFrame:CGRectMake(10, 0, 300, 150) andImageURL:dataTableItems[@"urlImage"][indexPath.row] andLabelPrice:
                                [NSString stringWithFormat:@"%ld", [dataTableItems[@"price"][indexPath.row] integerValue]]];
    [cell addSubview:image];
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ViewControllerProductDetails * detail = [self.storyboard
                                           instantiateViewControllerWithIdentifier:@"ViewControllerProductDetails"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
