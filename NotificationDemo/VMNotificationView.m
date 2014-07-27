//
//  VMNotificationView.m
//  VMNotificationView
//
//  Created by Jimmy Jose on 24/07/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//  See a cleaner version Created by Gaurav Wadhwani on 28/06/14 MPGNotification

//TODO: Fix this code as soon as i get back :)

#import "VMNotificationView.h"

#define kWidth [[UIScreen mainScreen] bounds].size.width

#define kHeight 64

#define kLastWindowObject [[[[[UIApplication sharedApplication] delegate] window] subviews] lastObject]

#define kWindowLevel [[[[UIApplication sharedApplication] delegate] window] windowLevel]

#define kSavePreviousWindowsLevel _windowLevel = kWindowLevel

#define kMakeSettingToShowViewAboveStatusbar [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar + 1]

#define kRestoreToPreviousWindowLevel [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:_windowLevel]

#define kWindowBackgroundColor [[[[UIApplication sharedApplication] delegate] window] backgroundColor]

@interface VMNotificationView ()



@property (nonatomic, retain) NSString *buttonOneTitle;
@property (nonatomic, retain) UIColor *buttonOneTitleColorNormal;
@property (nonatomic, retain) UIColor *buttonOneTitleColorHighlight;
@property (nonatomic, retain) UIColor *buttonOneBackgroundColor;
@property (nonatomic, retain) UIFont *buttonOneFont;

@property (nonatomic, retain) NSString *buttonTwoTitle;


@property (nonatomic, retain) UIColor *buttonTwoTitleColorNormal;
@property (nonatomic, retain) UIColor *buttonTwoTitleColorHighlight;

@property (nonatomic, retain) UIColor *buttonTwoBackgroundColor;
@property (nonatomic, retain) UIFont *buttonTwoFont;


@property (nonatomic, retain) UIColor *backgroundNotificationColor;

@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, retain) UIFont *titleFont;

@property (nonatomic, retain) UIColor *subTitleColor;
@property (nonatomic, retain) UIFont *subTitleFont;

@property (nonatomic, retain) UIImage *imageNotification;

@property (nonatomic, assign) BOOL animateNotification;
@property (nonatomic, assign) CGFloat animateDuration;


@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subTitle;

@property (nonatomic, assign) BOOL buttonOneTimedNotification;
@property (nonatomic, assign) BOOL buttonTwoTimedNotification;

@property (nonatomic, assign) int countdownFrom;

//@property (nonatomic, assign) BOOL isNotificationVisible;




@property (nonatomic, copy) NotificationCallback callback;
@property (assign) UIWindowLevel windowLevel;
@property (nonatomic, retain) UIButton *buttonOne;
@property (nonatomic, retain) UIButton *buttonTwo;
@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) UILabel *lblSubTitle;

@property (nonatomic) NSTimer *timerForAutoDismiss;
@property (nonatomic) NSTimer *timerForStopCheck;
@property (assign) int stepCounter;



@end

@implementation VMNotificationView

static VMNotificationView *_sharedInstance = nil;

+ (VMNotificationView *)sharedInstance {
	if (_sharedInstance != nil) {
		return _sharedInstance;
	}

	@synchronized(self)
	{
		if (_sharedInstance == nil) {
			_sharedInstance = [[self alloc] init];
		}
	}

	return _sharedInstance;
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
	}
	return self;
}

- (id)init {
	self = [super init];

	return self;
}


-(NSString *)trimString:(NSString *)stringToTrim{

    return [stringToTrim stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

}

- (void)addButtonWithTitle:(NSString *)buttonTitle{

    NSAssert(buttonTitle || [[self trimString:buttonTitle] length], @"Button title cannot be empty or nil");
    NSLog(@"_buttonOneTitle %@  _buttonTwoTitle %@",_buttonOneTitle,_buttonTwoTitle);
    NSAssert(!_buttonOneTitle || !_buttonTwoTitle, @"You cannot add more than two buttons");
    
	if (!_buttonOneTitle) _buttonOneTitle = buttonTitle;
    else _buttonTwoTitle = buttonTitle;
}


- (void)addButtonTwoWithTitle:(NSString *)buttonTwoTitle {
	_buttonTwoTitle = buttonTwoTitle;
}

- (void)setBackgroundColorForNotification:(UIColor *)backgroundColor {
	_backgroundNotificationColor = backgroundColor;
}

- (void)setTitleTextColor:(UIColor *)titleColor {
	_titleColor = titleColor;
}

- (void)setSubtitleTextColor:(UIColor *)subtitleColor {
	_subTitleColor = subtitleColor;
}

- (void)setNotificationImage:(UIImage *)image {
	_imageNotification = image;
}

- (void)setButtonOneTitle:(NSString *)buttonTitle {
	_buttonOneTitle = buttonTitle;
}

- (void)setButtonTwoTitle:(NSString *)buttonTitle {
	_buttonTwoTitle = buttonTitle;
}

- (void)setButtonsWithFont:(UIFont *)font {
	_buttonOneFont = font;
	_buttonTwoFont = font;
}

- (void)setButtonOneFont:(UIFont *)font {
	_buttonOneFont = font;
}

- (void)setButtonTwoFont:(UIFont *)font {
	_buttonTwoFont = font;
}

- (void)setButtonOneTitleColorNormal:(UIColor *)buttonOneTitleColorNormal {
	_buttonOneTitleColorNormal = buttonOneTitleColorNormal;
}

- (void)setButtonTwoTitleColorNormal:(UIColor *)buttonTwoTitleColorNormal {
	_buttonTwoTitleColorNormal = buttonTwoTitleColorNormal;
}

- (void)setButtonOneTitleColorHighlight:(UIColor *)buttonOneTitleColorHighlight {
	_buttonOneTitleColorHighlight = buttonOneTitleColorHighlight;
}

- (void)setButtonTwoTitleColorHighlight:(UIColor *)buttonTwoTitleColorHighlight {
	_buttonTwoTitleColorHighlight = buttonTwoTitleColorHighlight;
}

- (void)setButtonOneBackgroundColor:(UIColor *)backgroundColor {
	_buttonOneBackgroundColor = backgroundColor;
}

- (void)setButtonTwoBackgroundColor:(UIColor *)backgroundColor {
	_buttonTwoBackgroundColor = backgroundColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
	_titleFont = titleFont;
}

- (void)setSubTitleFont:(UIFont *)subTitleFont {
	_subTitleFont = subTitleFont;
}

- (void)setShouldAnimate:(BOOL)animate {
	_animateNotification = animate;
}

- (void)setAnimateDuration:(CGFloat)animateDuration {
	_animateDuration = animateDuration;
}

- (void)setButtonOneTimedNotification:(BOOL)buttonOneTimedNotification {
	_buttonOneTimedNotification = buttonOneTimedNotification;
}

- (void)setButtonTwoTimedNotification:(BOOL)buttonTwoTimedNotification {
	_buttonTwoTimedNotification = buttonTwoTimedNotification;
}

- (void)setCountdownFrom:(int)countdownFrom {
	_countdownFrom = countdownFrom;
}

- (id)initWithTitle:(NSString *)title{

    return [self initWithTitle:title subtitle:nil buttonOneTitle:nil buttonTwoTitle:nil];
}

- (id)initWithTitle:(NSString *)title andNotificationImage:(UIImage *)notificationImage{
    
    _imageNotification = notificationImage;
    return [self initWithTitle:title subtitle:nil buttonOneTitle:nil buttonTwoTitle:nil];
}


- (id)initWithTitle:(NSString *)title notificationImage:(UIImage *)notificationImage andButtonTitle:(NSString *)buttonTitle{
    
    _imageNotification = notificationImage;
    return [self initWithTitle:title subtitle:nil buttonOneTitle:buttonTitle buttonTwoTitle:nil];
    
}

- (id)initWithTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle{
    
    return [self initWithTitle:title subtitle:nil buttonOneTitle:buttonTitle buttonTwoTitle:nil];
    
}


- (id)initWithTitle:(NSString *)title notificationImage:(UIImage *)notificationImage buttonOneTitle:(NSString *)buttonOneTitle andButtonTwoTitle:(NSString *)buttonTwoTitle {
    
    _imageNotification = notificationImage;
    return [self initWithTitle:title subtitle:nil buttonOneTitle:buttonOneTitle buttonTwoTitle:buttonTwoTitle];
    
}

- (id)initWithTitle:(NSString *)title buttonOneTitle:(NSString *)buttonOneTitle andButtonTwoTitle:(NSString *)buttonTwoTitle {
    
    return [self initWithTitle:title subtitle:nil buttonOneTitle:buttonOneTitle buttonTwoTitle:buttonTwoTitle];
    
}


- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle{
    
    return [self initWithTitle:title subtitle:subtitle buttonOneTitle:buttonTitle buttonTwoTitle:nil];
}


- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle notificationImage:(UIImage *)notificationImage buttonTitle:(NSString *)buttonTitle{
    
    _imageNotification = notificationImage;
    return [self initWithTitle:title subtitle:subtitle buttonOneTitle:buttonTitle buttonTwoTitle:nil];
}


- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle  notificationImage:(UIImage *)notificationImage buttonOneTitle:(NSString *)buttonOneTitle buttonTwoTitle:(NSString *)buttonTwoTitle {
    
    _imageNotification = notificationImage;
    return [self initWithTitle:title subtitle:subtitle buttonOneTitle:buttonOneTitle buttonTwoTitle:buttonTwoTitle];
}

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle buttonOneTitle:(NSString *)buttonOneTitle buttonTwoTitle:(NSString *)buttonTwoTitle {
    
    NSAssert(title || [[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length], @"Title cannot be nil or empty");
    
	self = [super initWithFrame:CGRectMake(0, -kHeight, kWidth, kHeight)];
    _sharedInstance = [super initWithFrame:CGRectMake(0, -kHeight, kWidth, kHeight)];// After using the init method once you can use sharedInstance method to get the object back. Avoid doing such things.

	_animateDuration = 0.4;
	_animateNotification = YES;

	_imageNotification = nil;


	_title = title;
	_subTitle = subtitle;
	_buttonOneTitle = buttonOneTitle;
	_buttonTwoTitle = buttonTwoTitle;

	_buttonOneTitleColorNormal = [UIColor whiteColor];
	_buttonOneTitleColorHighlight = [UIColor blackColor];

	_buttonTwoTitleColorNormal = [UIColor whiteColor];
	_buttonTwoTitleColorHighlight = [UIColor blackColor];

	_buttonOneBackgroundColor = [UIColor blueColor];
	_buttonTwoBackgroundColor = [UIColor blueColor];

	_buttonOneFont = [UIFont systemFontOfSize:13.0];
	_buttonTwoFont = [UIFont systemFontOfSize:13.0];

	_titleColor = [UIColor blueColor];
	_subTitleColor = [UIColor blueColor];

	_titleFont = [UIFont boldSystemFontOfSize:17.0];
	_subTitleFont = [UIFont systemFontOfSize:14.0];
	_backgroundNotificationColor = kWindowBackgroundColor;
	

	_buttonOneTimedNotification = NO;
	_buttonTwoTimedNotification = NO;
	_countdownFrom = 10;

	return self;
}

- (void)showNotificationViewWithCompletionBlock:(NotificationCallback)completion {
	self.callback = completion;

	[self setLayout];

	[self animateIN];
}

- (void)setLayout {
	CGRect titleFrame = CGRectMake(10, 3, kWidth - 80, 20);
	//titleFrame.size.width += 50;

	if (_imageNotification != nil) {
		UIImageView *notifIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, 32, 32)];
		[notifIcon setImage:_imageNotification];
		[self addSubview:notifIcon];

		titleFrame.origin.x = 45;
		titleFrame.size.width -= 40;
	}

	if (_subTitle == nil || ![[_subTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
		titleFrame.origin.y += 15;
	}
	else {
		_lblSubTitle = [[UILabel alloc] initWithFrame:CGRectMake(titleFrame.origin.x, 24, titleFrame.size.width, 50)];
		[_lblSubTitle setText:_subTitle];
        [_lblSubTitle setTextColor:_subTitleColor];
		[_lblSubTitle setFont:_subTitleFont];
		[_lblSubTitle setNumberOfLines:2];
		[_lblSubTitle sizeToFit];
        _lblSubTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:_lblSubTitle];
	}


	_lblTitle = [[UILabel alloc] initWithFrame:titleFrame];
	[_lblTitle setFont:_titleFont];
	[_lblTitle setText:_title];
    [_lblTitle setTextColor:_titleColor];
    _lblTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:_lblTitle];

	if (_lblSubTitle.frame.size.height < 25) {
		CGRect subtitleFrame = _lblSubTitle.frame;
		subtitleFrame.origin.y += 7;
		[_lblSubTitle setFrame:subtitleFrame];

		if (_subTitle != nil && [[_subTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
			[_lblTitle setFrame:CGRectMake(titleFrame.origin.x, 13, titleFrame.size.width, 20)];
		}
	}

	if (_buttonOneTitle) {
		
        _buttonOne = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 75, 17, 64, 30)];
		[_buttonOne setTitle:_buttonOneTitle forState:UIControlStateNormal];
		[[_buttonOne titleLabel] setFont:_buttonOneFont];
		[_buttonOne setTitleColor:_buttonOneTitleColorNormal forState:UIControlStateNormal];
		[_buttonOne setTitleColor:_buttonOneTitleColorHighlight forState:UIControlStateHighlighted];
		[_buttonOne setBackgroundColor:_buttonOneBackgroundColor];
		[_buttonOne.layer setCornerRadius:3.0];
		[_buttonOne addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
		[_buttonOne setTag:0];
		[self addSubview:_buttonOne];
	}

	if (_buttonTwoTitle) {
		CGRect frame = _buttonOne.frame;
		frame.origin.y = 6.0;
		frame.size.height = 25;
		_buttonOne.frame = frame;

		_buttonTwo = [[UIButton alloc] initWithFrame:CGRectMake(kWidth - 75, 33.5, 64, 25)];
		[_buttonTwo setTitle:_buttonTwoTitle forState:UIControlStateNormal];
		[[_buttonTwo titleLabel] setFont:_buttonTwoFont];
		[_buttonTwo setTitleColor:_buttonTwoTitleColorNormal forState:UIControlStateNormal];
		[_buttonTwo setTitleColor:_buttonTwoTitleColorHighlight forState:UIControlStateHighlighted];
		[_buttonTwo setBackgroundColor:_buttonTwoBackgroundColor];
		[_buttonTwo.layer setCornerRadius:3.0];
		[_buttonTwo addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
		[_buttonTwo setTag:1];
		[self addSubview:_buttonTwo];
	}
    
    if (!_buttonOneTitle && _buttonTwoTitle) {

        _buttonTwo.frame = CGRectMake(kWidth - 75, 17, 64, 30);
        
        
    }
    
    if (!_buttonOne && !_buttonTwo) {
        
        CGRect frame = _lblTitle.frame;
        frame.size.width += 70;
        _lblTitle.frame = frame;
        
        frame = _lblSubTitle.frame;
        frame.size.width += 70;
        _lblSubTitle.frame = frame;
    }
    
    
    
    
    self.backgroundColor = _backgroundNotificationColor;
	[kLastWindowObject addSubview:self];

	
    if (_buttonOneTimedNotification || _buttonTwoTimedNotification) {
		_timerForAutoDismiss = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
		_stepCounter = _countdownFrom;
	}
    
}

- (void)animateIN {
	CGFloat animateDuration = 0.0;

	if (_animateNotification) {
		animateDuration = _animateDuration;
	}

	kSavePreviousWindowsLevel;

	kMakeSettingToShowViewAboveStatusbar;


	self.frame = CGRectMake(0, 0, kWidth, -64);


	[UIView animateWithDuration:animateDuration
	                 animations: ^{
	    self.frame = CGRectMake(0, 0, kWidth, 64);
	}];
}

- (void)dismissWithAnimation:(BOOL)animated {
	if (_timerForAutoDismiss) {
		[_timerForAutoDismiss invalidate];
		_timerForAutoDismiss = nil;
	}

	if (!animated) {
		_animateDuration = 0.0;
	}

	[UIView animateWithDuration:_animateDuration
	                 animations: ^{
	    self.frame = CGRectMake(0, 0, kWidth, -64);
	}

	                 completion: ^(BOOL finished) {
	    [self removeFromSuperview];
	    kRestoreToPreviousWindowLevel;
	}];
}

- (void)buttonTapped:(UIButton *)button {
	[self dismissWithAnimation:_animateNotification];

	if (self.callback) {
		self.callback(button.tag, [self getTitleFromString:button.titleLabel.text]);
	}
}

- (void)handleTimer:(NSTimer *)timer {
	_stepCounter -= 1;

	if (!_stepCounter) {
		[self dismissWithAnimation:_animateNotification];
	}

	if (_buttonOneTimedNotification && _buttonOneTitle) {
		[self drawRect:_buttonOne.frame];
	}

	if (_buttonTwoTimedNotification && _buttonTwoTitle) {
		[self drawRect:_buttonTwo.frame];
	}
}

- (NSString *)getTitleFromString:(NSString *)title {
	return [[title componentsSeparatedByString:@" ("] firstObject];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	if (_buttonOneTimedNotification && _buttonOneTitle) {
		NSString *title = [NSString stringWithFormat:@"%@ (%d)", [self getTitleFromString:_buttonOne.titleLabel.text], _stepCounter];

		[_buttonOne setTitle:title forState:UIControlStateNormal];
	}

	if (_buttonTwoTimedNotification && _buttonTwoTitle) {
		NSString *title = [NSString stringWithFormat:@"%@ (%d)", [self getTitleFromString:_buttonTwo.titleLabel.text], _stepCounter];

		[_buttonTwo setTitle:title forState:UIControlStateNormal];
	}
}

@end
