//
//  QuizCatViewController.h
//  StudyPro
//
//  Created by BluesharkUpwork on 23/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizCategoryTableViewCell.h"
#import "SQLiteDatabase/SQLiteDatabase.h"

@interface QuizCatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    UITableView         *categoryTableView;
}

@property(nonatomic, retain) IBOutlet UITableView *categoryTableView;
-(IBAction)backButtonClicked:(id)sender;
-(IBAction)resetScoreButtonClicked:(id)sender;

@end
