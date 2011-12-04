#import "UINavigationBar+BackgroundImage.h"

@implementation UINavigationBar (BackgroundImage)

- (void)scInsertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [self scInsertSubview:view atIndex:index];
    
    UIView *backgroundImageView = [self viewWithTag:kSCNavigationBarBackgroundImageTag];
    if (backgroundImageView != nil)
    {
        [self scSendSubviewToBack:backgroundImageView];
    }
}

- (void)scSendSubviewToBack:(UIView *)view
{
    [self scSendSubviewToBack:view];
    
    UIView *backgroundImageView = [self viewWithTag:kSCNavigationBarBackgroundImageTag];
    if (backgroundImageView != nil)
    {
        [self scSendSubviewToBack:backgroundImageView];
    }
}

@end