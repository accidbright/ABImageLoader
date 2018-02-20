//
//  UIScreen+DisplayParameters.h
//  Pods
//
//  Created by Ihar Patsousky on 2/8/17.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    UIScreenUnknown = 0,
    UIScreenPhone,
    UIScreenPhoneRetina,
    UIScreenPhone5,
    UIScreenPhone6,
    UIScreenPhone6Plus,
    UIScreenPhoneX,
    UIScreenPad,
    UIScreenPadRetina,
    UIScreenPadPro10Inch,
    UIScreenPadPro12Inch
} UIScreenDevice;

typedef enum {
    UIScreenScaledSingle,
    UIScreenScaledDouble,
    UIScreenScaledTriple
} UIScreenScaled;

@interface UIScreen (DisplayParameters)

+ (UIScreenDevice)deviceScreen;
+ (UIScreenScaled)deviceScreenScaled;
+ (BOOL)isRetinaDisplay;
+ (BOOL)deviceScreenPhone6And6Plus;
+ (BOOL)deviceScreenPhone3Inch;

@end
