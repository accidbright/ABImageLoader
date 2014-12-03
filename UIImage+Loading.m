//
//  UIImage+Loading.m
//
//  Created by Accid Bright on 03.12.2014.
//  Copyright (c) 2014 ABCorp. All rights reserved.
//

#import "UIImage+Loading.h"
#import "UIScreen+DisplayParameters.h"

@implementation UIImage (Loading)

+ (UIImage *)imageWithName:(NSString *)fileName {
    NSString * pathExtension = @"png";
    NSString * filePath = nil;
    if (fileName.pathExtension.length) {
        pathExtension = fileName.pathExtension;
        fileName = [fileName stringByDeletingPathExtension];
    }
    
    NSString * orientation = UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? @"-portrait" : @"-landscape";
    filePath = [self pathToImageWithName:fileName withOrientation:orientation withExtension:pathExtension];
    if (!filePath) {
        filePath = [self pathToImageWithName:fileName withOrientation:@"" withExtension:pathExtension];
    }
    
    UIImage * image = nil;
    if (filePath) {
        image = [UIImage imageNamed:filePath];
    }
    return image;
}

+ (NSString *)pathToImageWithName:(NSString *)fileName withOrientation:(NSString *)orientation withExtension:(NSString *)pathExtension {
    NSString * filePath = nil;
    if (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM()) {
        filePath = [self pathToImageForPadWithName:fileName withOrientation:orientation withDeviceIdentifier:@"~ipad" withExtension:pathExtension];
        if (!filePath) {
            filePath = [self pathToImageForPadWithName:fileName withOrientation:orientation withDeviceIdentifier:@"" withExtension:pathExtension];
        }
    } else {
        filePath = [self pathToImageForPhoneWithName:fileName withOrientation:orientation withDeviceIdentifier:@"~iphone" withExtension:pathExtension];
        if (!filePath) {
            filePath = [self pathToImageForPhoneWithName:fileName withOrientation:orientation withDeviceIdentifier:@"" withExtension:pathExtension];
        }
    }
    return filePath;
}

+ (NSString *)pathToImageForPadWithName:(NSString *)fileName withOrientation:(NSString *)orientation withDeviceIdentifier:(NSString *)deviceIdentifier withExtension:(NSString *)pathExtension {
    NSString * filePath = nil;
    if ([UIScreen isRetinaDisplay]) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    if (!filePath) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"" withScale:@"" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    return filePath;
}

+ (NSString *)pathToImageForPhoneWithName:(NSString *)fileName withOrientation:(NSString *)orientation withDeviceIdentifier:(NSString *)deviceIdentifier withExtension:(NSString *)pathExtension {
    NSString * filePath = nil;
    if ((UIScreenPhone6Plus == [UIScreen deviceScreen])) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-736h" withScale:@"@3x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    
    if ((UIScreenPhone6 == [UIScreen deviceScreen]) || (UIScreenPhone6Plus == [UIScreen deviceScreen] && !filePath)) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-667h" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    
    if ((UIScreenPhone5 == [UIScreen deviceScreen]) || ([UIScreen deviceScreenPhone6And6Plus] && !filePath)) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-568h" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    if (!filePath) {
        filePath = [self pathToImageForPadWithName:fileName withOrientation:orientation withDeviceIdentifier:deviceIdentifier withExtension:pathExtension];
    }
    return filePath;
}

+ (NSString *)pathToImageWithName:(NSString *)fileName withOrientation:(NSString *)orientation withScreenHeight:(NSString *)screenHeight withScale:(NSString *)scale withDeviceIdentifier:(NSString *)deviceIdentifier withPathExtension:(NSString *)pathExtention {
    NSString * bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString * fullPath = [NSString stringWithFormat:@"%@/%@%@%@%@%@.%@", bundlePath, fileName, orientation, screenHeight, scale, deviceIdentifier, pathExtention];
    NSString * filePath = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        filePath = [fullPath lastPathComponent];
    }
    NSLog(@"%@ (%@)", [fullPath lastPathComponent], filePath ? @"YES" : @"NO");
    return filePath;
}

@end
