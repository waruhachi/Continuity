  #include "CONDevCell.h"

@implementation CONDevCell
-(id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DevCell" specifier:arg3];
    UIImageView *profile = [[UIImageView alloc] initWithFrame: CGRectMake(15, 15, 100, 100)];
    profile.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/ContinuityPrefs.bundle/me.jpg"];
    profile.layer.cornerRadius = 50;
    profile.layer.masksToBounds = YES;
    [self addSubview:profile];

    UILabel *name = [[UILabel alloc] initWithFrame: CGRectMake(130, 0, 300, 130)];
    [name setText:@"Johnny Waity"];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont boldSystemFontOfSize:25];
    [self addSubview: name];
    return self;
}
@end