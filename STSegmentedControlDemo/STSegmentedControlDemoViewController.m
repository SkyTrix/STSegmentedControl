//
//  STSegmentedControlDemoViewController.m
//  STSegmentedControlDemo
//
//  Created by Cedric Vandendriessche on 01/07/11.
//  Copyright 2011 FreshCreations. All rights reserved.
//

#import "STSegmentedControlDemoViewController.h"
#import "STSegmentedControl.h"

@implementation STSegmentedControlDemoViewController

@synthesize segment, standardSegment; 

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSArray *objects = [NSArray arrayWithObjects:@"Featured", [UIImage imageNamed:@"SomeIcon.png"], @"Top Charts", @"Categories", nil];
	
	/*
	 STSegmentedControl
	 */
	segment = [[STSegmentedControl alloc] initWithItems:objects];
	segment.frame = CGRectMake(10, 10, 300, 40);
	[segment addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
	segment.selectedSegmentIndex = 1;
	segment.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:segment];
    
	/*
	 UIKit UISegmentedControl
	 */
	standardSegment = [[UISegmentedControl alloc] initWithItems:objects];
	standardSegment.frame = CGRectMake(10, 50, 300, 30);
	standardSegment.segmentedControlStyle = UISegmentedControlStyleBar;
	[standardSegment addTarget:self action:@selector(standardSegmentValueChanged:) forControlEvents:UIControlEventValueChanged];
	standardSegment.selectedSegmentIndex = 1;
	standardSegment.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:standardSegment];
	
	/*
	 Buttons
	 */
	UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button1.frame = CGRectMake(10, 100, 145, 30);
	[button1 setTitle:@"Remove button" forState:UIControlStateNormal];
	[button1 addTarget:self action:@selector(button1Clicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button1];
    
	UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button2.frame = CGRectMake(165, 100, 145, 30);
	[button2 setTitle:@"Change button 2" forState:UIControlStateNormal];
	[button2 addTarget:self action:@selector(button2Clicked:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button2];
}

- (void)valueChanged:(id)sender {
	STSegmentedControl *control = sender;
	NSLog(@"ST Index: %li", (long)control.selectedSegmentIndex);
}

- (void)standardSegmentValueChanged:(id)sender {
	UISegmentedControl *control = sender;
	NSLog(@"UI Index: %li", (long)control.selectedSegmentIndex);
}

- (void)button1Clicked:(id)sender {
	[segment removeSegmentAtIndex:0];
	[standardSegment removeSegmentAtIndex:0 animated:NO];
}

- (void)button2Clicked:(id)sender {
	[segment setTitle:@"Changed!" forSegmentAtIndex:1];
	
	if(standardSegment.numberOfSegments >= 2)
		[standardSegment setTitle:@"Changed!" forSegmentAtIndex:1];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.segment = nil;
	self.standardSegment = nil;
}

@end
