//
//  AppDelegate.m
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import "AppDelegate.h"
#import "DHxlsReader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize selectedCategoryString, selectedQuizTitleString, markedCount, categoryArray, questionStudyArray;
@synthesize selectedAirPlane;

#pragma mark - Shared Functions
+ (AppDelegate *) sharedDelegate{
    return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    categoryArray = [[NSMutableArray alloc] init];
    questionStudyArray = [[NSMutableArray alloc] init];
 /*
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"studypro.xls"];
    DHxlsReader *reader = [DHxlsReader xlsReaderWithPath:path];
    assert(reader);
    int categoryID = 0;
    int category1_UID = 0;
    int category2_UID = 0;
    int category3_UID = 0;
    int category4_UID = 0;
    int category5_UID = 0;
    int category6_UID = 0;
    int category7_UID = 0;
    int category8_UID = 0;
    int category9_UID = 0;
    
    int qid_for_cate = 0;
    int row = 1;
    
    NSString        *answer1 = @"";
     NSString        *answer2 = @"";
     NSString        *answer3 = @"";
     NSString        *answer4 = @"";
    
    int correct_answer = 1;
    int random = 0;
    
//    [[SQLiteDatabase sharedInstance] executeQuery:@"delete from tbl_questions"
//                                       withParams:nil
//                                          success:^(SQLiteResult *result) {
//                                              NSLog(@" === successfully ==  Delele");
//                                              
//                                          }
//                                          failure:^(NSString *errorMessage) {
//                                              
//                                              NSLog(@" === Failed ==  Delele");
//                                          }];
    
    
    while(YES) {
        DHcell *cell1 = [reader cellInWorkSheetIndex:0 row:row col:1];
        if(cell1.type == cellBlank) break;
        DHcell *cell2 = [reader cellInWorkSheetIndex:0 row:row col:2];
        DHcell *cell3 = [reader cellInWorkSheetIndex:0 row:row col:3];
        DHcell *cell4 = [reader cellInWorkSheetIndex:0 row:row col:4];
        
        DHcell *cell5 = [reader cellInWorkSheetIndex:0 row:row col:5];
        DHcell *cell6 = [reader cellInWorkSheetIndex:0 row:row col:6];
        DHcell *cell7 = [reader cellInWorkSheetIndex:0 row:row col:7];
        DHcell *cell8 = [reader cellInWorkSheetIndex:0 row:row col:8];

        if([cell2.str isEqualToString:@"Certificates and Documents"]){
            categoryID = 1;
            category1_UID ++;
            qid_for_cate = category1_UID;
        }else if([cell2.str isEqualToString:@"Airworthiness Requirements"]){
            categoryID = 2;
            category2_UID++;
       qid_for_cate = category2_UID;
        }else if([cell2.str isEqualToString:@"Weather"]){
            categoryID = 3;
            category3_UID++;
            qid_for_cate = category3_UID;
        }else if([cell2.str isEqualToString:@"Cross Country Flight Planning"]){
            categoryID = 4;
            category4_UID++;
            qid_for_cate = category4_UID;
        }else if([cell2.str isEqualToString:@"Performance and Limitations"]){
            category5_UID++;
            categoryID = 5;
            qid_for_cate = category5_UID;
        }else if([cell2.str isEqualToString:@"Airplane Systems"]){
            category6_UID++;
            categoryID = 6;
            qid_for_cate = category6_UID;
        }else if([cell2.str isEqualToString:@"Night Operations"]){
            categoryID = 7;
            category7_UID++;
            qid_for_cate = category7_UID;
        }else if([cell2.str isEqualToString:@"Aeromedical Factors"]){
            categoryID = 8;
            category8_UID++;
            qid_for_cate = category8_UID;
        }else if([cell2.str isEqualToString:@"SRM"]){
            categoryID = 9;
            category9_UID++;
            qid_for_cate = category8_UID;
        }
        
        random = rand()%4;
        
        switch (random) {
            case 0:
                answer1 = cell4.str;
                answer2 = cell5.str;
                answer3 = cell6.str;
                answer4 = cell7.str;
                correct_answer = 3;
                break;
            
            case 1:
                
                answer2 = cell4.str;
                answer3 = cell5.str;
                answer4 = cell6.str;
                answer1 = cell7.str;
                correct_answer = 4;
                break;
                
            case 2:
                
                answer3 = cell4.str;
                answer4 = cell5.str;
                answer1 = cell6.str;
                answer2 = cell7.str;
                correct_answer = 1;
                break;
                
            case 3:
                
                answer4 = cell4.str;
                answer1 = cell5.str;
                answer2 = cell6.str;
                answer3 = cell7.str;
                correct_answer = 2;
                break;
                
            default:
                break;
        }
        NSString *getMarkedQuestionCountQuery = [NSString stringWithFormat:@" INSERT INTO tbl_questions (question_id, answer1, answer2, answer3, answer4, correct_answer, category_id, quiz_imagename, quiz_text, quiz_title, study_answer, question_for_category_id, question_marked, airplane_type) VALUES (%d, \"%@\",  \"%@\",  \"%@\",  \"%@\", %d, %d,  \"%@\",  \"%@\",  \"%@\",  \"%@\", %d, %d,  \"%@\")", row - 1, answer1, answer2, answer3, answer4, correct_answer, categoryID,  @"no_media.jpg", cell1.str, cell3.str, cell6.str, qid_for_cate, 0, cell8.str];
        
        
        [[SQLiteDatabase sharedInstance] executeQuery:getMarkedQuestionCountQuery
                                           withParams:nil
                                              success:^(SQLiteResult *result) {
                                                  NSLog(@" === successfully ==  %d  ====", row - 1);
                                                  
                                              }
                                              failure:^(NSString *errorMessage) {
                                                  
                                                  NSString *getMarkedQuestionCountQuery_again = [NSString stringWithFormat:@" INSERT INTO tbl_questions (question_id, answer1, answer2, answer3, answer4, correct_answer, category_id, quiz_imagename, quiz_text, quiz_title, study_answer, question_for_category_id, question_marked) VALUES (%d, '%@',  '%@',  '%@',  '%@', %d, %d,  '%@',  '%@',  '%@',  '%@', %d, %d,  '%@')", row - 1, answer1, answer2, answer3, answer4, correct_answer, categoryID,  @"no_media.jpg", cell1.str, cell3.str, cell6.str, qid_for_cate, 0, cell8.str];
                                                  
                                                  
                                                  [[SQLiteDatabase sharedInstance] executeQuery:getMarkedQuestionCountQuery_again
                                                                                     withParams:nil
                                                                                        success:^(SQLiteResult *result) {
                                                                                            NSLog(@" === successfully ==  %d  ====", row - 1);
                                                                                            
                                                                                        }
                                                                                        failure:^(NSString *errorMessage) {
                                                                                            NSLog(@" === failed ===   %d  === %@ =====", row - 1,  getMarkedQuestionCountQuery);
                                                                                        }];
                                              }];
        
        row++;
    }
    */
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
