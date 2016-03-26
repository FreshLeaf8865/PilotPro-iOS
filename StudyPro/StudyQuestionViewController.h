//
//  StudyQuestionViewController.h
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyCategoryTableViewCell.h"
#import "StudyQuizTableViewCell.h"
#import "SQLiteDatabase/SQLiteDatabase.h"
#import "QuestionData.h"

@interface StudyQuestionViewController : UIViewController{
    
    UIImageView     *categoryImageView;
    UIView          *questionImageUIView;
    UITextView      *questionView;
    UITextView      *answerView;
    UILabel         *questionTitle;
    UIButton        *questionImageButton;
    UIButton        *markedButton;
    UIButton        *unmarkedButton;
    QuestionData    *selectedQuestion;
    UITableView     *quizTitleTableView;
    
    UIImageView     *backgroundImage;
    UILabel         *studyTitle;
    UIButton        *backButton;
    UIButton        *dropDownButton;
    UIView          *studyAreaView;
    
    NSInteger       currentQuestionIndex;
    
}

@property   (nonatomic, retain) IBOutlet    UIImageView     *categoryImageView;
@property   (nonatomic, retain) IBOutlet    UITextView      *questionView;
@property   (nonatomic, retain) IBOutlet    UITextView      *answerView;
@property   (nonatomic, retain) IBOutlet    UILabel         *questionTitle;
@property   (nonatomic, retain) IBOutlet    UITableView     *quizTitleTableView;
@property   (nonatomic, retain) IBOutlet    UIView          *questionImageUIView;
@property   (nonatomic, retain) IBOutlet    UIButton        *questionImageButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *markedButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *unmarkedButton;

@property   (nonatomic, retain) IBOutlet    UIImageView     *backgroundImage;
@property   (nonatomic, retain) IBOutlet    UILabel         *studyTitle;
@property   (nonatomic, retain) IBOutlet    UIButton        *backButton;
@property   (nonatomic, retain) IBOutlet    UIButton        *dropDownButton;
@property   (nonatomic, retain) IBOutlet    UIView          *studyAreaView;

-(IBAction)menuButtonClicked:(id)sender;
-(IBAction)backButtonClicked:(id)sender;
-(IBAction)markedQuestionButtonClicked:(id)sender;
-(IBAction)unmarkedQuestionButtonClicked:(id)sender;
-(IBAction)backQuestionButtonClicked:(id)sender;
-(IBAction)nextQuestionButtonClicked:(id)sender;
-(IBAction)quesitonImageButtonClicked:(id)sender;

@end
