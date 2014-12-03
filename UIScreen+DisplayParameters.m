//
//  UIScreen+DisplayParameters.m
//
//  Created by Accid Bright on 03.12.2014.
//  Copyright (c) 2014 ABCorp. All rights reserved.
//

#import "UIScreen+DisplayParameters.h"

@implementation UIScreen (DisplayParameters)

+ (BOOL) isRetinaDisplay {
    return [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale > 1;
}

+ (UIScreenDevice)deviceScreen {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if([UIScreen isRetinaDisplay]) {
            return UIScreenPadRetina;
        } else {
            return UIScreenPad;
        }
    } else {
        if([UIScreen isRetinaDisplay]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            CGFloat height = MAX(result.height, result.width);
            if(height == 480) {
                return UIScreenPhoneRetina;
            } else if(height == 568) {
                return UIScreenPhone5;
            } else if (height == 667) {
                return UIScreenPhone6;
            } else if (height == 736) {
                return UIScreenPhone6Plus;
            }
        }
        return UIScreenPhone;
    }
}

+ (BOOL)deviceScreenPhone6And6Plus {
    UIScreenDevice deviceScreen = [UIScreen deviceScreen];
    return (deviceScreen == UIScreenPhone6 || deviceScreen == UIScreenPhone6Plus);
}

+ (BOOL)deviceScreenPhone3Inch {
    UIScreenDevice deviceScreen = [UIScreen deviceScreen];
    return (deviceScreen == UIScreenPhone || deviceScreen == UIScreenPhoneRetina);
}

@end
