//
//  User.h
//  VideoChatApp
//
//  Created by Deepak on 13/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, strong) QBUUser *currentQBUser;

+ (User *) sharedInstance;

@end
