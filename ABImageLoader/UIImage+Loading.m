//
//  UIImage+Loading.m
//
//  Created by Ihar Patsousky (Accid Bright) on 03.12.2014.
//  Copyright (c) 2014 ABCorp. All rights reserved.
//

#import <objc/runtime.h>
#import "UIImage+Loading.h"
#import "UIImage+PathConstructor.h"

@implementation UIImage (Loading)

+ (void)load {
    //Exchange XIB loading implementation
    Method m1 = class_getInstanceMethod(NSClassFromString(@"UIImageNibPlaceholder"), @selector(initWithCoder:));
    Method m2 = class_getInstanceMethod(self, @selector(initWithCoderAllImages:));
        method_exchangeImplementations(m1, m2);
        
    //Exchange imageNamed: implementation
    method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)),
                                       class_getClassMethod(self, @selector(imageWithName:)));
}

- (id)initWithCoderAllImages:(NSCoder *)aDecoder {
    NSString *resourceName = [aDecoder decodeObjectForKey:@"UIResourceName"];
    return [UIImage imageNamed:resourceName];
}

+ (UIImage *)imageWithName:(NSString *)fileName {
    NSString * filePath = [UIImage pathToImageWithName:fileName];
    NSLog(@"Path: %@", filePath);
    
    UIImage * image = nil;
    if (filePath) {
        image = [UIImage imageWithName:filePath];
    } else {
        image = [UIImage imageWithName:fileName];
    }
    return image;
}

@end
