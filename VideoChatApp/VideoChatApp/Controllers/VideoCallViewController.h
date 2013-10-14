//
//  VideoCallViewController.h
//  VideoChatApp
//
//  Created by Deepak on 13/10/13.
//  Copyright (c) 2013 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoCallViewController : UIViewController  <QBChatDelegate, AVAudioPlayerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) QBUUser *receiver;
@end
