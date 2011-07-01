//
//  STSegmentedControl.h
//  STSegmentedControl
//
//  Version: 1.0
//
//  Created by Cedric Vandendriessche on 10/11/10.
//  Copyright 2010 FreshCreations. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STSegmentedControlHeight 30.0 // the height of the control. Change this if you're making controls of a different height

enum {
    STSegmentedControlNoSegment = -1 // segment index for no selected segment
};

@interface STSegmentedControl : UIControl {
	NSMutableArray *segments;
	UIImage *normalImageLeft;
	UIImage *normalImageMiddle;
	UIImage *normalImageRight;
	UIImage *selectedImageLeft;
	UIImage *selectedImageMiddle;
	UIImage *selectedImageRight;
	NSUInteger numberOfSegments;
	NSInteger selectedSegmentIndex;
	BOOL programmaticIndexChange;
	BOOL momentary;
}

- (id)initWithItems:(NSArray *)items; // items can be NSStrings or UIImages.

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index; // insert before segment number
- (void)insertSegmentWithImage:(NSString *)image atIndex:(NSUInteger)index;
- (void)removeSegmentAtIndex:(NSUInteger)index;
- (void)removeAllSegments;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index;
- (NSString *)titleForSegmentAtIndex:(NSUInteger)index;

- (void)setImage:(NSString *)image forSegmentAtIndex:(NSUInteger)index;
- (UIImage *)imageForSegmentAtIndex:(NSUInteger)index;

@property (nonatomic, retain) NSMutableArray *segments; // at least two (2) NSStrings are needed for a STSegmentedControl to be displayed
@property (nonatomic, retain) UIImage *normalImageLeft;
@property (nonatomic, retain) UIImage *normalImageMiddle;
@property (nonatomic, retain) UIImage *normalImageRight;
@property (nonatomic, retain) UIImage *selectedImageLeft;
@property (nonatomic, retain) UIImage *selectedImageMiddle;
@property (nonatomic, retain) UIImage *selectedImageRight;
@property (nonatomic, readonly) NSUInteger numberOfSegments;
@property (nonatomic, getter=isMomentary) BOOL momentary; // if set, then we don't keep showing selected state after tracking ends. default is NO

// returns last segment pressed. default is STSegmentedControlNoSegment until a segment is pressed. Becomes STSegmentedControlNoSegment again when altering the amount of segments
// the UIControlEventValueChanged action is invoked when the segment changes via a user event. Set to UISegmentedControlNoSegment to turn off selection
@property (nonatomic, readwrite) NSInteger selectedSegmentIndex;

@end
