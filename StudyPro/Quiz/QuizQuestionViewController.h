//
//  QuizQuestionViewController.h
//  StudyPro
//
//  Created by BluesharkUpwork on 23/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizCategoryTableViewCell.h"
#import "StudyQuizTableViewCell.h"
#import "QuestionData.h"
#import "SQLiteDatabase.h"

@interface QuizQuestionViewController : UIViewController{
    
    UIImageView     *categoryImageView;
    UITextView      *questionView;
    
    UITextView      *answerView1;
    UITextView      *answerView2;
    UITextView      *answerView3;
    UITextView      *answerView4;
    
    UIButton        *firstAnswerButton;
    UIButton        *secondAnswerButton;
    UIButton        *thirdAnswerButton;
    UIButton        *fourAnswerButton;
    UIButton        *QuizTestButton;
    
    UIButton        *markedButton;
    UIButton        *unmarkedButton;
    
    UILabel         *questionTitle;
    QuestionData    *selectedQuestion;
    UITableView     *quizTitleTableView;
    
    NSInteger       currentQuestionIndex;
    NSInteger       testType;
    NSInteger       gradeStatus;
    
    UIImageView     *backgroundImage;
    UILabel         *quizTitle;
    UIButton        *backButton;
    UIButton        *dropDownButton;
    UIView          *quizAreaView;
    
}

@property   (nonatomic, retain) IBOutlet    UIImageView     *categoryImageView;
@property   (nonatomic, retain) IBOutlet    UITextView      *questionView;
@property   (nonatomic, retain) IBOutlet    UITextView      *answerView1;
@property   (nonatomic, retain) IBOutlet    UITextView      *answerView2;
@property   (nonatomic, retain) IBOutlet    UITextView      *answerView3;
@property   (nonatomic, retain) IBOutlet    UITextView      *answerView4;
@property   (nonatomic, retain) IBOutlet    UIButton        *firstAnswerButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *secondAnswerButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *thirdAnswerButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *fourAnswerButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *QuizTestButton;
@property   (nonatomic, retain) IBOutlet    UILabel         *questionTitle;
@property   (nonatomic, retain) IBOutlet    UITableView     *quizTitleTableView;
@property   (nonatomic, retain) IBOutlet    UIButton        *markedButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *unmarkedButton;

@property   (nonatomic, retain) IBOutlet    UIImageView     *backgroundImage;
@property   (nonatomic, retain) IBOutlet    UILabel         *quizTitle;
@property   (nonatomic, retain) IBOutlet    UIButton        *backButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *dropDownButton;
@property   (nonatomic, retain) IBOutlet    UIView          *quizAreaView;

@property   (nonatomic, assign) NSInteger                   testType;

-(IBAction)menuButtonClicked:(id)sender;
-(IBAction)backButtonClicked:(id)sender;
-(IBAction)markedQuestionButtonClicked:(id)sender;
-(IBAction)backQuestionButtonClicked:(id)sender;
-(IBAction)nextQuestionButtonClicked:(id)sender;
-(IBAction)onOptionClickeed:(id)sender;
-(IBAction)gradeQuizClicked:(id)sender;
-(IBAction)unmarkedQuestionButtonClicked:(id)sender;

@end