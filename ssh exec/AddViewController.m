//
//  AddViewController.m
//  ssh exec
//
//  Created by Benjamin on 28.02.17.
//  Copyright © 2017 Benjamin. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"
#import "Command.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *commandName;
@property (weak, nonatomic) IBOutlet UITextField *commandAddress;
@property (weak, nonatomic) IBOutlet UITextField *commandUsername;
@property (weak, nonatomic) IBOutlet UITextField *commandPassword;
@property (weak, nonatomic) IBOutlet UITextField *commandCommand;

@end

@implementation AddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add Command";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard
{
    [self.commandName resignFirstResponder];
    [self.commandAddress resignFirstResponder];
    [self.commandUsername resignFirstResponder];
    [self.commandPassword resignFirstResponder];
    [self.commandCommand resignFirstResponder];
}

- (IBAction)cancel:(id)sender
{
    [self dismissKeyboard];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)saveHumidor:(id)sender
{
    NSString *name = [self.commandName.text stringByTrimmingCharactersInSet:
                     [NSCharacterSet whitespaceCharacterSet]];
    
    if (name.length > 0) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        Command* command = (Command*)[appDelegate createDataObjectWithName:@"Command"];
        
        command.name = name;

        command.address = [self.commandAddress.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
        
        command.username = [self.commandUsername.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
        
        command.password = [self.commandPassword.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
        
        command.command = [self.commandCommand.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
        
        [appDelegate saveContext];
        
        [self cancel:sender];
    } else {
        [self showMissingNameWarning];
    }
}

- (void) showMissingNameWarning
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Command Name"
                                                                             message:@"Ihr neuer Command hat keinen Namen"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   [self.commandName becomeFirstResponder];
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
