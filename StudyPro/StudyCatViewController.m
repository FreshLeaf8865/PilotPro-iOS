//
//  StudyCatViewController.m
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudyCatViewController.h"
#import "StudyQuestionViewController.h"
#import "CategoryData.h"
#import "QuestionData.h"
#import "AppDelegate.h"

@interface StudyCatViewController()

@end

@implementation StudyCatViewController
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[AppDelegate sharedDelegate].categoryArray count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CategoryCellIdentifier = @"categoryCell";
    
    StudyCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellIdentifier];
    if (cell == nil) {
        cell = [[StudyCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryCellIdentifier];
    }

    CategoryData *newData;
    newData = [[AppDelegate sharedDelegate].categoryArray objectAtIndex:indexPath.row];
    
    [cell.categoryImage setImage:[UIImage imageNamed:newData.category_image]];
    [cell.categoryTitle setText:newData.category_name];
    [cell.categoryQuestionCount setText:[NSString stringWithFormat:@"Total Questions: %d", (int)newData.category_totalcount]];
    [cell.categoryMarkedCount setText:[NSString stringWithFormat:@"Marked Questions: %d", (int)newData.category_markedcount]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *getQuestionCountQuery;
    CategoryData *selectedData = [[AppDelegate sharedDelegate].categoryArray objectAtIndex:indexPath.row];
    
    if([selectedData.category_name isEqualToString:@"Airplane Systems"]){
        
        getQuestionCountQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_questions where category_id = %d AND airplane_type = '%@' OR category_id = %d AND airplane_type = 'Normal'", (int)selectedData.category_id, [AppDelegate sharedDelegate].selectedAirPlane, (int)selectedData.category_id];
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
                                                  newQuestionData.question_marked = [NSString stringWithFormat:@"%@", [row objectForColumnName:@"question_marked"]].integerValue;
                                                  
                                                  [[AppDelegate sharedDelegate].questionStudyArray addObject:newQuestionData];
                                                }
                                              
                                              if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
                                                  
                                                  UIStoryboard  *mainiPhoneStory = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
                                                  StudyQuestionViewController   *quesitonDetailViewController = [mainiPhoneStory instantiateViewControllerWithIdentifier:@"StudyQuestionViewController"];
                                                  
                                                  [self.navigationController pushViewController:quesitonDetailViewController animated:YES];
                                              }else{
                                                  
                                                  UIStoryboard  *mainiPhoneStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                                  StudyQuestionViewController   *quesitonDetailViewController = [mainiPhoneStory instantiateViewControllerWithIdentifier:@"StudyQuestionViewController"];
                                                  
                                                  [self.navigationController pushViewController:quesitonDetailViewController animated:YES];
                                              }

                                              
                                          }
                                          failure:^(NSString *errorMessage) {
                                              NSLog(@"Query failed with error - %@",errorMessage);
                                          }];
    
}


@end