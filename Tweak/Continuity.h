#include <UIKit/UIKit.h>
#include <GcUniversal/GcImagePickerUtils.h>

@interface SBHomeScreenView : UIView
	- (id)initWithFrame:(struct CGRect )arg0 ;
@end

@interface SBDockView:UIView
	- (UIView *)backgroundView;
@end

@interface SBIconScrollView:UIScrollView
	- (UIImage *)cropWallaper;
	- (UIImage *)aspectFillToSize:(CGSize)size withImage:(UIImage *)oldImage;
@end

static BOOL enabled;
static BOOL didScroll = NO;
static int paralaxModifier = 1;

static SBDockView *dock = nil;
static UILabel *testLabel = nil;
static UIImage *wallpaperImage = nil;
static UIImageView *wallpaperView = nil;
static SBIconScrollView *mainScreen = nil;

static NSUserDefaults *preferences;