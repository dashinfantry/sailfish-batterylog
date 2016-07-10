# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-batterylog

CONFIG += sailfishapp

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-batterylog-de.ts

HEADERS += \
    src/batteryinfo.h \
    src/screeninfo.h \
    src/infobase.h

SOURCES += \
    src/harbour-batterylog.cpp \
    src/batteryinfo.cpp \
    src/screeninfo.cpp \
    src/infobase.cpp

OTHER_FILES += \
    qml/harbour-batterylog.qml \
    rpm/harbour-batterylog.changes.in \
    rpm/harbour-batterylog.spec \
    rpm/harbour-batterylog.yaml \
    translations/*.ts \
    harbour-batterylog.desktop \
    qml/globals.js \
    qml/pages/MainPage.qml \
    qml/components/Logs.qml \
    qml/components/Battery.qml \
    qml/components/Graph.qml \
    qml/energylog.js \
    qml/powerlog.js \
    qml/pages/EventPage.qml \
    qml/components/Event.qml \
    qml/timeformat.js \
    qml/pages/AboutPage.qml \
    qml/gfx/about.png \
    qml/components/GraphLegendItemLeft.qml \
    qml/components/GraphLegendItemRight.qml \
    qml/components/GraphLegendCategory.qml \
    qml/pages/SettingsPage.qml \
    qml/storage.js \
    qml/components/Settings.qml \
    qml/components/ColorChooserDialog.qml \
    qml/components/ColorChooserItem.qml \
    qml/cover/MainCover.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256
