//
//  AppDelegate.h
//  VideoChatApp
//
//  Created by Deepak on 10/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChatViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ChatViewController *chatViewController;

@end
