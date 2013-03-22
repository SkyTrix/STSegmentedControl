//
//  STSegmentedControl.m
//  STSegmentedControl
//
//  Created by Cedric Vandendriessche on 10/11/10.
//  Copyright 2010 FreshCreations. All rights reserved.
//

#import "STSegmentedControl.h"
#import "STSegmentedControlUI.h"

@interface STSegmentedControl (Private)
- (void)updateUI;
- (void)deselectAllSegments;
- (void)insertSegmentWithObject:(NSObject *)object atIndex:(NSUInteger)index;
- (void)setObject:(NSObject *)object forSegmentAtIndex:(NSUInteger)index;
@end

@implementation STSegmentedControl

@synthesize segments, numberOfSegments, selectedSegmentIndex, momentary;
@synthesize normalImageLeft, normalImageMiddle, normalImageRight, selectedImageLeft, selectedImageMiddle, selectedImageRight;

#pragma mark -
#pragma mark Initializer

- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kSTSegmentHeight)])) {
		self.backgroundColor = [UIColor clearColor];
		
		/*
		 Set the standard images
		 */
		normalImageLeft = [UIImage imageNamed:kSTSegmentLeftBtn];
		normalImageMiddle = [UIImage imageNamed:kSTSegmentMiddleBtn];
		normalImageRight= [UIImage imageNamed:kSTSegmentRightBtn];
		selectedImageLeft = [UIImage imageNamed:kSTSegmentLeftSelectedBtn];
		selectedImageMiddle = [UIImage imageNamed:kSTSegmentMiddleSelectedBtn];
		selectedImageRight = [UIImage imageNamed:kSTSegmentRightSelectedBtn];
		
		selectedSegmentIndex = STSegmentedControlNoSegment;
		momentary = NO;
    }
    return self;
}

- (id)initWithItems:(NSArray *)items {
    if((self = [super init])) {
		self.backgroundColor = [UIColor clearColor];
		
		/*
		 Set the standard images
		 */
		normalImageLeft = [UIImage imageNamed:kSTSegmentLeftBtn];
		normalImageMiddle = [UIImage imageNamed:kSTSegmentMiddleBtn];
		normalImageRight= [UIImage imageNamed:kSTSegmentRightBtn];
		selectedImageLeft = [UIImage imageNamed:kSTSegmentLeftSelectedBtn];
		selectedImageMiddle = [UIImage imageNamed:kSTSegmentMiddleSelectedBtn];
		selectedImageRight = [UIImage imageNamed:kSTSegmentRightSelectedBtn];
		
		selectedSegmentIndex = STSegmentedControlNoSegment;
		momentary = NO;
		
		/*
		 Set items
		 */
		self.segments = [NSMutableArray arrayWithArray:items];
    }
    return self;
}

#pragma mark -
#pragma mark initWithCoder for IB support

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super initWithCoder:decoder])) {
		self.backgroundColor = [UIColor clearColor];
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, kSTSegmentHeight);
		
		/*
		 Set the standard images
		 */
		normalImageLeft = [UIImage imageNamed:kSTSegmentLeftBtn];
		normalImageMiddle = [UIImage imageNamed:kSTSegmentMiddleBtn];
		normalImageRight= [UIImage imageNamed:kSTSegmentRightBtn];
		selectedImageLeft = [UIImage imageNamed:kSTSegmentLeftSelectedBtn];
		selectedImageMiddle = [UIImage imageNamed:kSTSegmentMiddleSelectedBtn];
		selectedImageRight = [UIImage imageNamed:kSTSegmentRightSelectedBtn];
		
		selectedSegmentIndex = STSegmentedControlNoSegment;
		momentary = NO;
	}
	
    return self;
}

#pragma mark -

- (void)updateUI {
	/*
	 Remove every UIButton from screen
	 */
	[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	/*
	 We're only displaying this element if there are at least two buttons
	 */
	if([segments count] > 1)
	{
		numberOfSegments = [segments count];
		int indexOfObject = 0;
		
		float segmentWidth = (float)self.frame.size.width / numberOfSegments;
		float lastX = 0.0;
		
		for(NSObject *object in segments)
		{
			/*
			 Calculate the frame for the current segment
			 */
			int currentSegmentWidth; 
			
			if(indexOfObject < numberOfSegments - 1)
				currentSegmentWidth = round(lastX + segmentWidth) - round(lastX) + 1;
			else
				currentSegmentWidth = round(lastX + segmentWidth) - round(lastX);
			
			CGRect segmentFrame = CGRectMake(round(lastX), 0, currentSegmentWidth, self.frame.size.height);
			lastX += segmentWidth;
			
			/*
			 Give every button the background image it needs for its current state
			 */
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			
			if(indexOfObject == 0)
			{
				if(selectedSegmentIndex == indexOfObject) {
					[button setBackgroundImage:[selectedImageLeft stretchableImageWithLeftCapWidth:kSTSegmentLeftBtnLeftCap topCapHeight:kSTSegmentLeftBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = kSTSegmentSelectedBtnTextColor;
                    button.titleLabel.shadowColor = kSTSegmentSelectedBtnShadowColor;
                }
				else {
					[button setBackgroundImage:[normalImageLeft stretchableImageWithLeftCapWidth:kSTSegmentLeftBtnLeftCap topCapHeight:kSTSegmentLeftBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = kSTSegmentBtnTextColor;
                    button.titleLabel.shadowColor = kSTSegmentBtnShadowColor;
                }
			}
			else if(indexOfObject == numberOfSegments - 1)
			{
				if(selectedSegmentIndex == indexOfObject) {
					[button setBackgroundImage:[selectedImageRight stretchableImageWithLeftCapWidth:kSTSegmentRightBtnLeftCap topCapHeight:kSTSegmentRightBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = kSTSegmentSelectedBtnTextColor;
                    button.titleLabel.shadowColor = kSTSegmentSelectedBtnShadowColor;
                }
				else {
					[button setBackgroundImage:[normalImageRight stretchableImageWithLeftCapWidth:kSTSegmentRightBtnLeftCap topCapHeight:kSTSegmentRightBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = kSTSegmentBtnTextColor;
                    button.titleLabel.shadowColor = kSTSegmentBtnShadowColor;
                }
			}
			else
			{
				if(selectedSegmentIndex == indexOfObject) {
					[button setBackgroundImage:[selectedImageMiddle stretchableImageWithLeftCapWidth:kSTSegmentMiddleBtnLeftCap topCapHeight:kSTSegmentMiddleBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = kSTSegmentSelectedBtnTextColor;
                    button.titleLabel.shadowColor = kSTSegmentSelectedBtnShadowColor;
                }
                else {
					[button setBackgroundImage:[normalImageMiddle stretchableImageWithLeftCapWidth:kSTSegmentMiddleBtnLeftCap topCapHeight:kSTSegmentMiddleBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = kSTSegmentBtnTextColor;
                    button.titleLabel.shadowColor = kSTSegmentBtnShadowColor;
                }
			}
			
			button.frame = segmentFrame;
			button.titleLabel.font = kSTSegmentBtnFont;
			button.titleLabel.shadowOffset = kSTSegmentBtnShadowOffset;
			button.tag = indexOfObject + 1;
			button.adjustsImageWhenHighlighted = NO;
			
			/*
			 Check if we're dealing with a string or an image
			 */
			if([object isKindOfClass:[NSString class]])
			{
				[button setTitle:(NSString *)object forState:UIControlStateNormal];
			}
			else if([object isKindOfClass:[UIImage class]])
			{
				[button setImage:(UIImage *)object forState:UIControlStateNormal];
			}
			
			[button addTarget:self action:@selector(segmentTapped:) forControlEvents:UIControlEventTouchDown];
			[self addSubview:button];
			
			++indexOfObject;
		}
		
		/*
		 Make sure the selected segment shows both its separators
		 */
		[self bringSubviewToFront:[self viewWithTag:selectedSegmentIndex + 1]];
	}
}

- (void)deselectAllSegments {
	/*
	 Deselects all segments
	 */
	for(UIButton *button in self.subviews)
	{
		if(button.tag == 1)
		{
			[button setBackgroundImage:[normalImageLeft stretchableImageWithLeftCapWidth:kSTSegmentLeftBtnLeftCap topCapHeight:kSTSegmentLeftBtnTopCap] forState:UIControlStateNormal];
		}
		else if(button.tag == numberOfSegments)
		{
			[button setBackgroundImage:[normalImageRight stretchableImageWithLeftCapWidth:kSTSegmentRightBtnLeftCap topCapHeight:kSTSegmentRightBtnTopCap] forState:UIControlStateNormal];
		}
		else
		{
			[button setBackgroundImage:[normalImageMiddle stretchableImageWithLeftCapWidth:kSTSegmentMiddleBtnLeftCap topCapHeight:kSTSegmentMiddleBtnTopCap] forState:UIControlStateNormal];
		}
        
        button.titleLabel.textColor = kSTSegmentBtnTextColor;
        button.titleLabel.shadowColor = kSTSegmentBtnShadowColor;
	}
}

- (void)resetSegments {
	/*
	 Reset the index and send the action
	 */
	selectedSegmentIndex = STSegmentedControlNoSegment;
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	
	[self updateUI];
}

- (void)segmentTapped:(id)sender {
	[self deselectAllSegments];
	
	/*
	 Send the action
	 */
	UIButton *button = sender;
	[self bringSubviewToFront:button];
	
	if(selectedSegmentIndex != button.tag - 1 || programmaticIndexChange)
	{
		selectedSegmentIndex = button.tag - 1;
		programmaticIndexChange = NO;
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
	
	/*
	 Give the tapped segment the selected look
	 */
	if(button.tag == 1)
	{
		[button setBackgroundImage:[selectedImageLeft stretchableImageWithLeftCapWidth:kSTSegmentLeftBtnLeftCap topCapHeight:kSTSegmentLeftBtnTopCap] forState:UIControlStateNormal];
	}
	else if(button.tag == numberOfSegments)
	{
		[button setBackgroundImage:[selectedImageRight stretchableImageWithLeftCapWidth:kSTSegmentRightBtnLeftCap topCapHeight:kSTSegmentRightBtnTopCap] forState:UIControlStateNormal];
	}
	else
	{
		[button setBackgroundImage:[selectedImageMiddle stretchableImageWithLeftCapWidth:kSTSegmentMiddleBtnLeftCap topCapHeight:kSTSegmentMiddleBtnTopCap] forState:UIControlStateNormal];
	}
    
    button.titleLabel.textColor = kSTSegmentSelectedBtnTextColor;
    button.titleLabel.shadowColor = kSTSegmentSelectedBtnShadowColor;
	
	if(momentary)
		[self performSelector:@selector(deselectAllSegments) withObject:nil afterDelay:0.2];
}

#pragma mark -
#pragma mark Manipulation methods

- (void)insertSegmentWithObject:(NSObject *)object atIndex:(NSUInteger)index {
	/*
	 Making sure we don't call out of bounds
	 */
	if(index <= numberOfSegments)
	{
		[segments insertObject:object atIndex:index];
		[self resetSegments];
	}
}

- (void)setObject:(NSObject *)object forSegmentAtIndex:(NSUInteger)index {
	/*
	 Making sure we don't call out of bounds
	 */
	if(index < numberOfSegments)
	{
		[segments replaceObjectAtIndex:index withObject:object];
		[self resetSegments];
	}
}

#pragma mark -

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index {
	[self insertSegmentWithObject:title atIndex:index];	
}

- (void)insertSegmentWithImage:(NSString *)image atIndex:(NSUInteger)index {
	[self insertSegmentWithObject:image atIndex:index];		
}

- (void)removeSegmentAtIndex:(NSUInteger)index {
	/*
	 Making sure we don't call out of bounds
	 If you delete a segment when only having two segments, the control won't be shown anymore
	 */
	if(index < numberOfSegments)
	{
		[segments removeObjectAtIndex:index];
		[self resetSegments];
	}
}

- (void)removeAllSegments {
	[segments removeAllObjects];
	
	selectedSegmentIndex = STSegmentedControlNoSegment;
	[self updateUI];
}

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index {
	[self setObject:title forSegmentAtIndex:index];
}

- (void)setImage:(NSString *)image forSegmentAtIndex:(NSUInteger)index {
	[self setObject:image forSegmentAtIndex:index];
}

#pragma mark -
#pragma mark Getters

- (NSString *)titleForSegmentAtIndex:(NSUInteger)index {
	if(index < [segments count])
	{
		if([[segments objectAtIndex:index] isKindOfClass:[NSString class]])
		{
			return [segments objectAtIndex:index];
		}
	}
	
	return nil;
}

- (UIImage *)imageForSegmentAtIndex:(NSUInteger)index {
	if(index < [segments count])
	{
		if([[segments objectAtIndex:index] isKindOfClass:[UIImage class]])
		{
			return [segments objectAtIndex:index];
		}
	}
	
	return nil;
}

#pragma -
#pragma mark Setters

- (void)setSegments:(NSMutableArray *)array {
	if(array != segments)
	{
		segments = array;
	
		[self resetSegments];
	}
}

- (void)setSelectedSegmentIndex:(NSInteger)index {
	if(index != selectedSegmentIndex)
	{
		selectedSegmentIndex = index;
		programmaticIndexChange = YES;
		
		if(index >= 0 && index < numberOfSegments)
		{
			UIButton *button = (UIButton *)[self viewWithTag:index + 1];
			[self segmentTapped:button];
		}
	}
}

- (void)setFrame:(CGRect)rect {
	[super setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, kSTSegmentHeight)];
	[self updateUI];
}

#pragma mark -
#pragma mark Image setters

- (void)setNormalImageLeft:(UIImage *)image {
	if(image != normalImageLeft)
	{
		normalImageLeft = image;
	
		[self updateUI];
	}
}

- (void)setNormalImageMiddle:(UIImage *)image {
	if(image != normalImageMiddle)
	{
		normalImageMiddle = image;
	
		[self updateUI];
	}
}

- (void)setNormalImageRight:(UIImage *)image {
	if(image != normalImageRight)
	{
		normalImageRight = image;
	
		[self updateUI];
	}
}

- (void)setSelectedImageLeft:(UIImage *)image {
	if(image != selectedImageLeft)
	{
		selectedImageLeft = image;
	
		[self updateUI];
	}
}

- (void)setSelectedImageMiddle:(UIImage *)image {
	if(image != selectedImageMiddle)
	{
		selectedImageMiddle = image;
	
		[self updateUI];
	}
}

- (void)setSelectedImageRight:(UIImage *)image {
	if(image != selectedImageRight)
	{
		selectedImageRight = image;
	
		[self updateUI];
	}
}

@end
