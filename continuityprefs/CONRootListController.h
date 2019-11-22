#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>
#import "PSSpecifier.h"
#import <spawn.h>


@interface CONRootListController : PSListController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
-(void)selectImage;
-(void)respring;
-(void)website;
-(void)twitter;
-(void)github;
@end

