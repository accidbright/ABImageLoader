//
//  UIScreen+DisplayParameters.h
//
//  Created by Accid Bright on 03.12.2014.
//  Copyright (c) 2014 ABCorp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UIScreenPhone,
    UIScreenPhoneRetina,
    UIScreenPhone5,
    UIScreenPhone6,
    UIScreenPhone6Plus,
    UIScreenPad,
    UIScreenPadRetina
} UIScreenDevice;

@interface UIScreen (DisplayParameters)
+ (UIScreenDevice)deviceScreen;
+ (BOOL)isRetinaDisplay;
+ (BOOL)deviceScreenPhone6And6Plus;
+ (BOOL)deviceScreenPhone3Inch;
@end
