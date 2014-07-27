//
//  VMNotificationView.h
//  VMNotificationView
//
//  Created by Jimmy Jose on 24/07/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//  See a cleaner version Created by Gaurav Wadhwani on 28/06/14 MPGNotification

#import <UIKit/UIKit.h>

typedef void (^NotificationCallback)(int pressedButtonIndex, NSString *pressedButtonTitle);

/**
 *  Documentation is not that great...will improve it later.
 *  Added new feature and customization to already existing work done by in MPGNotification.
 *  Wanted to do a pull request will do that later no need to reinvent the wheel, for now posting it with new name.
 *
 *  MPGNotification is a much clear version (codewise), will fix mine later and probably submit as a pull request.
 */
@interface VMNotificationView : UIView



/**
 *  Singleton object, Avoid using this for now. I have yet to figure out a good use case for making it singleton. IF you still wanna use it.. first call initWithTitle function and then use this fuction anywhere to get that object
 *
 *  @warning Avoid using this for now. I have yet to figure out a good use case for making it singleton. IF you still wanna use it.. first call initWithTitle function and then use this fuction anywhere to get that object
 *  @see - (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle buttonOneTitle:(NSString *)buttonOneTitle buttonTwoTitle:(NSString *)buttonTwoTitle
 *  @return singleton object
 */
+ (VMNotificationView *)sharedInstance;


/**
 *  Initializes notificaion view with title
 *
 *  @param title Title for notification view
 *
 *  @return view object
 */
- (id)initWithTitle:(NSString *)title;

/**
 *  Initializes notificaion view with title and image
 *
 *  @param title             Title for notification view (mandatory)
 *  @param notificationImage Image with dimension 32x32 for notification view (optional)
 *
 *  @return view object
 */

- (id)initWithTitle:(NSString *)title andNotificationImage:(UIImage *)notificationImage;


/**
 *  Initializes notificaion view with title, image and button
 *
 *  @param title             Title for notification view (mandatory)
 *  @param notificationImage Image with dimension 32x32 for notification view (optional)
 *  @param buttonTitle       Title for button (optional)
 *
 *  @return view object
 */

- (id)initWithTitle:(NSString *)title notificationImage:(UIImage *)notificationImage andButtonTitle:(NSString *)buttonTitle;

/**
 *  Initializes notificaion view with title and button
 *
 *  @param title       Title for notification view (mandatory)
 *  @param buttonTitle Title for button (optional)
 *
 *  @return view object
 */

- (id)initWithTitle:(NSString *)title andButtonTitle:(NSString *)buttonTitle;


/**
 *  Initializes notificaion view with title, image and two buttons stacked vertically
 *
 *  @param title             Title for notification view (mandatory)
 *  @param notificationImage Image with dimension 32x32 for notification view (optional)
 *  @param buttonOneTitle    Title for button 1 (optional)
 *  @param buttonTwoTitle    Title for button 2 (optional)
 *
 *  @return view object
 */

- (id)initWithTitle:(NSString *)title notificationImage:(UIImage *)notificationImage buttonOneTitle:(NSString *)buttonOneTitle andButtonTwoTitle:(NSString *)buttonTwoTitle;

/**
 *  Initializes notificaion view with title and two buttons stacked vertically
 *
 *  @param title          Title for notification view (mandatory)
 *  @param buttonOneTitle Title for button 1 (optional)
 *  @param buttonTwoTitle Title for button 2 (optional)
 *
 *  @return view object
 */

- (id)initWithTitle:(NSString *)title buttonOneTitle:(NSString *)buttonOneTitle andButtonTwoTitle:(NSString *)buttonTwoTitle;

/**
 *  Initializes notificaion view with title, subtitle and a button
 *
 *  @param title       Title for notification view (mandatory)
 *  @param subtitle    Subtitle for notification view (mandatory)
 *  @param buttonTitle Title for button (optional)
 *
 *  @return view object
 */

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle buttonTitle:(NSString *)buttonTitle;

/**
 *  Initializes notificaion view with title, subtitle, image and a button
 *
 *  @param title             Title for notification view (mandatory)
 *  @param subtitle          Subtitle for notification view (mandatory)
 *  @param notificationImage Image for notification view (mandatory)
 *  @param buttonTitle       Title for button (optional)
 *
 *  @return view object
 */

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle notificationImage:(UIImage *)notificationImage buttonTitle:(NSString *)buttonTitle;

/**
 *  Initializes notificaion view with title, subtitle, image and two buttons stacked vertically
 *
 *  @param title             Title for notification view (mandatory)
 *  @param subtitle          Subtitle for notification view (mandatory)
 *  @param notificationImage Image for notification view (mandatory)
 *  @param buttonOneTitle    Title for button 1 (optional)
 *  @param buttonTwoTitle    Title for button 2 (optional)
 *
 *  @return view object
 */

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle notificationImage:(UIImage *)notificationImage buttonOneTitle:(NSString *)buttonOneTitle buttonTwoTitle:(NSString *)buttonTwoTitle;

/**
 *  Initializes notificaion view with title, subtitle and two buttons stacked vertically
 *
 *  @param title          Title for notificaion view
 *  @param subtitle       Subtitle for notificaion view (optional)
 *  @param buttonOneTitle First button title for notificaion view (optional)
 *  @param buttonTwoTitle Second button title for notificaion view (optional)
 *
 *  @return view object
 */
- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle buttonOneTitle:(NSString *)buttonOneTitle buttonTwoTitle:(NSString *)buttonTwoTitle;

/**
 *  Show notification view, Block based
 *
 *  @param completion block returns index and title of the the button pressed
 */
- (void)showNotificationViewWithCompletionBlock:(NotificationCallback)completion;

/**
 *  Add a button to notification view, if one exists it will add second, but not more than two
 *
 *  @param buttonTitle Title for button (mandatory)
 */
- (void)addButtonWithTitle:(NSString *)buttonTitle;

/**
 *  Set background color for notification view
 *
 *  @param backgroundColor UIColor object
 */
- (void)setBackgroundColorForNotification:(UIColor *)backgroundColor;

/**
 *  Set title color for notification view
 *
 *  @param titleColor UIColor object
 */
- (void)setTitleTextColor:(UIColor *)titleColor;

/**
 *  Set title font for notification view
 *
 *  @param titleFont UIFont object
 */
- (void)setTitleFont:(UIFont *)titleFont;


/**
 *  Set subtitle color for notification view
 *
 *  @param subtitleColor UIColor object
 */

- (void)setSubtitleTextColor:(UIColor *)subtitleColor;


/**
 *  Set subtitle font for notification view
 *
 *  @param subTitleFont UIFont object
 */
- (void)setSubTitleFont:(UIFont *)subTitleFont;


/**
 *  Set image of dimension 32x32 for notification view
 *
 *  @param image UIImage object
 */
- (void)setNotificationImage:(UIImage *)image;


/**
 *  Set button one title for notification view
 *
 *  @param buttonTitle button one title text as string
 */
- (void)setButtonOneTitle:(NSString *)buttonTitle;

/**
 *  Set button one title font for notification view
 *
 *  @param font button one title font
 */
- (void)setButtonOneFont:(UIFont *)font;

/**
 *  Set button one title color for state normal
 *
 *  @param titleColor UIColor object
 */
- (void)setButtonOneTitleColorNormal:(UIColor *)titleColor;


/**
 *  Set button one title color for state highlight
 *
 *  @param buttonOneTitleColorHighlight UIColor object
 */
- (void)setButtonOneTitleColorHighlight:(UIColor *)buttonOneTitleColorHighlight;


/**
 *  Set button one background color
 *
 *  @param backgroundColor UIColor object
 */
- (void)setButtonOneBackgroundColor:(UIColor *)backgroundColor;


/**
 *  Set button two title for notification view
 *
 *  @param buttonTitle as NSString
 */
- (void)setButtonTwoTitle:(NSString *)buttonTitle;


/**
 *  Set button two title font for notification view
 *
 *  @param font as UIFont
 */
- (void)setButtonTwoFont:(UIFont *)font;


/**
 *  Set button two title color for state normal
 *
 *  @param titleColor as UIColor
 */
- (void)setButtonTwoTitleColorNormal:(UIColor *)titleColor;

/**
 *  Set button two title color for state highlight
 *
 *  @param buttonTwoTitleColorHighlight as UIColor
 */
- (void)setButtonTwoTitleColorHighlight:(UIColor *)buttonTwoTitleColorHighlight;


/**
 *  Set button two background color
 *
 *  @param backgroundColor as UIColor
 */
- (void)setButtonTwoBackgroundColor:(UIColor *)backgroundColor;


/**
 *  Set all button with same font
 *
 *  @param font as UIFont
 */
- (void)setButtonsWithFont:(UIFont *)font;


/**
 *  Set animate property
 *
 *  @param animate as BOOL
 */
- (void)setShouldAnimate:(BOOL)animate;


/**
 *  Set animation duration
 *
 *  @param animateDuration as Float
 */
- (void)setAnimateDuration:(CGFloat)animateDuration;


/**
 *  Set YES for button one to be controlled by countdown
 *
 *  @param buttonOneTimedNotification as BOOL
 */
- (void)setButtonOneTimedNotification:(BOOL)buttonOneTimedNotification;


/**
 *  Set YES for button two to be controlled by countdown
 *
 *  @param buttonTwoTimedNotification as BOOL
 */
- (void)setButtonTwoTimedNotification:(BOOL)buttonTwoTimedNotification;

/**
 *  Set the value from which the countdown should begin
 *
 *  @param countdownFrom as Int
 */
- (void)setCountdownFrom:(int)countdownFrom;

/**
 *  This method to dismiss notification. If 'animated' variable is set to NO, the notification will disappear without any animation
 *
 *  @param animated as BOOL
 */
- (void)dismissWithAnimation:(BOOL)animated;


@end
