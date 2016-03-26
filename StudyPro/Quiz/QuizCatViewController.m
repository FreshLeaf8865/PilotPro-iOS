//
//  QuizCatViewController.m
//  StudyPro
//
//  Created by BluesharkUpwork on 23/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "QuizCatViewController.h"
#import "QuizQuestionViewController.h"
#import "CategoryData.h"
#import "QuestionData.h"
#import "AppDelegate.h"

@interface QuizCatViewController()

@end

@implementation QuizCatViewController
@synthesize categoryTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    [UIView setAnimationsEnabled:YES];
    
    [categoryTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)resetScoreButtonClicked:(id)sender{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Will you clear all scores?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    [alert setDelegate:self];
    [alert show];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[AppDelegate sharedDelegate].categoryArray count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CategoryCellIdentifier = @"quizCategoryCell";
    
    QuizCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellIdentifier];
    if (cell == nil) {
        cell = [[QuizCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryCellIdentifier];
    }
    
    CategoryData *newData;
    newData = [[AppDelegate sharedDelegate].categoryArray objectAtIndex:indexPath.row];
    
    [cell.categoryImage setImage:[UIImage imageNamed:newData.category_image]];
    [cell.categoryTitle setText:newData.category_name];
    [cell.categoryQuestionCount setText:[NSString stringWithFormat:@"Total Questions: %d", (int)newData.category_totalcount]];
    
    if([newData.category_bestscore isEqualToString:@"null"]){
        newData.category_bestscore = @"0.0";
    }
    if(newData.category_bestscore == nil){
        newData.category_bestscore = @"0.0";
    }
    [cell.categoryBestScore setText:[NSString stringWithFormat:@"%@", newData.category_bestscore]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *getQuestionCountQuery;
    CategoryData *selectedData = [[AppDelegate sharedDelegate].categoryArray objectAtIndex:indexPath.row];

    if([selectedData.category_name isEqualToString:@"Airplane Systems"]){
        
        getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d AND airplane_type = '%@' OR category_id = %d AND airplane_type = 'NONE'", (int)selectedData.category_id, [AppDelegate sharedDelegate].selectedAirPlane, (int)selectedData.category_id];
    }else{
        getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d", (int)selectedData.category_id];
    }
    
    if([[AppDelegate sharedDelegate].questionStudyArray count] > 0)
        [[AppDelegate sharedDelegate].questionStudyArray removeAllObjects];
    
    [[SQLiteDatabase sharedInstance] executeQuery:getQuestionCountQuery
                                       withParams:nil
                                          success:^(SQLiteResult *result) {
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
                                                  
                                                  [self.navigationController pushViewController:quesitonDetailViewController animated:YES];

                                              }else{
                                                  
                                                  UIStoryboard  *mainiPhoneStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                  QuizQuestionViewController   *quesitonDetailViewController = [mainiPhoneStory instantiateViewControllerWithIdentifier:@"QuizQuestionViewController"];
                                                  
                                                  [self.navigationController pushViewController:quesitonDetailViewController animated:YES];
                                              }
                                              
                                          }
                                          failure:^(NSString *errorMessage) {
                                              NSLog(@"Query failed with error - %@",errorMessage);
                                          }];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        NSString    *updateQuery = @"UPDATE tbl_category SET category_bestscore = '0.0' ";
        
        [[SQLiteDatabase sharedInstance] executeQuery:updateQuery
                                           withParams:nil
                                              success:^(SQLiteResult *result) {
                                                  NSLog(@"success");
                                                  
                                              }
                                              failure:^(NSString *errorMessage) {
                                                  NSLog(@"Update Query failed with error - %@",errorMessage);
                                              }];
        
        for(int i = 0; i < [[AppDelegate sharedDelegate].categoryArray count]; i++){
            CategoryData    *newData = [[AppDelegate sharedDelegate].categoryArray objectAtIndex:i];
            newData.category_bestscore = @"0.0";
            [[AppDelegate sharedDelegate].categoryArray replaceObjectAtIndex:i withObject:newData];
        }
        
        [categoryTableView reloadData];
    }
}
@end
