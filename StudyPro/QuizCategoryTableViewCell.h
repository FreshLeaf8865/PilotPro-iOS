//
//  QuizCategoryTableViewCell.h
//  StudyPro
//
//  Created by BluesharkUpwork on 23/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizCategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (weak, nonatomic) IBOutlet UILabel *categoryQuestionCount;
@property (weak, nonatomic) IBOutlet UILabel *categoryBestScore;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;

@end