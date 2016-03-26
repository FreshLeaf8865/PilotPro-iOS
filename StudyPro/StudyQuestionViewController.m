//
//  StudyQuestionViewController.m
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudyQuestionViewController.h"
#import "CategoryData.h"
#import "QuestionData.h"
#import "AppDelegate.h"

@interface StudyQuestionViewController()

@end

@implementation StudyQuestionViewController
@synthesize categoryImageView, questionView, answerView, questionTitle, quizTitleTableView, questionImageUIView, questionImageButton;
@synthesize markedButton, unmarkedButton, backgroundImage, studyTitle, dropDownButton, backButton, studyAreaView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    currentQuestionIndex = 0;
    selectedQuestion = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:currentQuestionIndex];
    
    [questionTitle setText:selectedQuestion.quiz_title];
    [questionView setText:selectedQuestion.quiz_text];
    [answerView setText:selectedQuestion.study_answer];
    
    if(selectedQuestion.quiz_imagename == nil){
        questionImageButton.hidden = YES;
    }else{
        questionImageButton.hidden = NO;
    }
    
    [categoryImageView setImage:[UIImage imageNamed:selectedQuestion.quiz_imagename]];
    
    [questionImageUIView setHidden:YES];
    
    
    if(selectedQuestion.question_marked == 1){
        unmarkedButton.hidden = NO;
        markedButton.hidden = YES;
    }else{
        unmarkedButton.hidden = YES;
        markedButton.hidden = NO;
    }
    
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
    [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    StudyQuizTableViewCell *cell = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath];
    UIView  *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
    cell.selectedBackgroundView = customColorView;
    [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
    [UIView setAnimationsEnabled:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)menuButtonClicked:(id)sender{
    
    if(quizTitleTableView.hidden == YES){

        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath];
        UIView  *customColorView = [[UIView alloc] init];
        customColorView.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
        cell.selectedBackgroundView = customColorView;
        [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
        
        [self.backgroundImage setImage:[UIImage imageNamed:@""]];
        [backButton setBackgroundImage:[UIImage imageNamed:@"iPhone_BackBlackArrow"] forState:UIControlStateNormal];
        [dropDownButton setBackgroundImage:[UIImage imageNamed:@"iPhone_menu"] forState:UIControlStateNormal];
        [studyTitle setTextColor:[UIColor blackColor]];
        [self.studyAreaView  setHidden:YES];
        [questionTitle setTextColor:[UIColor blackColor]];
        [quizTitleTableView setHidden:NO];

        
    }else{

        [self.backgroundImage setImage:[UIImage imageNamed:@"back"]];
        [backButton setBackgroundImage:[UIImage imageNamed:@"iPhone_BackArrow"] forState:UIControlStateNormal];
        [dropDownButton setBackgroundImage:[UIImage imageNamed:@"iPhone_white_menu"] forState:UIControlStateNormal];
        [studyTitle setTextColor:[UIColor whiteColor]];
        [self.studyAreaView  setHidden:NO];
        [questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
        [quizTitleTableView setHidden:YES];
        
    }
}

-(IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)backQuestionButtonClicked:(id)sender{
    
    if(currentQuestionIndex > 0){
        
        currentQuestionIndex--;
        selectedQuestion = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:currentQuestionIndex];
        
        NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
        NSIndexPath *scrollIndexPath2 = [NSIndexPath indexPathForRow:currentQuestionIndex + 1 inSection:0];
        
        
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath2 animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell2 = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath2];
        UIView  *customColorView2 = [[UIView alloc] init];
        customColorView2.backgroundColor = [UIColor whiteColor];
        cell2.selectedBackgroundView = customColorView2;
        [cell2.questionTitle setTextColor:[UIColor blackColor]];
        
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath1 animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell1 = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath1];
        UIView  *customColorView1 = [[UIView alloc] init];
        customColorView1.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
        cell1.selectedBackgroundView = customColorView1;
        [cell1.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
        
        [questionTitle setText:selectedQuestion.quiz_title];
        [questionView setText:selectedQuestion.quiz_text];
        [answerView setText:selectedQuestion.study_answer];
        
        if(selectedQuestion.quiz_imagename == nil){
            questionImageButton.hidden = YES;
        }else{
            questionImageButton.hidden = NO;
        }
        
        [categoryImageView setImage:[UIImage imageNamed:selectedQuestion.quiz_imagename]];
        
        [questionImageUIView setHidden:YES];
        
        if(selectedQuestion.question_marked == 1){
            unmarkedButton.hidden = NO;
            markedButton.hidden = YES;
        }else{
            unmarkedButton.hidden = YES;
            markedButton.hidden = NO;
        }
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"This is first question" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(IBAction)nextQuestionButtonClicked:(id)sender{
    
    currentQuestionIndex++;
    
    if(currentQuestionIndex >= [[AppDelegate sharedDelegate].questionStudyArray count]){
        currentQuestionIndex--;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:@"This is final question" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{

        selectedQuestion = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:currentQuestionIndex];
        
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
        NSIndexPath *scrollIndexPath2 = [NSIndexPath indexPathForRow:currentQuestionIndex - 1 inSection:0];
        
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath2 animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell2 = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath2];
        UIView  *customColorView2 = [[UIView alloc] init];
        customColorView2.backgroundColor = [UIColor whiteColor];
        cell2.selectedBackgroundView = customColorView2;
        [cell2.questionTitle setTextColor:[UIColor blackColor]];
        
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath]; // By Eberhard
        UIView  *customColorView = [[UIView alloc] init];
        customColorView.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
        cell.selectedBackgroundView = customColorView;
        [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
        
        [questionTitle setText:selectedQuestion.quiz_title];
        [questionView setText:selectedQuestion.quiz_text];
        [answerView setText:selectedQuestion.study_answer];
        
        if(selectedQuestion.quiz_imagename == nil){
            
            questionImageButton.hidden = YES;
            
        }else{
            
            questionImageButton.hidden = NO;
            
        }
        
        [categoryImageView setImage:[UIImage imageNamed:selectedQuestion.quiz_imagename]];
        
        [questionImageUIView setHidden:YES];
        
        if(selectedQuestion.question_marked == 1){
            unmarkedButton.hidden = NO;
            markedButton.hidden = YES;
        }else{
            unmarkedButton.hidden = YES;
            markedButton.hidden = NO;
        }
        
    }
}

-(IBAction)markedQuestionButtonClicked:(id)sender{

    NSString    *updateQuery =[NSString stringWithFormat:@"UPDATE tbl_questions SET question_marked = 1 WHERE question_id=%d", (int)selectedQuestion.question_id];
    
    [[SQLiteDatabase sharedInstance] executeQuery:updateQuery
                                        withParams:nil
                                           success:^(SQLiteResult *result) {
                                               NSLog(@"success");
                                           }
                                           failure:^(NSString *errorMessage) {
                                               NSLog(@"Update Query failed with error - %@",errorMessage);
                                           }];
    
    
    selectedQuestion.question_marked = 1;
    [[AppDelegate sharedDelegate].questionStudyArray replaceObjectAtIndex:currentQuestionIndex withObject:selectedQuestion];
    [quizTitleTableView reloadData];

    if(selectedQuestion.question_marked == 1){
        unmarkedButton.hidden = NO;
        markedButton.hidden = YES;
    }else{
        unmarkedButton.hidden = YES;
        markedButton.hidden = NO;
    }
    
    [self updateCategoryTable];
    
}

-(IBAction)unmarkedQuestionButtonClicked:(id)sender{
    
    NSString    *updateQuery =[NSString stringWithFormat:@"UPDATE tbl_questions SET question_marked = 0 WHERE question_id=%d", (int)selectedQuestion.question_id];
    
    [[SQLiteDatabase sharedInstance] executeQuery:updateQuery
                                       withParams:nil
                                          success:^(SQLiteResult *result) {
                                              NSLog(@"success");
                                          }
                                          failure:^(NSString *errorMessage) {
                                              NSLog(@"Update Query failed with error - %@",errorMessage);
                                          }];
    
    
    selectedQuestion.question_marked = 0;
    [[AppDelegate sharedDelegate].questionStudyArray replaceObjectAtIndex:currentQuestionIndex withObject:selectedQuestion];
    [quizTitleTableView reloadData];
    
    if(selectedQuestion.question_marked == 1){
        unmarkedButton.hidden = NO;
        markedButton.hidden = YES;
    }else{
        unmarkedButton.hidden = YES;
        markedButton.hidden = NO;
    }
    
    [self updateCategoryTable];
}

-(IBAction)quesitonImageButtonClicked:(id)sender{
    [categoryImageView setImage:[UIImage imageNamed:selectedQuestion.quiz_imagename]];
    if(questionImageUIView.hidden == YES){
        
        [UIView  beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [questionImageUIView setHidden:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:questionImageUIView cache:NO];
        [UIView commitAnimations];
        
    }else{
        
        [UIView  beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [questionImageUIView setHidden:YES];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:questionImageUIView cache:NO];
        [UIView commitAnimations];
        
    }
}

- (void) updateCategoryTable{
    
    NSString *query = @"SELECT * FROM tbl_category";
    
    if([[AppDelegate sharedDelegate].categoryArray count] > 0)
       [[AppDelegate sharedDelegate].categoryArray removeAllObjects];
    
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
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[AppDelegate sharedDelegate].questionStudyArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CategoryCellIdentifier = @"quizTitleCell";
    
    StudyQuizTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellIdentifier];
    if (cell == nil) {
        cell = [[StudyQuizTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryCellIdentifier];
    }
    
    QuestionData *newData;
    newData = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:indexPath.row];
    
    if(newData.question_marked == 1){
        [cell.markStatusImage setImage:[UIImage imageNamed:@"yellow_dot"]];
    }else{
        [cell.markStatusImage setImage:[UIImage imageNamed:@"green_dot"]];
    }
    
    UIView  *customColorView = [[UIView alloc] init];
    
    customColorView.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
    cell.selectedBackgroundView = customColorView;
    
    [cell.questionTitle setText:newData.quiz_title];
    
    if(currentQuestionIndex == indexPath.row){
        
        [[self quizTitleTableView] selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
        
    }else{
        [cell.questionTitle setTextColor:[UIColor blackColor]];
    }
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StudyQuizTableViewCell *cell = (StudyQuizTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    [cell.questionTitle setTextColor:[UIColor blackColor]];
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    currentQuestionIndex = indexPath.row;
    selectedQuestion = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:currentQuestionIndex];
    
    StudyQuizTableViewCell *cell = (StudyQuizTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
    
    [questionTitle setText:selectedQuestion.quiz_title];
    [questionView setText:selectedQuestion.quiz_text];
    [answerView setText:selectedQuestion.study_answer];
    
    if(selectedQuestion.quiz_imagename == nil){
        questionImageButton.hidden = YES;
    }else{
        questionImageButton.hidden = NO;
    }
    
    [categoryImageView setImage:[UIImage imageNamed:selectedQuestion.quiz_imagename]];
    
    [questionImageUIView setHidden:YES];
    
    if(selectedQuestion.question_marked == 1){
        unmarkedButton.hidden = NO;
        markedButton.hidden = YES;
    }else{
        unmarkedButton.hidden = YES;
        markedButton.hidden = NO;
    }

    
}

@end
