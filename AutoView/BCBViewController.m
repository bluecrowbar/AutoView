//
//  BCBViewController.m
//  AutoView
//
//  Created by Steven Vandeweghe on 10/6/13.
//  Copyright (c) 2013 Blue Crowbar. All rights reserved.
//

#import "BCBViewController.h"

@interface BCBViewController ()

@property (nonatomic, weak) IBOutlet UIView *background;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation BCBViewController {
	id _token;
	BOOL _shortText;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.background.layer.borderColor = [UIColor redColor].CGColor;
	self.background.layer.borderWidth = 2;
	
	__weak BCBViewController *weakSelf = self;
	_token = [[NSNotificationCenter defaultCenter] addObserverForName:UIContentSizeCategoryDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
		weakSelf.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	}];
	
	[[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateText:) userInfo:nil repeats:YES] fire];
}

- (void)dealloc
{
	if (_token) {
		[[NSNotificationCenter defaultCenter] removeObserver:_token];
	}
}


- (void)updateText:(NSTimer *)timer
{
	_shortText = !_shortText;
	if (_shortText) {
		self.label.text = @"Short text";
	} else {
		self.label.text = @"Long text long text long text long text long text long text long text long text";
	}
	[UIView animateWithDuration:0.25 animations:^{
		self.label.alpha = 0;
		[self.label layoutIfNeeded];
		[self.background layoutIfNeeded];
		self.label.alpha = 1;
	}];
}

@end
