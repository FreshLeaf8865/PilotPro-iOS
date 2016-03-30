//
//  ViewController.h
//  StudyPro
//
//  Created by BluesharkUpwork on 22/09/15.
//  Copyright (c) 2015 BluesharkUpwork. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
    
    UIPickerView        *airplaneList;
    UIButton            *selectAirTypeButton;
    NSInteger           selectedAirIndex;
}

@property (nonatomic, retain) IBOutlet UIPickerView        *airplaneList;
@property (nonatomic, retain) IBOutlet UIButton            *selectAirTypeButton;
@property (nonatomic, retain) NSString       *selectedAirPlane;


- (IBAction)ClickedSelectCommonButton:(id)sender;
- (IBAction)clickedTestAllButton:(id)sender;
- (IBAction)ClickedSelectAirPlane:(id)sender;
@end

