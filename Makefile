# Configuración de arquitecturas para iPhones modernos
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
DEBUG = 0
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

# Nombre de tu dylib (puedes cambiar DominioFlex por el que quieras)
TWEAK_NAME = DominioFlex

# El archivo de código DEBE llamarse Tweak.x para que funcionen los parches
DominioFlex_FILES = Tweak.x
DominioFlex_CFLAGS = -fobjc-arc
DominioFlex_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
