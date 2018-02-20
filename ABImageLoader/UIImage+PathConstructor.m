//
//  UIImage+PathConstructor.m
//  Pods
//
//  Created by Ihar Patsousky on 2/8/17.
//
//

#import "UIImage+PathConstructor.h"
#import "UIScreen+DisplayParameters.h"

@implementation UIImage (PathConstructor)

#pragma mark - Path constructing methods

+ (NSString *)pathToImageWithName:(NSString *)fileName {
    NSString * pathExtension = @"png";
    NSString * filePath = nil;
    
    if (fileName.pathExtension.length >= 3) {
        pathExtension = fileName.pathExtension;
        fileName = [fileName stringByDeletingPathExtension];
    }
    
    NSString * orientation = UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? @"-portrait" : @"-landscape";
    filePath = [self pathToImageWithName:fileName withOrientation:orientation withExtension:pathExtension];
    if (!filePath) {
        filePath = [self pathToImageWithName:fileName withOrientation:@"" withExtension:pathExtension];
    }
    
    return filePath;
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
    if ([UIScreen deviceScreenScaled] == UIScreenScaledTriple) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"" withScale:@"@3x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    if ((UIScreenPadPro12Inch == [UIScreen deviceScreen])) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-1366h" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    if ((UIScreenPadPro10Inch == [UIScreen deviceScreen]) || (UIScreenPadPro12Inch == [UIScreen deviceScreen] && !filePath)) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-1112h" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    if (!filePath && [UIScreen isRetinaDisplay]) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    if (!filePath) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"" withScale:@"" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    return filePath;
}

+ (NSString *)pathToImageForPhoneWithName:(NSString *)fileName withOrientation:(NSString *)orientation withDeviceIdentifier:(NSString *)deviceIdentifier withExtension:(NSString *)pathExtension {
    NSString * filePath = nil;
    if ((UIScreenPhoneX == [UIScreen deviceScreen])) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-812h" withScale:@"@3x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    
    if ((UIScreenPhone6Plus == [UIScreen deviceScreen]) || (UIScreenPhoneX == [UIScreen deviceScreen] && !filePath)) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-736h" withScale:@"@3x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
        if (!filePath) {
            filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"" withScale:@"@3x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
        }
    }
    
    if ((UIScreenPhone6 == [UIScreen deviceScreen]) || (UIScreenPhone6Plus == [UIScreen deviceScreen] && !filePath)) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-667h" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    
    if ((UIScreenPhone5 == [UIScreen deviceScreen]) || ([UIScreen deviceScreenPhone6And6Plus] && !filePath)) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"-568h" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    if (!filePath && [UIScreen isRetinaDisplay]) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"" withScale:@"@2x" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    if (!filePath) {
        filePath = [UIImage pathToImageWithName:fileName withOrientation:orientation withScreenHeight:@"" withScale:@"" withDeviceIdentifier:deviceIdentifier withPathExtension:pathExtension];
    }
    return filePath;
}

+ (NSString *)pathToImageWithName:(NSString *)fileName withOrientation:(NSString *)orientation withScreenHeight:(NSString *)screenHeight withScale:(NSString *)scale withDeviceIdentifier:(NSString *)deviceIdentifier withPathExtension:(NSString *)pathExtention {
    NSString * bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString * fullFileName = [NSString stringWithFormat:@"%@%@%@%@%@.%@", fileName, orientation, screenHeight, scale, deviceIdentifier, pathExtention];
    NSString * fullPath = [bundlePath stringByAppendingPathComponent:fullFileName];
    NSString * language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    // Try to load file from bundle. If it isn't there, then try to find it in locale folder
    if (!fileExists) {
        fullPath = [NSString stringWithFormat:@"%@/%@.lproj/%@", bundlePath, language, fullFileName];
        fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    }
    // Try to find it in Base localization folder
    if (!fileExists) {
        fullPath = [NSString stringWithFormat:@"%@/Base.lproj/%@", bundlePath, fullFileName];
        fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    }
    return fileExists ? fullPath : nil;
}

@end
