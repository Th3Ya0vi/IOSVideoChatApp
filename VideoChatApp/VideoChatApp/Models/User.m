//
//  User.m
//  VideoChatApp
//
//  Created by Deepak on 13/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import "User.h"

@implementation User
static User *sharedInstance = nil;


+ (User *)sharedInstance {
	@synchronized (self) {
		if (sharedInstance == nil){
            sharedInstance = [[self alloc] init];
        }
	}
	return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        //historyConversation = [[NSMutableDictionary alloc] init];
        
        // logout
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutDone) name:kNotificationLogout object:nil];
    }
    return self;
}

@end
