//
//  ViewController.m
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "CategoryData.h"
#import "QuestionData.h"
#import "QuizQuestionViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize airplaneList, selectAirTypeButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *query = @"SELECT * FROM tbl_category";
    
    [[SQLiteDatabase sharedInstance] executeQuery:query
                                       withParams:nil
                                          success:^(SQLiteResult *result) {
                                              NSLog(@"Result count %d",(int)result.count);
                                              
                                              for(SQLiteRow *row in result) {
                                                  
                                                  CategoryData *newData = [[CategoryData alloc] init];
                                                  NSString *cateID = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"category_id"]];
                                                  newData.category_id = cateID.intValue;
                                                  newData.category_name = (NSString *)[row objectForColumnName:@"category_name"];
                                                  newData.category_image = (NSString *)[row objectForColumnName:@"category_imagename"];
                                                  newData.category_bestscore = (NSString *)[row objectForColumnName:@"category_bestscore"];
                                                  
                                                  NSString *getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d", (int)newData.category_id];
                                                  
                                                  [[SQLiteDatabase sharedInstance] executeQuery:getQuestionCountQuery
                                                                                     withParams:nil
                                                                                        success:^(SQLiteResult *result) {
                                                                                            NSLog(@" Query = %@ Result count %d",getQuestionCountQuery, (int)result.count);
                                                                                            newData.category_totalcount = result.count;
                                                                                            
                                                                                        }
                                                                                        failure:^(NSString *errorMessage) {
                                                                                            NSLog(@"Query failed with error - %@",errorMessage);
                                                                                        }];
                                                  
                                                  NSString *getMarkedQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d AND question_marked = 1", (int)newData.category_id];
                                                  
                                                  [[SQLiteDatabase sharedInstance] executeQuery:getMarkedQuestionCountQuery
                                                                                     withParams:nil
                                                                                        success:^(SQLiteResult *result) {
                                                                                            NSLog(@" Query = %@ Result count %d",getMarkedQuestionCountQuery, (int)result.count);
                                                                                            newData.category_markedcount = result.count;
                                                                                            
                                                                                        }
                                                                                        failure:^(NSString *errorMessage) {
                                                                                            NSLog(@"Query failed with error - %@",errorMessage);
                                                                                        }];
                                                  
                                                  
                                                  [[AppDelegate sharedDelegate].categoryArray addObject:newData];
                                                  
                                              }
                                          }
                                          failure:^(NSString *errorMessage) {
                                              NSLog(@"Query failed with error - %@",errorMessage);
                                          }];
    
    selectedAirIndex = 0;
    [AppDelegate sharedDelegate].selectedAirPlane = @"C152";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedTestAllButton:(id)sender{
    
    if([[AppDelegate sharedDelegate].selectedAirPlane isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please select Airplane Type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert setDelegate:self];
        [alert show];
        
    }else{
        
        NSString *getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions ORDER BY Random() LIMIT 60"];
        
        if([[AppDelegate sharedDelegate].questionStudyArray count] > 0)
            [[AppDelegate sharedDelegate].questionStudyArray removeAllObjects];
        
        [[SQLiteDatabase sharedInstance] executeQuery:getQuestionCountQuery
                                           withParams:nil
                                              success:^(SQLiteResult *result) {
                                                  NSLog(@" Query = %@ Result count %d",getQuestionCountQuery, (int)result.count);
                                                  
                                                  for(SQLiteRow *row in result) {
                                                      QuestionData  *newQuestionData = [[QuestionData alloc] init];
                                                      
                                                      newQuestionData.question_id = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"question_id"]].integerValue;
                                                      newQuestionData.answer1 = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"answer1"]];
                                                      newQuestionData.answer2 = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"answer2"]];
                                                      newQuestionData.answer3 = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"answer3"]];
                                                      newQuestionData.answer4 = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"answer4"]];
                                                      newQuestionData.correct_answer = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"correct_answer"]].integerValue;
                                                      newQuestionData.category_id = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"category_id"]].integerValue;
                                                      newQuestionData.quiz_imagename = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"quiz_imagename"]];
                                                      newQuestionData.quiz_text = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"quiz_text"]];
                                                      newQuestionData.quiz_title = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"quiz_title"]];
                                                      newQuestionData.study_answer = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"study_answer"]];
                                                      newQuestionData.question_for_category_id = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"question_for_category_id"]].integerValue;
                                                      newQuestionData.question_marked = 0;
                                                      newQuestionData.quiz_status = 0;
                                                      newQuestionData.selected_answer = 0;
                                                      
                                                      [[AppDelegate sharedDelegate].questionStudyArray addObject:newQuestionData];
                                                      
                                                      
                                                  }
                                                  
                                                  if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                                                      
                                                      UIStoryboard  *mainiPhoneStory = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
                                                      QuizQuestionViewController   *quesitonDetailViewController = [mainiPhoneStory instantiateViewControllerWithIdentifier:@"QuizQuestionViewController"];
                                                      quesitonDetailViewController.testType = 1;
                                                      [self.navigationController pushViewController:quesitonDetailViewController animated:YES];
                                                  }else{
                                                      
                                                      UIStoryboard  *mainiPhoneStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                      QuizQuestionViewController   *quesitonDetailViewController = [mainiPhoneStory instantiateViewControllerWithIdentifier:@"QuizQuestionViewController"];
                                                      quesitonDetailViewController.testType = 1;
                                                      [self.navigationController pushViewController:quesitonDetailViewController animated:YES];
                                                  }
                                                  
                                                  
                                              }
                                              failure:^(NSString *errorMessage) {
                                                  NSLog(@"Query failed with error - %@",errorMessage);
                                              }];
        
        
        [UIView  beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        [airplaneList setFrame:CGRectMake(0, self.view.frame.size.height, airplaneList.frame.size.width, airplaneList.frame.size.height)];
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView commitAnimations];

    }
    
}

- (IBAction)ClickedSelectCommonButton:(id)sender{
    
    if([[AppDelegate sharedDelegate].selectedAirPlane isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please select Airplane Type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert setDelegate:self];
        [alert show];
        
    }else{
        
        [UIView  beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        [airplaneList setFrame:CGRectMake(0, self.view.frame.size.height, airplaneList.frame.size.width, airplaneList.frame.size.height)];
        
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView commitAnimations];
    }

    
}

- (IBAction)ClickedSelectAirPlane:(id)sender{
 
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];

    [airplaneList setFrame:CGRectMake(0, self.view.frame.size.height - airplaneList.frame.size.height, airplaneList.frame.size.width, airplaneList.frame.size.height)];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView commitAnimations];
    
    [airplaneList selectRow:selectedAirIndex inComponent:0 animated:YES];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 4;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString    *returnString;
    
    switch (row) {
        case 0:
            returnString = @"C152";
            break;
          
        case 1:
            returnString = @"C172M";
            break;
        case 2:
            returnString = @"C172SP";
            break;
        case 3:
            returnString = @"SR22";
            break;
            
        default:
            returnString = @"C152";
            break;
    }
    
    return returnString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (row) {
        case 0:
            [AppDelegate sharedDelegate].selectedAirPlane = @"C152";
            [selectAirTypeButton setTitle:@"C152" forState:UIControlStateNormal];
            break;
            
        case 1:
            [AppDelegate sharedDelegate].selectedAirPlane = @"C172M";
            [selectAirTypeButton setTitle:@"C172M" forState:UIControlStateNormal];
            break;
        case 2:
            [AppDelegate sharedDelegate].selectedAirPlane = @"C172SP";
            [selectAirTypeButton setTitle:@"C172SP" forState:UIControlStateNormal];
            break;
        case 3:
            [AppDelegate sharedDelegate].selectedAirPlane = @"SR22";
            [selectAirTypeButton setTitle:@"SR22" forState:UIControlStateNormal];
            break;
            
        default:
            [AppDelegate sharedDelegate].selectedAirPlane = @"C152";
            [selectAirTypeButton setTitle:@"C152" forState:UIControlStateNormal];
            break;
    }
    
    selectedAirIndex = row;
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    [airplaneList setFrame:CGRectMake(0, self.view.frame.size.height, airplaneList.frame.size.width, airplaneList.frame.size.height)];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView commitAnimations];
    
}
@end
