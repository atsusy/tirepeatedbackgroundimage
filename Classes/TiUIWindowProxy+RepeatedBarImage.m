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

@implementation TiUIWindow (TiUIWindow_RepeatedBarImage)

-(void)setRepeatedBarImage_:(id)image
{	
    ENSURE_UI_THREAD(setRepeatedBarImage, image);
    
    NSURL *bgURL = [TiUtils toURL:image proxy:self.proxy];    
    NSLog(@"[DEBUG] repeatedBarImage bgURL:%@", [bgURL absoluteString]);

    [(id)self.proxy setRepeatedBarImage_:bgURL];
}
@end

@implementation TiUIWindowProxy (TiUIWindowProxy_RepeatedBarImage)

-(void)updateRepeatedBarImage
{
	UINavigationBar *ourNB = [[controller navigationController] navigationBar];
	CGRect barFrame = [ourNB bounds];    
	UIImage *newImage = [TiUtils toImage:[self valueForUndefinedKey:@"repeatedBarImage"]
                                   proxy:self size:barFrame.size];

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

-(void)setRepeatedBarImage_:(id)value
{
	[self replaceValue:[self sanitizeURL:value] 
                forKey:@"repeatedBarImage" 
          notification:NO];
	
    if (controller!=nil)
	{
		[self performSelectorOnMainThread:@selector(updateRepeatedBarImage) 
                               withObject:nil 
                            waitUntilDone:NO];
	}
}

@end
