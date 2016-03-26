//
//  QuizQuestionViewController.m
//  StudyPro
//
//  Created by BluesharkUpwork on 23/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuizQuestionViewController.h"
#import "CategoryData.h"
#import "QuestionData.h"
#import "AppDelegate.h"

@interface QuizQuestionViewController()

@end

@implementation QuizQuestionViewController
@synthesize categoryImageView, questionView, answerView1, answerView2, answerView3, answerView4, questionTitle, quizTitleTableView;
@synthesize firstAnswerButton, secondAnswerButton, thirdAnswerButton, fourAnswerButton, QuizTestButton, testType, markedButton, unmarkedButton;
@synthesize backButton, backgroundImage, quizTitle, dropDownButton, quizAreaView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    currentQuestionIndex = 0;
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
    [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    selectedQuestion = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:currentQuestionIndex];
    [questionTitle setText:selectedQuestion.quiz_title];
    [questionView setText:selectedQuestion.quiz_text];
    [answerView1 setText:selectedQuestion.answer1];
    [answerView2 setText:selectedQuestion.answer2];
    [answerView3 setText:selectedQuestion.answer3];
    [answerView4 setText:selectedQuestion.answer4];
    
    if(selectedQuestion.question_marked == 1){
        [categoryImageView setBackgroundColor:[UIColor colorWithRed:242/255.0f green:230/255.0f blue:54/255.0f alpha:1.0f]];
    }else{
        if(selectedQuestion.quiz_status == 1){
            [categoryImageView setBackgroundColor:[UIColor colorWithRed:57/255.0f green:141/255.0f blue:61/255.0f alpha:1.0f]];
        }else{
            [categoryImageView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:31/255.0f blue:39/255.0f alpha:1.0f]];
        }
        
    }
    
    if(testType == 1){
        [QuizTestButton setTitle:@"Grade Test" forState:UIControlStateNormal];
    }
    
    if(selectedQuestion.question_marked == 1){
        unmarkedButton.hidden = NO;
        markedButton.hidden = YES;
    }else{
        unmarkedButton.hidden = YES;
        markedButton.hidden = NO;
    }
    
    gradeStatus = 0;
    [quizAreaView setHidden:YES];
    
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
    
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
    [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    StudyQuizTableViewCell *cell = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath];
    UIView  *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
    cell.selectedBackgroundView = customColorView;
    [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
    
    if(quizAreaView.hidden == YES){
        
        [self.backgroundImage setImage:[UIImage imageNamed:@""]];
        [backButton setBackgroundImage:[UIImage imageNamed:@"iPhone_BackBlackArrow"] forState:UIControlStateNormal];
        [dropDownButton setBackgroundImage:[UIImage imageNamed:@"iPhone_menu"] forState:UIControlStateNormal];
        [quizTitle setTextColor:[UIColor blackColor]];
        [questionTitle setTextColor:[UIColor blackColor]];
        [quizAreaView  setHidden:NO];
        
    }else{
        
        [self.backgroundImage setImage:[UIImage imageNamed:@"back"]];
        [backButton setBackgroundImage:[UIImage imageNamed:@"iPhone_BackArrow"] forState:UIControlStateNormal];
        [dropDownButton setBackgroundImage:[UIImage imageNamed:@"iPhone_white_menu"] forState:UIControlStateNormal];
        [quizTitle setTextColor:[UIColor whiteColor]];
        [questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
        [quizAreaView  setHidden:YES];
    }
}

-(IBAction)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onOptionClickeed:(id)sender{
    UIButton *clickedButton = (UIButton *) sender;
    

    if(gradeStatus == 1){
        return;
    }
    [self clearAnswerButtonColor];
    
    selectedQuestion.selected_answer = clickedButton.tag;
    selectedQuestion.quiz_status = 1;
    [clickedButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
    [[AppDelegate sharedDelegate].questionStudyArray replaceObjectAtIndex:currentQuestionIndex withObject:selectedQuestion];
    
    if(selectedQuestion.question_marked == 1){
        [categoryImageView setBackgroundColor:[UIColor colorWithRed:242/255.0f green:230/255.0f blue:54/255.0f alpha:1.0f]];
    }else{
        if(selectedQuestion.quiz_status == 1){
            [categoryImageView setBackgroundColor:[UIColor colorWithRed:57/255.0f green:141/255.0f blue:61/255.0f alpha:1.0f]];
        }else{
            [categoryImageView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:31/255.0f blue:39/255.0f alpha:1.0f]];
        }
        
    }
    
     [quizTitleTableView reloadData];
}

-(IBAction)gradeQuizClicked:(id)sender{
    
    QuestionData    *newData;
    NSInteger           bestScore;
    NSInteger        questionCount;
    NSString        *bestScoreString;
    
    NSInteger correctedAnswerCount = 0;
    for(int i = 0; i < [[AppDelegate sharedDelegate].questionStudyArray count]; i++){
        newData = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:i];
        
        if(newData.correct_answer == newData.selected_answer)
        {
            correctedAnswerCount++;
        }
        
        [[AppDelegate sharedDelegate].questionStudyArray replaceObjectAtIndex:i withObject:newData];
    }
    
    questionCount = [[AppDelegate sharedDelegate].questionStudyArray count];
    bestScore = (NSInteger) (correctedAnswerCount* 100/questionCount );
    bestScoreString = [NSString stringWithFormat:@"%d", (int)bestScore];
    
    if(testType != 1){
        NSString *getBestScoreQuery = [NSString stringWithFormat:@" SELECT * FROM tbl_category where category_id = %d", (int)selectedQuestion.category_id];
        
        [[SQLiteDatabase sharedInstance] executeQuery:getBestScoreQuery
                                           withParams:nil
                                              success:^(SQLiteResult *result) {
                                                  NSLog(@" Query = %@ Result count %d",getBestScoreQuery, (int)result.count);
                                                  
                                                  for(SQLiteRow *row in result) {
                                                      NSString    *lastscore  = (NSString *)[row objectForColumnName:@"category_bestscore"];
                                                      
                                                      if(lastscore.intValue < bestScoreString.intValue){
                                                          NSString    *updateQuery =[NSString stringWithFormat:@"UPDATE tbl_category SET category_bestscore = %@ WHERE category_id=%d", bestScoreString, (int)selectedQuestion.category_id];
                                                          
                                                          [[SQLiteDatabase sharedInstance] executeQuery:updateQuery
                                                                                             withParams:nil
                                                                                                success:^(SQLiteResult *result) {
                                                                                                    NSLog(@"success");
                                                                                                    [self updateCategoryTable];
                                                                                                }
                                                                                                failure:^(NSString *errorMessage) {
                                                                                                    NSLog(@"Update Query failed with error - %@",errorMessage);
                                                                                                }];
                                                          
                                                          
                                                      }
                                                  }
                                                  
                                              }
                                              failure:^(NSString *errorMessage) {
                                                  NSLog(@"Query failed with error - %@",errorMessage);
                                              }];

    }
    
    gradeStatus = 1;
    
    switch (selectedQuestion.correct_answer) {
        case 1:
            
            if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
            }else{
                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                switch (selectedQuestion.selected_answer) {
                    case 1:
                        
                        [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 2:
                        [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 3:
                        [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 4:
                        [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    default:
                        break;
                }
            }
            
            break;
            
        case 2:
            
            
            if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
            }else{
                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                switch (selectedQuestion.selected_answer) {
                    case 1:
                        
                        [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 2:
                        [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 3:
                        [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 4:
                        [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    default:
                        break;
                }
            }
            
            break;
        case 3:
            
            
            if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
            }else{
                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                switch (selectedQuestion.selected_answer) {
                    case 1:
                        
                        [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 2:
                        [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 3:
                        [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 4:
                        [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    default:
                        break;
                }
            }
            
            break;
        case 4:
            
            
            if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
            }else{
                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                switch (selectedQuestion.selected_answer) {
                    case 1:
                        
                        [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 2:
                        [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 3:
                        [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    case 4:
                        [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                        break;
                    default:
                        break;
                }
            }
            
            break;
            
        default:
            break;
    }

    [quizTitleTableView reloadData];
    
    NSString    *message = [NSString stringWithFormat:@"Your Score is %@", bestScoreString];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Quiz Score!" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
-(IBAction)backQuestionButtonClicked:(id)sender{
    if(currentQuestionIndex > 0){
        currentQuestionIndex--;
        selectedQuestion = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:currentQuestionIndex];
        
        [self clearAnswerButtonColor];

        NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
        NSIndexPath *scrollIndexPath2 = [NSIndexPath indexPathForRow:currentQuestionIndex + 1 inSection:0];
        
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath1 animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell1 = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath1];
        UIView  *customColorView1 = [[UIView alloc] init];
        customColorView1.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
        cell1.selectedBackgroundView = customColorView1;
        [cell1.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
        
        
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath2 animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell2 = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath2];
        UIView  *customColorView2 = [[UIView alloc] init];
        customColorView2.backgroundColor = [UIColor whiteColor];
        cell2.selectedBackgroundView = customColorView2;
        [cell2.questionTitle setTextColor:[UIColor blackColor]];
        
        
        [questionTitle setText:selectedQuestion.quiz_title];
        [questionView setText:selectedQuestion.quiz_text];
        [answerView1 setText:selectedQuestion.answer1];
        [answerView2 setText:selectedQuestion.answer2];
        [answerView3 setText:selectedQuestion.answer3];
        [answerView4 setText:selectedQuestion.answer4];
        
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        if(gradeStatus == 1) {
            
            switch (selectedQuestion.correct_answer) {
                case 1:
                    
                    if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                       [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    }else{
                        [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                        switch (selectedQuestion.selected_answer) {
                            case 1:
                                
                                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 2:
                                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 3:
                                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 4:
                                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            default:
                                break;
                        }
                    }
                    
                    break;
                    
                case 2:
                    
                    
                    if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                        [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    }else{
                        [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                        switch (selectedQuestion.selected_answer) {
                            case 1:
                                
                                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 2:
                                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 3:
                                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 4:
                                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            default:
                                break;
                        }
                    }
                    
                    break;
                case 3:
                    
                    
                    if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                        [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    }else{
                         [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                        switch (selectedQuestion.selected_answer) {
                            case 1:
                                
                                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 2:
                                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 3:
                                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 4:
                                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            default:
                                break;
                        }
                    }
                    
                    break;
                case 4:
                    
                    
                    if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                        [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    }else{
                        [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                        switch (selectedQuestion.selected_answer) {
                            case 1:
                                
                                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 2:
                                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 3:
                                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 4:
                                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            default:
                                break;
                        }
                    }
                    
                    break;
                    
                default:
                    break;
            }
            
        }else{
            
            switch (selectedQuestion.selected_answer) {
                case 1:
                    
                    [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                    break;
                case 2:
                    [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                    break;
                case 3:
                    [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                    break;
                case 4:
                    [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                    break;
                default:
                    break;
            }
            
            if(selectedQuestion.question_marked == 1){
                [categoryImageView setBackgroundColor:[UIColor colorWithRed:242/255.0f green:230/255.0f blue:54/255.0f alpha:1.0f]];
            }else{
                if(selectedQuestion.quiz_status == 1){
                    [categoryImageView setBackgroundColor:[UIColor colorWithRed:57/255.0f green:141/255.0f blue:61/255.0f alpha:1.0f]];
                }else{
                    [categoryImageView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:31/255.0f blue:39/255.0f alpha:1.0f]];
                }
                
            }
        }
        
        
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
        
        [self clearAnswerButtonColor];
        
        
        [questionTitle setText:selectedQuestion.quiz_title];
        [questionView setText:selectedQuestion.quiz_text];
        [answerView1 setText:selectedQuestion.answer1];
        [answerView2 setText:selectedQuestion.answer2];
        [answerView3 setText:selectedQuestion.answer3];
        [answerView4 setText:selectedQuestion.answer4];
        
        NSIndexPath *scrollIndexPath1 = [NSIndexPath indexPathForRow:currentQuestionIndex inSection:0];
        NSIndexPath *scrollIndexPath2 = [NSIndexPath indexPathForRow:currentQuestionIndex - 1 inSection:0];
        
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath1 animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath1]; // By Eberhard
        UIView  *customColorView = [[UIView alloc] init];
        customColorView.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
        cell.selectedBackgroundView = customColorView;
        [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
        
        [[self quizTitleTableView] selectRowAtIndexPath:scrollIndexPath2 animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        StudyQuizTableViewCell *cell2 = (StudyQuizTableViewCell *) [[self quizTitleTableView] cellForRowAtIndexPath:scrollIndexPath2];
        UIView  *customColorView2 = [[UIView alloc] init];
        customColorView2.backgroundColor = [UIColor whiteColor];
        cell2.selectedBackgroundView = customColorView2;
        [cell2.questionTitle setTextColor:[UIColor blackColor]];
        
        if(gradeStatus == 1) {
            
            switch (selectedQuestion.correct_answer) {
                case 1:
                    
                    if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                        [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    }else{
                        [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                        switch (selectedQuestion.selected_answer) {
                            case 1:
                                
                                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 2:
                                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 3:
                                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 4:
                                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            default:
                                break;
                        }
                    }
                    
                    break;
                    
                case 2:
                    
                    
                    if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                        [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    }else{
                        [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                        switch (selectedQuestion.selected_answer) {
                            case 1:
                                
                                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 2:
                                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 3:
                                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 4:
                                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            default:
                                break;
                        }
                    }
                    
                    break;
                case 3:
                    
                    
                    if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                        [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    }else{
                        [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                        switch (selectedQuestion.selected_answer) {
                            case 1:
                                
                                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 2:
                                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 3:
                                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 4:
                                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            default:
                                break;
                        }
                    }
                    
                    break;
                case 4:
                    
                    
                    if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                        [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    }else{
                        [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                        switch (selectedQuestion.selected_answer) {
                            case 1:
                                
                                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 2:
                                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 3:
                                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            case 4:
                                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                                break;
                            default:
                                break;
                        }
                    }
                    
                    break;
                    
                default:
                    break;
            }
            
        }else{
            
            switch (selectedQuestion.selected_answer) {
                case 1:
                    
                    [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                    break;
                case 2:
                    [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                    break;
                case 3:
                    [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                    break;
                case 4:
                    [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                    break;
                default:
                    break;
            }
            
            if(selectedQuestion.question_marked == 1){
                [categoryImageView setBackgroundColor:[UIColor colorWithRed:242/255.0f green:230/255.0f blue:54/255.0f alpha:1.0f]];
            }else{
                if(selectedQuestion.quiz_status == 1){
                    [categoryImageView setBackgroundColor:[UIColor colorWithRed:57/255.0f green:141/255.0f blue:61/255.0f alpha:1.0f]];
                }else{
                    [categoryImageView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:31/255.0f blue:39/255.0f alpha:1.0f]];
                }
                
            }
        }

        
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

- (void) clearAnswerButtonColor{
    [firstAnswerButton setBackgroundColor:[UIColor clearColor]];
    [secondAnswerButton setBackgroundColor:[UIColor clearColor]];
    [thirdAnswerButton setBackgroundColor:[UIColor clearColor]];
    [fourAnswerButton setBackgroundColor:[UIColor clearColor]];
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
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[AppDelegate sharedDelegate].questionStudyArray count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CategoryCellIdentifier = @"quizTitleCell";
    
    StudyQuizTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellIdentifier];
    if (cell == nil) {
        cell = [[StudyQuizTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CategoryCellIdentifier];
    }
    
    QuestionData *newData;
    newData = [[AppDelegate sharedDelegate].questionStudyArray objectAtIndex:indexPath.row];
    
    if(gradeStatus == 1){
        
        if(newData.selected_answer == newData.correct_answer){
            [cell.markStatusImage setImage:[UIImage imageNamed:@"green_dot"]];
        }else{
            [cell.markStatusImage setImage:[UIImage imageNamed:@"red_dot"]];
        }
        
    }else{
        if(newData.question_marked == 1){
            [cell.markStatusImage setImage:[UIImage imageNamed:@"yellow_dot"]];
        }else{
            
            if(newData.quiz_status > 0)
                [cell.markStatusImage setImage:[UIImage imageNamed:@"green_dot"]];
            else
                [cell.markStatusImage setImage:[UIImage imageNamed:@"red_dot"]];
        }
    }
    
    UIView  *customColorView = [[UIView alloc] init];
    
    customColorView.backgroundColor = [UIColor colorWithRed:40.0f/255 green:56.0f/255 blue:115.0f/255 alpha:1.0f];
    cell.selectedBackgroundView = customColorView;
    
    if(currentQuestionIndex == indexPath.row){
        [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
    }else{
        [cell.questionTitle setTextColor:[UIColor blackColor]];
    }
    
    [cell.questionTitle setText:newData.quiz_title];
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
    
    [self clearAnswerButtonColor];
    
    [questionTitle setText:selectedQuestion.quiz_title];
    [questionView setText:selectedQuestion.quiz_text];
    [answerView1 setText:selectedQuestion.answer1];
    [answerView2 setText:selectedQuestion.answer2];
    [answerView3 setText:selectedQuestion.answer3];
    [answerView4 setText:selectedQuestion.answer4];
    
    StudyQuizTableViewCell *cell = (StudyQuizTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    [cell.questionTitle setTextColor:[UIColor colorWithRed:219.0f/255 green:195.0f/255 blue:30.0f/255 alpha:1.0f]];
    
    if(gradeStatus == 1) {
        
        switch (selectedQuestion.correct_answer) {
            case 1:
                
                if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                    [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                }else{
                    [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    switch (selectedQuestion.selected_answer) {
                        case 1:
                            
                            [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 2:
                            [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 3:
                            [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 4:
                            [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        default:
                            break;
                    }
                }
                
                break;
                
            case 2:
                
                
                if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                    [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                }else{
                    [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    switch (selectedQuestion.selected_answer) {
                        case 1:
                            
                            [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 2:
                            [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 3:
                            [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 4:
                            [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        default:
                            break;
                    }
                }
                
                break;
            case 3:
                
                
                if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                    [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                }else{
                    [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    switch (selectedQuestion.selected_answer) {
                        case 1:
                            
                            [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 2:
                            [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 3:
                            [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 4:
                            [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        default:
                            break;
                    }
                }
                
                break;
            case 4:
                
                
                if(selectedQuestion.correct_answer == selectedQuestion.selected_answer){
                    [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                }else{
                    [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:0/255.0f green:255/255.0f blue:0/255.0f alpha:0.5]];
                    switch (selectedQuestion.selected_answer) {
                        case 1:
                            
                            [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 2:
                            [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 3:
                            [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        case 4:
                            [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:0.5]];
                            break;
                        default:
                            break;
                    }
                }
                
                break;
                
            default:
                break;
        }
        
    }else{
        
        switch (selectedQuestion.selected_answer) {
            case 1:
                
                [firstAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                break;
            case 2:
                [secondAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                break;
            case 3:
                [thirdAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                break;
            case 4:
                [fourAnswerButton setBackgroundColor:[UIColor colorWithRed:143/255.0f green:127/255.0f blue:26/255.0f alpha:0.5]];
                break;
            default:
                break;
        }
        
        if(selectedQuestion.question_marked == 1){
            [categoryImageView setBackgroundColor:[UIColor colorWithRed:242/255.0f green:230/255.0f blue:54/255.0f alpha:1.0f]];
        }else{
            if(selectedQuestion.quiz_status == 1){
                [categoryImageView setBackgroundColor:[UIColor colorWithRed:57/255.0f green:141/255.0f blue:61/255.0f alpha:1.0f]];
            }else{
                [categoryImageView setBackgroundColor:[UIColor colorWithRed:216/255.0f green:31/255.0f blue:39/255.0f alpha:1.0f]];
            }
            
        }
    }

    
    if(selectedQuestion.question_marked == 1){
        unmarkedButton.hidden = NO;
        markedButton.hidden = YES;
    }else{
        unmarkedButton.hidden = YES;
        markedButton.hidden = NO;
    }
    

    
}

@end
