//
//  UserMenuViewController.h
//  Sadovod
//
//  Created by Viktor on 16.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewController.h"

@interface UserMenuViewController : ViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@end
