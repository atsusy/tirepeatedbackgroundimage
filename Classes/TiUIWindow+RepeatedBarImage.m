//
//  TiUIWindow+RepeatedBarImage.m
//  repeatedbackgroundimage
//
//  Created by KATAOKA,Atsushi on 11/09/20.
//  Copyright 2011年 MARSHMALLOW MACHINE. All rights reserved.
//

#import "TiUIWindow+RepeatedBarImage.h"
#import "TiUIWindowProxy+RepeatedBarImage.h"

@implementation TiUIWindow (TiUIWindow_RepeatedBarImage)
-(void)setRepeatedBarImage_:(id)image
{	
    NSURL *bgURL = [TiUtils toURL:image proxy:self.proxy];    
    NSLog(@"[DEBUG] repeatedBarImage bgURL:%@", [bgURL absoluteString]);
    
    [(id)self.proxy setRepeatedBarImage:bgURL];
}
@end
