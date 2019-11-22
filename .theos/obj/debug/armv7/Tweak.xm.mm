#line 1 "Tweak.xm"

@interface SBDockView:UIView
-(UIView *)backgroundView;
@end

SBDockView *dock = nil;


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

@class SBDockView; @class SBIconScrollView; 
static SBDockView* (*_logos_orig$_ungrouped$SBDockView$initWithDockListView$forSnapshot$)(_LOGOS_SELF_TYPE_INIT SBDockView*, SEL, id, BOOL) _LOGOS_RETURN_RETAINED; static SBDockView* _logos_method$_ungrouped$SBDockView$initWithDockListView$forSnapshot$(_LOGOS_SELF_TYPE_INIT SBDockView*, SEL, id, BOOL) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$_ungrouped$SBIconScrollView$_notifyDidScroll)(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconScrollView$_notifyDidScroll(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST, SEL); 

#line 8 "Tweak.xm"

static SBDockView* _logos_method$_ungrouped$SBDockView$initWithDockListView$forSnapshot$(_LOGOS_SELF_TYPE_INIT SBDockView* __unused self, SEL __unused _cmd, id arg1, BOOL arg2) _LOGOS_RETURN_RETAINED {
	dock = _logos_orig$_ungrouped$SBDockView$initWithDockListView$forSnapshot$(self, _cmd, arg1, arg2);
	
	return dock;
}


@interface SBIconScrollView:UIScrollView
@end
BOOL didScroll = NO;


static void _logos_method$_ungrouped$SBIconScrollView$_notifyDidScroll(_LOGOS_SELF_TYPE_NORMAL SBIconScrollView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
	
	[self.superview sendSubviewToBack: self];
	
	
		if(didScroll == NO){
			didScroll = YES;
			UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(-[UIScreen mainScreen].bounds.size.width / 2, 0, self.contentSize.width + [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
			view.contentMode = UIViewContentModeScaleAspectFill;
			UIImage *image = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/continuity.jpg"];
			view.image = image;
			
			[self insertSubview:view atIndex: 0];

			[[dock backgroundView] removeFromSuperview];
		}
	
	_logos_orig$_ungrouped$SBIconScrollView$_notifyDidScroll(self, _cmd);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBDockView = objc_getClass("SBDockView"); MSHookMessageEx(_logos_class$_ungrouped$SBDockView, @selector(initWithDockListView:forSnapshot:), (IMP)&_logos_method$_ungrouped$SBDockView$initWithDockListView$forSnapshot$, (IMP*)&_logos_orig$_ungrouped$SBDockView$initWithDockListView$forSnapshot$);Class _logos_class$_ungrouped$SBIconScrollView = objc_getClass("SBIconScrollView"); MSHookMessageEx(_logos_class$_ungrouped$SBIconScrollView, @selector(_notifyDidScroll), (IMP)&_logos_method$_ungrouped$SBIconScrollView$_notifyDidScroll, (IMP*)&_logos_orig$_ungrouped$SBIconScrollView$_notifyDidScroll);} }
#line 42 "Tweak.xm"
