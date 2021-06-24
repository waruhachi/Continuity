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




%group Universal
%hook SBDockView
-(id)initWithDockListView:(id)arg1 forSnapshot:(BOOL)arg2 {
	dock = %orig;
	return dock;
}
%end

%hook SBIconScrollView
-(void)_notifyDidScroll{
	if(mainScreen == nil){
		mainScreen = self;
		
	}
	if(self == mainScreen){
		CGRect newFrame = CGRectMake(-(self.contentOffset.x / paralaxModifier) - ([UIScreen mainScreen].bounds.size.width / (paralaxModifier * 2)), 0, self.contentSize.width + [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
		// wallpaperView.image = [self aspectFillToSize:newFrame.size withImage:wallpaperImage];
		wallpaperView.frame = newFrame;
		// wallpaperView.contentMode = UIViewContentModeScaleAspectFill;
// 		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Layout"
// message:NSStringFromCGRect(newFrame)
// delegate:nil
// cancelButtonTitle:@"Ok!"
// otherButtonTitles:nil];
// [alert show];
	}
	%orig;
}
%new
-(UIImage *)aspectFillToSize:(CGSize)size withImage:(UIImage *)oldImage{
    CGFloat imgAspect = oldImage.size.width / oldImage.size.height;
    CGFloat sizeAspect = oldImage.size.width/oldImage.size.height;

    CGSize scaledSize;

        if (sizeAspect > imgAspect) { // increase width, crop height
            scaledSize = CGSizeMake(oldImage.size.width, oldImage.size.width / imgAspect);
        } else { // increase height, crop width
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
-(id)initWithFrame:(CGRect)arg1{
	SBHomeScreenView *view = %orig;
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
%end
%end

%ctor{
	if(boolValueForKey(@"enabled")){
		%init(Universal)
	}
}


// UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Layout"
// message:@"Please respring your device."
// delegate:nil
// cancelButtonTitle:@"Ok!"
// otherButtonTitles:nil];
// [alert show];

// UIView *test = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
// test.backgroundColor = [UIColor redColor];
// testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,2,300,100)];
// [test addSubview:testLabel];
// [testLabel setText:@"Hello"];
// [view addSubview:test];
// [view sendSubviewToBack:test];
