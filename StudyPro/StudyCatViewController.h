//
//  StudyCatViewController.h
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyCategoryTableViewCell.h"
#import "SQLiteDatabase/SQLiteDatabase.h"

@interface StudyCatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView         *categoryTableView;
}

@property(nonatomic, retain) IBOutlet UITableView *categoryTableView;
-(IBAction)backButtonClicked:(id)sender;

@end
