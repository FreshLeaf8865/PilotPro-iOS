//
//  AppDelegate.h
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLiteDatabase/SQLiteDatabase.h"
#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

    NSString            *selectedCategoryString;
    NSString            *selectedQuizTitleString;
    NSString            *selectedAirPlane;
    NSInteger           markedCount;
    NSMutableArray      *categoryArray;
    NSMutableArray      *questionStudyArray;
    NSMutableArray      *tmpQuestionArray;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) NSString  *selectedCategoryString;
@property (nonatomic, retain) NSString  *selectedQuizTitleString;
@property (nonatomic, retain) NSString  * selectedAirPlane;
@property (nonatomic, retain) NSMutableArray      *categoryArray;
@property (nonatomic, retain) NSMutableArray      *questionStudyArray;
@property (nonatomic, assign) NSInteger  markedCount;

#pragma mark - Shared Functions;
+ (AppDelegate *) sharedDelegate;

@end

