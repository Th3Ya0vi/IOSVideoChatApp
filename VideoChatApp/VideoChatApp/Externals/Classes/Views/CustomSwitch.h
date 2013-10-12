//
//  CustomSwitch.h
//  ChattAR for Facebook
//
//  Created by QuickBlox developers on 6/6/12.
//  Copyright (c) 2012 QuickBlox. All rights reserved.
//

#import <UIKit/UIKit.h>

#define worldValue 0.94f
#define friendsValue 0.06f

@interface CustomSwitch : UISlider{
    BOOL on;

    // private member
    BOOL m_touchedSelf;
    
    BOOL valueChangedSelf;
}
@property(nonatomic,getter=isOn) BOOL on;

+ (CustomSwitch *) customSwitch;

- (void)setOn:(BOOL)on animated:(BOOL)animated;
- (void)scaleSwitch:(float)newSize;

- (void)valueDidChange;

@end

