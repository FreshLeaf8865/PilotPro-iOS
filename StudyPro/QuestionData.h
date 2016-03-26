//
//  QuestionData.h
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuestionData :NSObject

@property   (nonatomic, assign) NSInteger       question_id;
@property   (nonatomic, retain) NSString        *answer1;
@property   (nonatomic, retain) NSString        *answer2;
@property   (nonatomic, retain) NSString        *answer3;
@property   (nonatomic, retain) NSString        *answer4;
@property   (nonatomic, assign) NSInteger       correct_answer;
@property   (nonatomic, assign) NSInteger       category_id;
@property   (nonatomic, retain) NSString        *quiz_imagename;
@property   (nonatomic, retain) NSString        *quiz_text;
@property   (nonatomic, retain) NSString        *quiz_title;
@property   (nonatomic, retain) NSString        *study_answer;
@property   (nonatomic, assign) NSInteger       question_for_category_id;
@property   (nonatomic, assign) NSInteger       question_marked;
@property   (nonatomic, assign) NSInteger       selected_answer;
@property   (nonatomic, assign) NSInteger       quiz_status;

@property (nonatomic, retain) NSString      *category_image;

@end
