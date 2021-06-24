#line 1 "Tweak.xm"
@interface SBDockView:UIView
-(UIView *)backgroundView;
@end
@interface SBIconScrollView:UIScrollView
-(UIImage *)cropWallaper;
- (UIImage *)aspectFillToSize:(CGSize)size withImage:(UIImage *)oldImage;
@end

#define SETTINGS_PATH "/var/mobile/Library/Preferences/com.johnnywaity.continuityprefs.plist"
#define boolValueForKey(key) [[[NSDictionary dictionaryWithContentsOfFile:@(SETTINGS_PATH)] valueForKey:key] boolValue]

UILabel *testLabel = nil;
UIImageView *wallpaperView = nil;
UIImage *wallpaperImage = nil;
SBDockView *dock = nil;
BOOL didScroll = NO;
SBIconScrollView *mainScreen = nil;
int paralaxModifier = 1;





#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBIconScrollView; @class SBDockView; @class SBHomeScreenView; 


#line 23 "Tweak.xm"
static SBDockView* (*_logos_orig$Universal$SBDockView$initWithDockListView$forSnapshot$)(_LOGOS_SELF_TYPE_INIT SBDockView*, SEL, id, BOOL) _LOGOS_RETURN_RETAINED; static SBDockView* _logos_method$Universal$SBDockView$initWithDockListView$forSnapshot$(_LOGOS_SELF_TYPE_INIT SBDockView*, SEL, id, BOOL) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$Universal$SBIconScrollView$_notifyDidScroll)(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$Universal$SBIconScrollView$_notifyDidScroll(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static UIImage * _logos_method$Universal$SBIconScrollView$aspectFillToSize$withImage$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL, CGSize, UIImage *); static SBHomeScreenView* (*_logos_orig$Universal$SBHomeScreenView$initWithFrame$)(_LOGOS_SELF_TYPE_INIT SBHomeScreenView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; static SBHomeScreenView* _logos_method$Universal$SBHomeScreenView$initWithFrame$(_LOGOS_SELF_TYPE_INIT SBHomeScreenView*, SEL, CGRect) _LOGOS_RETURN_RETAINED; 

static SBDockView* _logos_method$Universal$SBDockView$initWithDockListView$forSnapshot$(_LOGOS_SELF_TYPE_INIT SBDockView* __unused self, SEL __unused _cmd, id arg1, BOOL arg2) _LOGOS_RETURN_RETAINED {
	dock = _logos_orig$Universal$SBDockView$initWithDockListView$forSnapshot$(self, _cmd, arg1, arg2);
	return dock;
}



static void _logos_method$Universal$SBIconScrollView$_notifyDidScroll(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	if(mainScreen == nil){
		mainScreen = self;
		
	}
	if(self == mainScreen){
		CGRect newFrame = CGRectMake(-(self.contentOffset.x / paralaxModifier) - ([UIScreen mainScreen].bounds.size.width / (paralaxModifier * 2)), 0, self.contentSize.width + [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
		
		wallpaperView.frame = newFrame;
		






	}
	_logos_orig$Universal$SBIconScrollView$_notifyDidScroll(self, _cmd);
}

static UIImage * _logos_method$Universal$SBIconScrollView$aspectFillToSize$withImage$(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CGSize size, UIImage * oldImage){
    CGFloat imgAspect = oldImage.size.width / oldImage.size.height;
    CGFloat sizeAspect = oldImage.size.width/oldImage.size.height;

    CGSize scaledSize;

        if (sizeAspect > imgAspect) { 
            scaledSize = CGSizeMake(oldImage.size.width, oldImage.size.width / imgAspect);
        } else { 
            scaledSize = CGSizeMake(oldImage.size.height * imgAspect, oldImage.size.height);
        }
    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToRect(context, CGRectMake(0, 0, oldImage.size.width, oldImage.size.height));
    [oldImage drawInRect:CGRectMake(0.0f, 0.0f, scaledSize.width, scaledSize.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}





static SBHomeScreenView* _logos_method$Universal$SBHomeScreenView$initWithFrame$(_LOGOS_SELF_TYPE_INIT SBHomeScreenView* __unused self, SEL __unused _cmd, CGRect arg1) _LOGOS_RETURN_RETAINED{
	SBHomeScreenView *view = _logos_orig$Universal$SBHomeScreenView$initWithFrame$(self, _cmd, arg1);
	wallpaperImage = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/continuity.jpg"];
	wallpaperView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 745, 736)];
	wallpaperView.image = wallpaperImage;
	[wallpaperView setClipsToBounds:YES];
	wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
	[view addSubview:wallpaperView];
	[view sendSubviewToBack:wallpaperView];
	
	[[dock backgroundView] removeFromSuperview];
	return view;
}



static __attribute__((constructor)) void _logosLocalCtor_ae792fb9(int __unused argc, char __unused **argv, char __unused **envp){
	if(boolValueForKey(@"enabled")){



















		{Class _logos_class$Universal$SBDockView = objc_getClass("SBDockView"); MSHookMessageEx(_logos_class$Universal$SBDockView, @selector(initWithDockListView:forSnapshot:), (IMP)&_logos_method$Universal$SBDockView$initWithDockListView$forSnapshot$, (IMP*)&_logos_orig$Universal$SBDockView$initWithDockListView$forSnapshot$);Class _logos_class$Universal$SBIconScrollView = objc_getClass("SBIconScrollView"); MSHookMessageEx(_logos_class$Universal$SBIconScrollView, @selector(_notifyDidScroll), (IMP)&_logos_method$Universal$SBIconScrollView$_notifyDidScroll, (IMP*)&_logos_orig$Universal$SBIconScrollView$_notifyDidScroll);{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(CGSize), strlen(@encode(CGSize))); i += strlen(@encode(CGSize)); memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$Universal$SBIconScrollView, @selector(aspectFillToSize:withImage:), (IMP)&_logos_method$Universal$SBIconScrollView$aspectFillToSize$withImage$, _typeEncoding); }Class _logos_class$Universal$SBHomeScreenView = objc_getClass("SBHomeScreenView"); MSHookMessageEx(_logos_class$Universal$SBHomeScreenView, @selector(initWithFrame:), (IMP)&_logos_method$Universal$SBHomeScreenView$initWithFrame$, (IMP*)&_logos_orig$Universal$SBHomeScreenView$initWithFrame$);} } }                
