#include "Continuity.h"

%hook SBIconScrollView

- (void)_notifyDidScroll {
	if (mainScreen == nil) {
		mainScreen = self;
	}

	if (self == mainScreen) {
		CGRect newFrame = CGRectMake(-(self.contentOffset.x / paralaxModifier) - ([UIScreen mainScreen].bounds.size.width / (paralaxModifier * 2)), 0, self.contentSize.width + [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
		wallpaperView.frame = newFrame;
	}

	%orig;
}

%new
- (UIImage *)aspectFillToSize:(CGSize)size withImage:(UIImage *)oldImage {
    CGSize scaledSize;
    CGFloat imgAspect = oldImage.size.width / oldImage.size.height;
    CGFloat sizeAspect = oldImage.size.width/oldImage.size.height;

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

%end

%hook SBHomeScreenView

- (id)initWithFrame:(CGRect)arg1 {
	SBHomeScreenView *view = %orig;

	wallpaperView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 745, 736)];
	wallpaperView.image = wallpaperImage;
	wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
	[wallpaperView setClipsToBounds:YES];
	[view addSubview:wallpaperView];
	[view sendSubviewToBack:wallpaperView];
	
	[[dock backgroundView] removeFromSuperview];

	return view;
}

%end

%ctor {
    preferences = [[NSUserDefaults alloc] initWithSuiteName:@"com.johnnywaity.continuity.preferences"];

	enabled = [preferences boolForKey:@"enabled"];
	wallpaperImage = [GcImagePickerUtils imageFromDefaults:@"com.johnnywaity.continuity.preferences" withKey:@"wallpaper"];

	if (enabled) {
		%init();
	}
}