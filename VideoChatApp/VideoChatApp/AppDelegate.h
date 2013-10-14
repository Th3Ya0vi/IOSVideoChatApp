//
//  AppDelegate.h
//  VideoChatApp
//
//  Created by Deepak on 10/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UsersListViewController;
@class SignUpViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UsersListViewController *usersListViewController;
@property (strong, nonatomic) SignUpViewController *signUpViewController;

- (void)showSplashWithAnimation:(BOOL) animated;
- (void)showSplashWithAnimation:(BOOL) animated showLoginButton:(BOOL)isShow;@end
