//
//  TiUIWindowProxy+RepeatedBarImage.m
//  repeatedbackgroundimage
//
//  Created by KATAOKA,Atsushi on 11/09/18.
//  Copyright 2011年 MARSHMALLOW MACHINE. All rights reserved.
//

#import "TiUIWindowProxy+RepeatedBarImage.h"
#import "ImageLoader.h"

#define REPEATED_BAR_IMAGE_TAG 9876

@implementation TiUIWindowProxy (TiUIWindowProxy_RepeatedBarImage)

-(void)updateRepeatedBarImage
{
	UINavigationBar *ourNB = [[controller navigationController] navigationBar];
	CGRect barFrame = [ourNB bounds];    
	UIImage *newImage = [TiUtils toImage:[self valueForUndefinedKey:@"repeatedBarImage"]
                                   proxy:self size:barFrame.size];

    // iOS 5 new UINavigationBar custom background
    if([ourNB respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        NSLog(@"[DEBUG]UINavigationBar setBackgroundImage:forBarMetrics: used.");
        
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
    
    UIView *repeatedBarView = [ourNB viewWithTag:REPEATED_BAR_IMAGE_TAG];
	if(newImage == nil)
    {
        if(repeatedBarView){
            [repeatedBarView removeFromSuperview];
            RELEASE_TO_NIL(repeatedBarView);
            return;
        }
    }
    
    if(repeatedBarView == nil)
    {
        repeatedBarView = [[UIView alloc] init]; 
        [repeatedBarView setTag:REPEATED_BAR_IMAGE_TAG];
        [repeatedBarView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    }

    UIColor *newColor = [UIColor colorWithPatternImage:newImage];
    [repeatedBarView setBackgroundColor:newColor];
    [repeatedBarView setFrame:barFrame];
    
	if (![ourNB viewWithTag:REPEATED_BAR_IMAGE_TAG])
	{
		[ourNB insertSubview:repeatedBarView atIndex:0];
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
