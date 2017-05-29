PROJECT=snek
SRC=$(wildcard *.lua *.glsl) lib assets
ZIPFLAGS= -9
VERSION=$(shell git describe)
LOVE_VERSION=0.10.2
TARGET=$(PROJECT)-$(VERSION)
WINURL32=https://bitbucket.org/rude/love/downloads/love-$(LOVE_VERSION)-win32.zip
WINURL64=https://bitbucket.org/rude/love/downloads/love-$(LOVE_VERSION)-win64.zip
MACOSXURL64=https://bitbucket.org/rude/love/downloads/love-$(LOVE_VERSION)-macosx-x64.zip

# all: $(TARGET) win macosx
all: $(TARGET) macosx

$(TARGET): $(TARGET).love

$(TARGET).love: $(SRC)
	zip $@ $(ZIPFLAGS) -r $^

love-$(LOVE_VERSION)-win32.zip:
	wget $(WINURL32)

love-$(LOVE_VERSION)-win64.zip:
	wget $(WINURL64)

love-$(LOVE_VERSION)-macosx-x64.zip:
	wget $(MACOSXURL64)

win: $(TARGET)-win32 $(TARGET)-win64

$(TARGET)-win32: love-$(LOVE_VERSION)-win32.zip $(TARGET).love
	rm -rf $@
	rm -rf love-$(LOVE_VERSION)-win32
	unzip $<
	mv love-$(LOVE_VERSION)-win32 $@
	cat $@/love.exe $(TARGET).love > $@/$(PROJECT).exe
	rm $@/love.exe
	zip $@.zip -r $@

$(TARGET)-win64: love-$(LOVE_VERSION)-win64.zip $(TARGET).love
	rm -rf $@
	rm -rf love-$(LOVE_VERSION)-win64
	unzip $<
	mv love-$(LOVE_VERSION)-win64 $@
	cat $@/love.exe $(TARGET).love > $@/$(PROJECT).exe
	zip $@.zip -r $@

macosx: $(TARGET)-macosx-x64

$(TARGET)-macosx-x64: love-$(LOVE_VERSION)-macosx-x64.zip $(TARGET).love
	rm -rf $@
	rm -rf love-$(LOVE_VERSION)-macosx-x64
	unzip $<
	mv love.app $@.app
	cp $(TARGET).love $@.app/Contents/Resources/$(PROJECT).love

clean:
	rm -rf love-*
	rm -f *.love
	rm -f *.zip
	rm -rf $(TARGET)-win*
	rm -rf *.app
