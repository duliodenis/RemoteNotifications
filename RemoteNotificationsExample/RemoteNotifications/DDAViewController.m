//
//  DDAViewController.m
//  RemoteNotifications
//
//  Created by Dulio Denis on 5/18/14.
//  Copyright (c) 2014 ddApps. All rights reserved.
//

#import "DDAViewController.h"

@interface DDAViewController ()
@property (nonatomic) IBOutlet UILabel *notificationLabel;
- (IBAction)loadButton:(id)sender;
- (IBAction)eraseButton:(id)sender;

@end

@implementation DDAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)loadButton:(id)sender {
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"RemoteNotification"];
    self.notificationLabel.text = savedValue;
    [self.notificationLabel setNeedsDisplay];
}

- (IBAction)eraseButton:(id)sender {
    NSString *valueToSave = @"Hello, World!";
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"RemoteNotification"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.notificationLabel.text = @"Reset";
    [self.notificationLabel setNeedsDisplay];
}

@end
