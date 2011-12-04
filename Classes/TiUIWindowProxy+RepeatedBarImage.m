//
//  TiUIWindowProxy+RepeatedBarImage.m
//  repeatedbackgroundimage
//
//  Created by KATAOKA,Atsushi on 11/09/18.
//  Copyright 2011 MARSHMALLOW MACHINE. All rights reserved.
//

#import "TiUIWindowProxy+RepeatedBarImage.h"
#import "UINavigationBar+BackgroundImage.h"
#import "ImageLoader.h"
#import "SCClassUtils.h"

#define REPEATED_BAR_IMAGE_TAG kSCNavigationBarBackgroundImageTag

@implementation TiUIWindowProxy (TiUIWindowProxy_RepeatedBarImage)

static BOOL methodSwizzled = NO;

-(void)updateRepeatedBarImage
{
	UINavigationBar *ourNB = [[controller navigationController] navigationBar];
	CGRect barFrame = [ourNB bounds];    
	UIImage *newImage = [TiUtils toImage:[self valueForUndefinedKey:@"repeatedBarImage"]
                                   proxy:self size:barFrame.size];

    if(!methodSwizzled)
    {
        [SCClassUtils swizzleSelector:@selector(insertSubview:atIndex:)
                              ofClass:[UINavigationBar class]
                         withSelector:@selector(scInsertSubview:atIndex:)];
        [SCClassUtils swizzleSelector:@selector(sendSubviewToBack:)
                              ofClass:[UINavigationBar class]
                         withSelector:@selector(scSendSubviewToBack:)];
        methodSwizzled = YES;
        NSLog(@"[DEBUG] method swizzled.");
    }
    else
    {
        NSLog(@"[DEBUG] method is already swizzled.");
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_4_3
    // iOS 5 new UINavigationBar custom background
    if([ourNB respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        NSLog(@"[DEBUG]UINavigationBar setBackgroundImage:forBarMetrics: used.");
        
        if(newImage == nil)
        {
            [ourNB setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
            return;
        }
        
        CGRect r;
        if([TiUtils isRetinaDisplay]){
            UIGraphicsBeginImageContextWithOptions(ourNB.frame.size, YES, 2.0);
            if(newImage.scale == 2.0){
                NSLog(@"[DEBUG] barImage is ready for Retina display.");
                r = CGRectMake(0.0f, 0.0f, CGImageGetWidth(newImage.CGImage)/2.0, CGImageGetHeight(newImage.CGImage)/2.0);
            }else{
                NSLog(@"[DEBUG] barImage is not ready for Retina display.");
                r = CGRectMake(0.0f, 0.0f, CGImageGetWidth(newImage.CGImage), CGImageGetHeight(newImage.CGImage));
            }
        }else{
            UIGraphicsBeginImageContext(ourNB.frame.size);
            r = CGRectMake(0.0f, 0.0f, CGImageGetWidth(newImage.CGImage), CGImageGetHeight(newImage.CGImage));
        }
        
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, ourNB.frame.size.height );
        CGContextScaleCTM(UIGraphicsGetCurrentContext(),  1.0, -1.0);

        CGContextDrawTiledImage(UIGraphicsGetCurrentContext(), r, newImage.CGImage);
        [ourNB setBackgroundImage:UIGraphicsGetImageFromCurrentImageContext() 
                    forBarMetrics:UIBarMetricsDefault];

        UIGraphicsEndImageContext();
        return;
    } 
#endif
    
    UIView *repeatedBarView = [ourNB viewWithTag:REPEATED_BAR_IMAGE_TAG];
	if(newImage == nil)
    {
        if(repeatedBarView)
        {
            [repeatedBarView removeFromSuperview];
        }
    }
    else if(repeatedBarView == nil)
    {
        repeatedBarView = [[UIView alloc] init]; 

        [repeatedBarView setTag:REPEATED_BAR_IMAGE_TAG];
        [repeatedBarView setUserInteractionEnabled:NO];
        [repeatedBarView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [repeatedBarView setBackgroundColor:[UIColor colorWithPatternImage:newImage]];
        [repeatedBarView setFrame:barFrame];
        
        [ourNB insertSubview:repeatedBarView atIndex:0];
        [repeatedBarView release];
    }
}

-(void)setRepeatedBarImage:(id)value
{
    NSURL *bgURL = [TiUtils toURL:value proxy:self];
    NSLog(@"[DEBUG] [TiUIWindowProxy]repeatedBarImage bgURL:%@", [bgURL absoluteString]);
    
    [self replaceValue:[self sanitizeURL:bgURL] 
                forKey:@"repeatedBarImage" 
          notification:NO];
	
    if (controller!=nil)
	{
		[self performSelectorOnMainThread:@selector(updateRepeatedBarImage) 
                               withObject:nil 
                            waitUntilDone:YES];
	}
}

@end
