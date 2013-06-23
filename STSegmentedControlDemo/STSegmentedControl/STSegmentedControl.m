//
//  STSegmentedControl.m
//  STSegmentedControl
//
//  Created by Cedric Vandendriessche on 10/11/10.
//  Copyright 2010 FreshCreations. All rights reserved.
//

#import "STSegmentedControl.h"
#import "STSegmentedControlUI.h"

@interface STSegmentedControl ()
@property (nonatomic, getter = isProgrammaticIndexChange) BOOL programmaticIndexChange;

@property (nonatomic, readwrite) NSUInteger numberOfSegments;

- (void)updateUI;
- (void)deselectAllSegments;
- (void)insertSegmentWithObject:(NSObject *)object atIndex:(NSUInteger)index;
- (void)setObject:(NSObject *)object forSegmentAtIndex:(NSUInteger)index;
@end

@implementation STSegmentedControl

#pragma mark -
#pragma mark Initializer

- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kSTSegmentHeight)])) {
		self.backgroundColor = [UIColor clearColor];
		
		/*
		 Set the standard images
		 */
		self.normalImageLeft = [UIImage imageNamed:kSTSegmentLeftBtn];
		self.normalImageMiddle = [UIImage imageNamed:kSTSegmentMiddleBtn];
		self.normalImageRight= [UIImage imageNamed:kSTSegmentRightBtn];
		self.selectedImageLeft = [UIImage imageNamed:kSTSegmentLeftSelectedBtn];
		self.selectedImageMiddle = [UIImage imageNamed:kSTSegmentMiddleSelectedBtn];
		self.selectedImageRight = [UIImage imageNamed:kSTSegmentRightSelectedBtn];
        
        self.buttonFont = kSTSegmentBtnFont;
        self.buttonTextColor = kSTSegmentBtnTextColor;
        self.selectedButtonTextColor = kSTSegmentSelectedBtnTextColor;
        self.buttonShadowColor = kSTSegmentBtnShadowColor;
        self.selectedButtonShadowColor = kSTSegmentSelectedBtnShadowColor;
        self.buttonShadowOffset = kSTSegmentBtnShadowOffset;
		
		self.selectedSegmentIndex = STSegmentedControlNoSegment;
		self.momentary = NO;
    }
    return self;
}

- (id)initWithItems:(NSArray *)items {
    if((self = [super init])) {
		self.backgroundColor = [UIColor clearColor];
		
		/*
		 Set the standard images
		 */
		self.normalImageLeft = [UIImage imageNamed:kSTSegmentLeftBtn];
		self.normalImageMiddle = [UIImage imageNamed:kSTSegmentMiddleBtn];
		self.normalImageRight= [UIImage imageNamed:kSTSegmentRightBtn];
		self.selectedImageLeft = [UIImage imageNamed:kSTSegmentLeftSelectedBtn];
		self.selectedImageMiddle = [UIImage imageNamed:kSTSegmentMiddleSelectedBtn];
		self.selectedImageRight = [UIImage imageNamed:kSTSegmentRightSelectedBtn];
        
        self.buttonFont = kSTSegmentBtnFont;
        self.buttonTextColor = kSTSegmentBtnTextColor;
        self.selectedButtonTextColor = kSTSegmentSelectedBtnTextColor;
        self.buttonShadowColor = kSTSegmentBtnShadowColor;
        self.selectedButtonShadowColor = kSTSegmentSelectedBtnShadowColor;
        self.buttonShadowOffset = kSTSegmentBtnShadowOffset;
		
		self.selectedSegmentIndex = STSegmentedControlNoSegment;
		self.momentary = NO;
		
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
		self.normalImageLeft = [UIImage imageNamed:kSTSegmentLeftBtn];
		self.normalImageMiddle = [UIImage imageNamed:kSTSegmentMiddleBtn];
		self.normalImageRight= [UIImage imageNamed:kSTSegmentRightBtn];
		self.selectedImageLeft = [UIImage imageNamed:kSTSegmentLeftSelectedBtn];
		self.selectedImageMiddle = [UIImage imageNamed:kSTSegmentMiddleSelectedBtn];
		self.selectedImageRight = [UIImage imageNamed:kSTSegmentRightSelectedBtn];
        
        self.buttonFont = kSTSegmentBtnFont;
        self.buttonTextColor = kSTSegmentBtnTextColor;
        self.selectedButtonTextColor = kSTSegmentSelectedBtnTextColor;
        self.buttonShadowColor = kSTSegmentBtnShadowColor;
        self.selectedButtonShadowColor = kSTSegmentSelectedBtnShadowColor;
        self.buttonShadowOffset = kSTSegmentBtnShadowOffset;
		
		self.selectedSegmentIndex = STSegmentedControlNoSegment;
		self.momentary = NO;
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
	if([self.segments count] > 1)
	{
		self.numberOfSegments = [self.segments count];
		int indexOfObject = 0;
		
		float segmentWidth = (float)self.frame.size.width / self.numberOfSegments;
		float lastX = 0.0;
		
		for(NSObject *object in self.segments)
		{
			/*
			 Calculate the frame for the current segment
			 */
			int currentSegmentWidth; 
			
			if(indexOfObject < self.numberOfSegments - 1)
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
				if(self.selectedSegmentIndex == indexOfObject) {
					[button setBackgroundImage:[self.selectedImageLeft stretchableImageWithLeftCapWidth:kSTSegmentLeftBtnLeftCap topCapHeight:kSTSegmentLeftBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = self.selectedButtonTextColor;
                    button.titleLabel.shadowColor = self.selectedButtonShadowColor;
                }
				else {
					[button setBackgroundImage:[self.normalImageLeft stretchableImageWithLeftCapWidth:kSTSegmentLeftBtnLeftCap topCapHeight:kSTSegmentLeftBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = self.buttonTextColor;
                    button.titleLabel.shadowColor = self.buttonShadowColor;
                }
			}
			else if(indexOfObject == self.numberOfSegments - 1)
			{
				if(self.selectedSegmentIndex == indexOfObject) {
					[button setBackgroundImage:[self.selectedImageRight stretchableImageWithLeftCapWidth:kSTSegmentRightBtnLeftCap topCapHeight:kSTSegmentRightBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = self.selectedButtonTextColor;
                    button.titleLabel.shadowColor = self.selectedButtonShadowColor;
                }
				else {
					[button setBackgroundImage:[self.normalImageRight stretchableImageWithLeftCapWidth:kSTSegmentRightBtnLeftCap topCapHeight:kSTSegmentRightBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = self.buttonTextColor;
                    button.titleLabel.shadowColor = self.buttonShadowColor;
                }
			}
			else
			{
				if(self.selectedSegmentIndex == indexOfObject) {
					[button setBackgroundImage:[self.selectedImageMiddle stretchableImageWithLeftCapWidth:kSTSegmentMiddleBtnLeftCap topCapHeight:kSTSegmentMiddleBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = self.selectedButtonTextColor;
                    button.titleLabel.shadowColor = self.selectedButtonShadowColor;
                }
                else {
					[button setBackgroundImage:[self.normalImageMiddle stretchableImageWithLeftCapWidth:kSTSegmentMiddleBtnLeftCap topCapHeight:kSTSegmentMiddleBtnTopCap] forState:UIControlStateNormal];
                    button.titleLabel.textColor = self.buttonTextColor;
                    button.titleLabel.shadowColor = self.buttonShadowColor;
                }
			}
			
			button.frame = segmentFrame;
			button.titleLabel.font = self.buttonFont;
			button.titleLabel.shadowOffset = self.buttonShadowOffset;
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
		[self bringSubviewToFront:[self viewWithTag:self.selectedSegmentIndex + 1]];
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
			[button setBackgroundImage:[self.normalImageLeft stretchableImageWithLeftCapWidth:kSTSegmentLeftBtnLeftCap topCapHeight:kSTSegmentLeftBtnTopCap] forState:UIControlStateNormal];
		}
		else if(button.tag == self.numberOfSegments)
		{
			[button setBackgroundImage:[self.normalImageRight stretchableImageWithLeftCapWidth:kSTSegmentRightBtnLeftCap topCapHeight:kSTSegmentRightBtnTopCap] forState:UIControlStateNormal];
		}
		else
		{
			[button setBackgroundImage:[self.normalImageMiddle stretchableImageWithLeftCapWidth:kSTSegmentMiddleBtnLeftCap topCapHeight:kSTSegmentMiddleBtnTopCap] forState:UIControlStateNormal];
		}
        
        button.titleLabel.textColor = self.buttonTextColor;
        button.titleLabel.shadowColor = self.buttonShadowColor;
	}
}

- (void)resetSegments {
	/*
	 Reset the index and send the action
	 */
	self.selectedSegmentIndex = STSegmentedControlNoSegment;
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
	
	if(self.selectedSegmentIndex != button.tag - 1 || self.isProgrammaticIndexChange)
	{
		self.selectedSegmentIndex = button.tag - 1;
		self.programmaticIndexChange = NO;
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
	
	/*
	 Give the tapped segment the selected look
	 */
	if(button.tag == 1)
	{
		[button setBackgroundImage:[self.selectedImageLeft stretchableImageWithLeftCapWidth:kSTSegmentLeftBtnLeftCap topCapHeight:kSTSegmentLeftBtnTopCap] forState:UIControlStateNormal];
	}
	else if(button.tag == self.numberOfSegments)
	{
		[button setBackgroundImage:[self.selectedImageRight stretchableImageWithLeftCapWidth:kSTSegmentRightBtnLeftCap topCapHeight:kSTSegmentRightBtnTopCap] forState:UIControlStateNormal];
	}
	else
	{
		[button setBackgroundImage:[self.selectedImageMiddle stretchableImageWithLeftCapWidth:kSTSegmentMiddleBtnLeftCap topCapHeight:kSTSegmentMiddleBtnTopCap] forState:UIControlStateNormal];
	}
    
    button.titleLabel.textColor = self.selectedButtonTextColor;
    button.titleLabel.shadowColor = self.selectedButtonShadowColor;
	
	if(self.momentary)
		[self performSelector:@selector(deselectAllSegments) withObject:nil afterDelay:0.2];
}

#pragma mark -
#pragma mark Manipulation methods

- (void)insertSegmentWithObject:(NSObject *)object atIndex:(NSUInteger)index {
	/*
	 Making sure we don't call out of bounds
	 */
	if(index <= self.numberOfSegments)
	{
		[self.segments insertObject:object atIndex:index];
		[self resetSegments];
	}
}

- (void)setObject:(NSObject *)object forSegmentAtIndex:(NSUInteger)index {
	/*
	 Making sure we don't call out of bounds
	 */
	if(index < self.numberOfSegments)
	{
		[self.segments replaceObjectAtIndex:index withObject:object];
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
	if(index < self.numberOfSegments)
	{
		[self.segments removeObjectAtIndex:index];
		[self resetSegments];
	}
}

- (void)removeAllSegments {
	[self.segments removeAllObjects];
	
	self.selectedSegmentIndex = STSegmentedControlNoSegment;
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
	if(index < [self.segments count])
	{
		if([[self.segments objectAtIndex:index] isKindOfClass:[NSString class]])
		{
			return [self.segments objectAtIndex:index];
		}
	}
	
	return nil;
}

- (UIImage *)imageForSegmentAtIndex:(NSUInteger)index {
	if(index < [self.segments count])
	{
		if([[self.segments objectAtIndex:index] isKindOfClass:[UIImage class]])
		{
			return [self.segments objectAtIndex:index];
		}
	}
	
	return nil;
}

#pragma -
#pragma mark Setters

- (void)setSegments:(NSMutableArray *)array {
	if(array != self.segments)
	{
		_segments = array;
	
		[self resetSegments];
	}
}

- (void)setSelectedSegmentIndex:(NSInteger)index {
	if(index != self.selectedSegmentIndex)
	{
		_selectedSegmentIndex = index;
		self.programmaticIndexChange = YES;
		
		if(index >= 0 && index < self.numberOfSegments)
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
	if(image != self.normalImageLeft)
	{
		_normalImageLeft = image;
	
		[self updateUI];
	}
}

- (void)setNormalImageMiddle:(UIImage *)image {
	if(image != self.normalImageMiddle)
	{
		_normalImageMiddle = image;
	
		[self updateUI];
	}
}

- (void)setNormalImageRight:(UIImage *)image {
	if(image != self.normalImageRight)
	{
		_normalImageRight = image;
	
		[self updateUI];
	}
}

- (void)setSelectedImageLeft:(UIImage *)image {
	if(image != self.selectedImageLeft)
	{
		_selectedImageLeft = image;
	
		[self updateUI];
	}
}

- (void)setSelectedImageMiddle:(UIImage *)image {
	if(image != self.selectedImageMiddle)
	{
		_selectedImageMiddle = image;
	
		[self updateUI];
	}
}

- (void)setSelectedImageRight:(UIImage *)image {
	if(image != self.selectedImageRight)
	{
		_selectedImageRight = image;
	
		[self updateUI];
	}
}

@end
