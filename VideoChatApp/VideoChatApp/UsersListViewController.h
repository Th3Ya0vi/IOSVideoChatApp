//
//  ViewController.h
//  VideoChatApp
//
//  Created by Deepak on 10/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsersListViewController : UIViewController <QBActionStatusDelegate, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

- (IBAction)logoutButtonDidPress:(id)sender;
@property (nonatomic, strong) QBUUser *currentUser;

@end
