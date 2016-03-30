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
#import "StudyCatViewController.h"

@interface ViewController ()
{
    //PickerData Array
    NSArray *_pickerData;
}

@end

@implementation ViewController
@synthesize airplaneList, selectAirTypeButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Picker Data
    _pickerData = @[@"C152", @"C172M", @"C172SP", @"SR22"];
    
    
    NSString *query = @"SELECT * FROM tbl_category";
    __block NSString *getQuestionCountQuery;
    
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
                                                  
                                                  if([newData.category_name isEqualToString:@"Airplane Systems"]){
                                                      
                                                     getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d AND airplane_type = '%@' OR category_id = %d AND airplane_type = 'Normal'", (int)newData.category_id, [AppDelegate sharedDelegate].selectedAirPlane, (int)newData.category_id];
                                                  
                                                  }
                                                  else{
                                                      
                                                      getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d", (int)newData.category_id];

                                                  }
                                                  
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
    
    //Set the PickerView position as bottom of the screen at launch the app for iPad Pro
    [airplaneList setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, airplaneList.frame.size.height)];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)resaveCategoryCount {
    
    //Refresh the Total Question counts of the Airplane Systems
    NSString *query = @"SELECT * FROM tbl_category";
    __block NSString *getQuestionCountQuery;
    
    [[SQLiteDatabase sharedInstance] executeQuery:query
                                       withParams:nil
                                          success:^(SQLiteResult *result) {
                                              NSLog(@"Result count %d",(int)result.count);
                                              
                                              for(SQLiteRow *row in result) {
                                                  
                                                  CategoryData *newData = [[CategoryData alloc] init];
                                                  NSString *cateID = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"category_id"]];
                                                  newData.category_id = cateID.intValue;
                                                  newData.category_name = (NSString *)[row objectForColumnName:@"category_name"];
                                                  NSLog(@"Category_Name is %@", newData.category_name);
                                                  newData.category_image = (NSString *)[row objectForColumnName:@"category_imagename"];
                                                  newData.category_bestscore = (NSString *)[row objectForColumnName:@"category_bestscore"];
                                                  
                                                  if([newData.category_name isEqualToString:@"Airplane Systems"]){
                                                      
                                                      getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d AND airplane_type = '%@' OR category_id = %d AND airplane_type = 'Normal'", (int)newData.category_id, [AppDelegate sharedDelegate].selectedAirPlane, (int)newData.category_id];
                                                      
                                                  }
                                                  else{
                                                      
                                                      getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d", (int)newData.category_id];
                                                      
                                                  }
                                                  
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
}



- (IBAction)clickedTestAllButton:(id)sender{
    
    if([[AppDelegate sharedDelegate].selectedAirPlane isEqualToString:@""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Please select Airplane Type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert setDelegate:self];
        [alert show];
        
    }else{
        
        NSString *getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where airplane_type = '%@' OR airplane_type = 'Normal' ORDER BY Random() LIMIT 60",[AppDelegate sharedDelegate].selectedAirPlane];
        
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
    
    return _pickerData.count;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return _pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [AppDelegate sharedDelegate].selectedAirPlane = _pickerData[row];
    [selectAirTypeButton setTitle:_pickerData[row] forState:UIControlStateNormal];
    NSLog(@"Selected AirPlane is %@", [AppDelegate sharedDelegate].selectedAirPlane);
    
    selectedAirIndex = row;
    
    //Resave the selected Airplane System
    [self resaveCategoryCount];

    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    [airplaneList setFrame:CGRectMake(0, self.view.frame.size.height, airplaneList.frame.size.width, airplaneList.frame.size.height)];
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView commitAnimations];
}
@end
