//
//  SignUpViewController.m
//  VideoChatApp
//
//  Created by Deepak on 13/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import "SignUpViewController.h"
#import "UsersListViewController.h"
#import "UserDetailViewController.h"
#import "User.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;
- (IBAction)loginWithFaceBook:(id)sender;

@end

@implementation SignUpViewController

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
    [QBAuth createSessionWithDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated {
    [self.activityIndicator setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginWithFaceBook:(id)sender {
    
    [QBUsers logInWithSocialProvider:@"facebook" scope:nil delegate:self];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
}


#pragma mark -
#pragma mark QBActionStatusDelegate

// QuickBlox API queries delegate
-(void)completedWithResult:(Result *)result{
    
    // QuickBlox User authenticate result
    if([result isKindOfClass:[QBUUserLogInResult class]]){
		
        // Success result
        if(result.success){
            UsersListViewController *usersListViewController = [[UsersListViewController alloc] initWithNibName:@"UsersListViewController" bundle:nil];

            // save current user
            QBUUserLogInResult *res = (QBUUserLogInResult *)result;
            usersListViewController.currentUser = res.user;
            
            [User sharedInstance].currentQBUser = res.user;
            [self.navigationController pushViewController:usersListViewController animated:YES];
            
                        
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentification successful" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//            [alert show];
            
            //[mainController loggedIn];
            
            // Errors
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Errors"
                                                            message:[result.errors description]
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles: nil];
            alert.tag = 1;
            [alert show];
        }
    }
    [self.activityIndicator setHidden:YES];
    [self.activityIndicator stopAnimating];
}
@end
