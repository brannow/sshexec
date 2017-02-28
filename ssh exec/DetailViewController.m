//
//  DetailViewController.m
//  ssh exec
//
//  Created by Benjamin on 28.02.17.
//  Copyright © 2017 Benjamin. All rights reserved.
//

#import "DetailViewController.h"
#import "Command.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayCommand;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *executeButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayCommand.text = self.command.command;
    self.status.text = @"idle";
    self.executeButton.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)executeCommand:(id)sender
{
    self.status.text = @"running";
    self.executeButton.enabled = NO;
}

@end
