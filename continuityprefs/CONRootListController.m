#include "CONRootListController.h"

@implementation CONRootListController

-(void) viewDidLoad{
	[super viewDidLoad];
	self.navigationItem.title = @"Continuity";
	UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ContinuityPrefs.bundle/icon.png"]];
	self.navigationItem.titleView = iconView;
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
		for(PSSpecifier *specifier in _specifiers){
			NSString *name = [specifier propertyForKey:@"key"];
			if([name isEqual:@"dev"]){
				int preferredHeight = 130;
				NSNumber *newHeight = [NSNumber numberWithInt:preferredHeight];
				[specifier setProperty:newHeight forKey:@"height"];
				[self reloadSpecifier:specifier animated:NO];
			}
		}
	}

	return _specifiers;
}

-(void)selectImage{
	
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.allowsEditing = NO;
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentViewController:picker animated:YES completion: nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
	UIImage *image = info[UIImagePickerControllerOriginalImage];
	[picker dismissViewControllerAnimated: YES completion: nil];
	NSString *path = @"/var/mobile/Documents/continuity.jpg";//@"/Library/PreferenceBundles/ContinuityPrefs.bundle/image.png";
	// NSURL *url = [NSURL URLWithString:path];
	NSData *imageData = UIImageJPEGRepresentation(image, 1.0); 
    if([imageData writeToFile:path atomically:YES]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wallpaper Set!"
		message:@"Please respring your device."
		delegate:nil
		cancelButtonTitle:@"Ok!"
		otherButtonTitles:nil];
		[alert show];
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hmmmm"
		message:@"Something went wrong. Try Again."
		delegate:nil
		cancelButtonTitle:@"Ok!"
		otherButtonTitles:nil];
		[alert show];
	}
	
}

-(void)respring {
	pid_t pid;
	const char* args[] = {"killall", "-9", "SpringBoard", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

-(void)website{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://johnnywaity.com"]];
}
-(void)twitter{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/johnnywaity"]];
}
-(void)github{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/johnnyjwaity"]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	if(section == 0){
		return [UIScreen mainScreen].bounds.size.width * 0.25f;
	}
	return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	if(section == 0){
		UIImageView *banner = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ContinuityPrefs.bundle/banner.png"]];
		// red.backgroundColor = [UIColor redColor];
		return banner;
	}
	return nil;
}


@end
