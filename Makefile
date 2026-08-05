ARCHS = arm64
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

TARGET = iphone:clang:latest:latest
CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = iOSImGui

$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation Security QuartzCore CoreGraphics CoreText AVFoundation Accelerate GLKit SystemConfiguration GameController

# DÜZELTME 1: _CCFLAGS yerine _CXXFLAGS kullanıldı
$(TWEAK_NAME)_CXXFLAGS = -std=c++11 -fno-rtti -fno-exceptions -stdlib=libc++ -DNDEBUG

$(TWEAK_NAME)_CFLAGS = -fobjc-arc -w
$(TWEAK_NAME)_FILES = Menu.mm Mods.mm $(wildcard ImGui/*.mm) $(wildcard ImGui/*.cpp) $(wildcard Includes/*.mm) $(wildcard Includes/*.m) $(wildcard Includes/*.cpp) $(wildcard Includes/Esp/*.m) $(wildcard Includes/Hooking/*.mm) $(wildcard Includes/SCLAlertView/*.m)

$(TWE_NAME)_LIBRARIES += substrate
$(TWEAK_NAME)_LDFLAGS += -L./Includes/Libs

# DÜZELTME 2: -lc++ eklendi (C++ kütüphanelerinin bağlanması için şart)
$(TWEAK_NAME)_LDFLAGS += -lz -stdlib=libc++ -lc++ -ldobby_fixed

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS)/makefiles/aggregate.mk

after-install::
	install.exec "killall -9 Springboard || :"