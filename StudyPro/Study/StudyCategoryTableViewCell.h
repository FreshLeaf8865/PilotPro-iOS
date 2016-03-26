//
//  SPCategoryTableViewCell.h
//  StudyPro
//
//  Created by lion on 3/26/15.
//  Copyright (c) 2015 lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyCategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (weak, nonatomic) IBOutlet UILabel *categoryQuestionCount;
@property (weak, nonatomic) IBOutlet UILabel *categoryMarkedCount;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;

@end
