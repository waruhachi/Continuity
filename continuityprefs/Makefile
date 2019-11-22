include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ContinuityPrefs

ContinuityPrefs_FILES = CONRootListController.m CONDevCell.m
ContinuityPrefs_INSTALL_PATH = /Library/PreferenceBundles
ContinuityPrefs_FRAMEWORKS = UIKit
ContinuityPrefs_PRIVATE_FRAMEWORKS = Preferences
ContinuityPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ContinuityPrefs.plist$(ECHO_END)
