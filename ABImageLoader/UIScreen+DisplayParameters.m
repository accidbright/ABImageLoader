//
//  UIScreen+DisplayParameters.m
//  Pods
//
//  Created by Ihar Patsousky on 2/8/17.
//
//

#import "UIScreen+DisplayParameters.h"

@implementation UIScreen (DisplayParameters)

+ (BOOL) isRetinaDisplay {
    return [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale > 1;
}

+ (UIScreenDevice)deviceScreen {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return [self padScreen];
    }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self phoneScreen];
    }
    return UIScreenUnknown;
}

+ (UIScreenScaled)deviceScreenScaled {
    if (![UIScreen isRetinaDisplay]) {
        return UIScreenScaledSingle;
    } else if ([UIScreen mainScreen].scale <= 2) {
        return UIScreenScaledDouble;
    } else {
        return UIScreenScaledTriple;
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

+ (UIScreenDevice)padScreen {
    CGFloat screenHeight = [self screenHeight];
    if ([UIScreen isRetinaDisplay]) {
        if (screenHeight == 1112) {
            return UIScreenPadPro10Inch;
        }
        if (screenHeight == 1366) {
            return UIScreenPadPro10Inch;
        }
        return UIScreenPadRetina;
    }
    return UIScreenPad;
}

+ (UIScreenDevice)phoneScreen {
    CGFloat screenHeight = [self screenHeight];
    if ([UIScreen isRetinaDisplay]) {
        if(screenHeight == 568) {
            return UIScreenPhone5;
        }
        if (screenHeight == 667) {
            return UIScreenPhone6;
        }
        if (screenHeight == 736) {
            return UIScreenPhone6Plus;
        }
        if (screenHeight == 812) {
            return UIScreenPhoneX;
        }
        return UIScreenPhoneRetina;
    }
    return UIScreenPhone;
}

+ (CGFloat)screenHeight {
    CGSize result = [[UIScreen mainScreen] bounds].size;
    return MAX(result.width, result.height);
}

@end
