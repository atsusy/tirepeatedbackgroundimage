#import </usr/include/objc/objc-class.h>
#import <Foundation/Foundation.h>

@interface SCClassUtils : NSObject
{
}

+ (void)swizzleSelector:(SEL)orig ofClass:(Class)c withSelector:(SEL)new;

@end