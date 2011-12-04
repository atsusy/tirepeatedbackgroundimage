#import <UIKit/UIKit.h>

#define kSCNavigationBarBackgroundImageTag 6183746

@interface UINavigationBar (BackgroundImage)

- (void)scInsertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)scSendSubviewToBack:(UIView *)view;

@end