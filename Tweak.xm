
@interface SBDockView:UIView
-(UIView *)backgroundView;
@end

SBDockView *dock = nil;

%hook SBDockView
-(id)initWithDockListView:(id)arg1 forSnapshot:(BOOL)arg2 {
	dock = %orig;
	// dock.backgroundColor = [UIColor blackColor];
	return dock;
}
%end

@interface SBIconScrollView:UIScrollView
@end
BOOL didScroll = NO;
// int scrollCount = 0;
%hook SBIconScrollView
-(void)_notifyDidScroll{
	
	[self.superview sendSubviewToBack: self];
	// scrollCount += 1;
	// if(scrollCount == 10){
		if(didScroll == NO){
			didScroll = YES;
			UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(-[UIScreen mainScreen].bounds.size.width / 2, 0, self.contentSize.width + [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
			view.contentMode = UIViewContentModeScaleAspectFill;
			UIImage *image = [UIImage imageWithContentsOfFile:@"/var/mobile/Documents/continuity.jpg"];
			view.image = image;
			// view.backgroundColor = [UIColor whiteColor];
			[self insertSubview:view atIndex: 0];

			[[dock backgroundView] removeFromSuperview];
		}
	// }
	%orig;
}
%end

