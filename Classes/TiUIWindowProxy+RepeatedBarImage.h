//
//  TiUIWindowProxy+RepeatedBarImage.h
//  repeatedbackgroundimage
//
//  Created by KATAOKA,Atsushi on 11/09/18.
//  Copyright 2011年 MARSHMALLOW MACHINE. All rights reserved.
//
#define USE_TI_UIWINDOW

#import <Foundation/Foundation.h>
#import "TiUIWindow.h"
#import "TiUIWindowProxy.h"

@interface TiUIWindow (TiUIWindow_RepeatedBarImage)
-(void)setRepeatedBarImage_:(id)image;
@end

@interface TiUIWindowProxy (TiUIWindowProxy_RepeatedBarImage)
-(void)setRepeatedBarImage_:(id)image;
@end
