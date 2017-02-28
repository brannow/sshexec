//
//  DetailViewController.m
//  ssh exec
//
//  Created by Benjamin on 28.02.17.
//  Copyright © 2017 Benjamin. All rights reserved.
//

#import "DetailViewController.h"
#import "Command.h"
#import <NMSSH/NMSSH.h>

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
    self.status.text = @"connecting";
    self.executeButton.enabled = NO;
    
    NMSSHSession *session = [NMSSHSession connectToHost:self.command.address
                                           withUsername:self.command.username];
    
    if (session.isConnected) {
        self.status.text = @"authenticating";
        if(![session authenticateByPassword:self.command.password]) {
            self.status.text = @"authentication failed";
        } else {
            if (session.isAuthorized) {
                self.status.text = @"execute";
                NSError *error = nil;
                NSString *response = [session.channel execute:self.command.command error:&error];
                
                if (!error) {
                    self.status.text = @"success";
                    self.displayCommand.text = response;
                } else {
                    self.status.text = @"failed";
                    self.displayCommand.text = [error localizedDescription];
                }
            }
        }
    }
    
    self.executeButton.enabled = YES;
}

@end
