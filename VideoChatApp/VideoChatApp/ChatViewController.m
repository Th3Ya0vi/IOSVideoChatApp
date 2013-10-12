//
//  ViewController.m
//  VideoChatApp
//
//  Created by Deepak on 10/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@property (weak, nonatomic) IBOutlet UITableView *usersTable;
@property (weak, nonatomic) QBUUser *currentUser;
@property (weak, nonatomic) NSArray* users;
@property (strong, nonatomic) NSMutableArray* searchUsers;
@property (weak, nonatomic) IBOutlet UITableViewCell *userCell;
@property (weak, nonatomic) IBOutlet UILabel* userLogin;
@property (weak, nonatomic) IBOutlet UILabel* userTag;

@end

@implementation ChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // retrieve users
    //[self retrieveUsers];
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
    }
}


#pragma mark -
#pragma mark TableViewDataSource & TableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*[self.searchBar resignFirstResponder];
    
    // show user details
    detailsController.choosedUser = [self.searchUsers objectAtIndex:[indexPath row]];
    [self presentModalViewController:detailsController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchUsers count];
}

// Making table view using custom cells
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    
  
    QBUUser* obtainedUser = [self.searchUsers objectAtIndex:[indexPath row]];
    if(obtainedUser.login != nil){
        self.userLogin.text = obtainedUser.login;
    }
    else{
        self.userLogin.text = obtainedUser.email;
    }
    
    for(NSString *tag in obtainedUser.tags){
        if([self.userTag.text length] == 0){
            self.userTag.text = tag;
        }else{
            self.userTag.text = [NSString stringWithFormat:@"%@, %@", self.userTag.text, tag];
        }
    }
    
    return self.userCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
