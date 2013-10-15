//
//  ViewController.m
//  VideoChatApp
//
//  Created by Deepak on 10/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import "UsersListViewController.h"
#import "AppDelegate.h"
#import "UserCell.h"
#import "UserDetailViewController.h"
#import "User.h"

@interface UsersListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *usersTable;
@property (weak, nonatomic) NSArray* users;
@property (strong, nonatomic) NSMutableArray* searchUsers;
@property (weak, nonatomic)  UITableViewCell *userCell;

@end

@implementation UsersListViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    
    // retrieve users
    [self retrieveUsers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Retrieve QuickBlox Users
- (void) retrieveUsers{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // retrieve 100 users
    PagedRequest* request = [[PagedRequest alloc] init];
    request.perPage = 100;
	[QBUsers usersWithPagedRequest:request delegate:self];
}

// QuickBlox API queries delegate
- (void)completedWithResult:(Result *)result
{
    // Retrieve Users result
    if([result isKindOfClass:[QBUUserPagedResult class]])
    {
        // Success result
        if (result.success)
        {
            // update table
            QBUUserPagedResult *usersSearchRes = (QBUUserPagedResult *)result;
            self.users = usersSearchRes.users;
            self.searchUsers = [self.users mutableCopy] ;
            [self.usersTable reloadData];
            
            // Errors
        }else{
            NSLog(@"Errors=%@", result.errors);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } else if([result isKindOfClass:[QBUUserLogOutResult class]]){
		QBUUserLogOutResult *res = (QBUUserLogOutResult *)result;
        
		if(res.success){
		    NSLog(@"LogOut successful.");
            self.currentUser = nil;
            [User sharedInstance].currentQBUser = nil;
            [self.navigationController popToRootViewControllerAnimated:YES];
		}else{
            NSLog(@"errors=%@", result.errors);
		}
	}
}


#pragma mark -
#pragma mark TableViewDataSource & TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchUsers count];
}

// Making table view using custom cells
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString* UserCellIdentifier = @"UserCell";
    
    UserCell* cell = [tableView dequeueReusableCellWithIdentifier:UserCellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserCell" owner:self options:nil];
        cell = (UserCell *) [nib objectAtIndex:0];
    }
    QBUUser* obtainedUser = [self.searchUsers objectAtIndex:[indexPath row]];
    if(obtainedUser.login != nil){
        cell.userName.text = obtainedUser.login;
    }
    else{
        cell.userName.text = obtainedUser.email;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*[self.searchBar resignFirstResponder];
     
     */
    // show user details
     UserDetailViewController *userDetailViewController = [[UserDetailViewController alloc] initWithNibName:@"UserDetailViewController" bundle:nil];
    userDetailViewController.selectedUser = [self.searchUsers objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:userDetailViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// logout
- (IBAction)logoutButtonDidPress:(id)sender {
    // remove push subscription to this device
    /*[QBMessages TUnregisterSubscriptionWithDelegate:nil];
    
    // show splash
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) showSplashWithAnimation:YES showLoginButton:YES];
    
    // notify
    //[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogout object:nil];
    
    // logout
    [[FBService shared].facebook logout];
    dispatch_async( dispatch_get_main_queue(), ^{
        [[FBService shared] logOutChat];
    });*/
    
        // logout user
    if ([[QBChat instance]isLoggedIn]) {
        [[QBChat instance] logout];
    }
        [QBUsers logOutWithDelegate:self];
}
@end

