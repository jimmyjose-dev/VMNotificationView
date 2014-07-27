//
//  ViewController.m
//  NotificationDemo
//
//  Created by Jimmy Jose on 24/07/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "VMNotificationView.h"
@interface ViewController ()
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    
}


-(IBAction)buttonPressed:(id)sender{

    NSString *title = @"Hot deal of the day!!!";
    NSString *subtitle = @"Wassup peeps, new deal for u view full message now...?";
    
    NSString *buttonOneTitle = @"YES";
    NSString *buttonTwoTitle = @"NO";
    NSString *buttonThreeTitle = @"MAYBE";

    //VMNotificationView *vm = [[VMNotificationView alloc] initWithTitle:title subtitle:nil buttonOneTitle:nil buttonTwoTitle:nil];
    //[vm addButtonTwoWithTitle:@"NO"];
    
    
    VMNotificationView *vm = [[VMNotificationView alloc] initWithTitle:title];
    //[vm addButtonTwoWithTitle:@"NO"];
    //[vm addButtonWithTitle:buttonOneTitle];
    //[vm addButtonWithTitle:buttonTwoTitle];
    
    //[vm addButtonWithTitle:buttonThreeTitle];
    
    UIImage *notificationImage = [UIImage imageNamed:@"58x58"];
    
    [vm setNotificationImage:notificationImage];
    [vm setCountdownFrom:10];
    //[vm setButtonOneTimedNotification:YES];
    [vm setButtonTwoTimedNotification:YES];
    
   /*
    [vm setBackgroundColorForNotification:[UIColor brownColor]];
    
    [vm setButtonOneTitleColorNormal:[UIColor yellowColor]];
    [vm setButtonTwoTitleColorNormal:[UIColor orangeColor]];
    
    [vm setButtonOneBackgroundColor:[UIColor greenColor]];
    [vm setButtonTwoBackgroundColor:[UIColor blackColor]];
    
    [vm setTitleTextColor:[UIColor greenColor]];
    [vm setSubtitleTextColor:[UIColor cyanColor]];
    */

    [vm showNotificationViewWithCompletionBlock:^(int pressedButtonIndex, NSString *pressedButtonTitle) {
        NSLog(@"pressedButtonIndex %d pressedButtonTitle %@",pressedButtonIndex,pressedButtonTitle);
    }];
    

}

-(IBAction)dismiss:(id)sender{

    VMNotificationView *vm1 = [VMNotificationView sharedInstance];
    
   [vm1 dismissWithAnimation:YES];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
