//
//  CategoryData.h
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CategoryData :NSObject

@property (nonatomic, assign) NSInteger     category_id;
@property (nonatomic, assign) NSInteger     category_totalcount;
@property (nonatomic, assign) NSInteger     category_markedcount;
@property (nonatomic, retain) NSString      *category_name;
@property (nonatomic, retain) NSString      *category_image;
@property (nonatomic, retain) NSString      *category_bestscore;

@end