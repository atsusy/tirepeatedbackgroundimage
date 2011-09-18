//
//  TiUIView+RepeatedBackgroundImage.m
//  tiuiviewrepeatedbackgroundimage
//
//  Created by KATAOKA,Atsushi on 11/07/07.
//  Copyright 2011 MARSHMALLOW MACHINE. All rights reserved.
//

#import "TiUIView+RepeatedBackgroundImage.h"
#import "ImageLoader.h"

@implementation TiUIView (TiUIView_RepeatedBackgroundImage)
-(void)setRepeatedBackgroundImage_:(id)image
{
    NSURL *bgURL = [TiUtils toURL:image proxy:proxy];
    NSLog(@"[DEBUG] repeatedBackgroundImage bgURL:%@", [bgURL absoluteString]);
    UIImage *bgImage = [[ImageLoader sharedLoader] loadImmediateImage:bgURL];
    
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}
@end
