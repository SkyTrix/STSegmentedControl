//
//  STSegmentedControlDemoViewController.h
//  STSegmentedControlDemo
//
//  Created by Cedric Vandendriessche on 01/07/11.
//  Copyright 2011 FreshCreations. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STSegmentedControl;

@interface STSegmentedControlDemoViewController : UIViewController {
    STSegmentedControl *segment;
	UISegmentedControl *standardSegment;
}

@property (nonatomic, retain) STSegmentedControl *segment;
@property (nonatomic, retain) UISegmentedControl *standardSegment;

@end
