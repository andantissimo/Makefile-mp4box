## MP4Box

GPAC_VERSION = 0.7.1

all: bin/MP4Box

bin/MP4Box:
	cd src/gpac-$(GPAC_VERSION) && \
	./configure --prefix=$(PWD) --mandir=$(PWD)/share/man \
		--static-mp4box \
		--sdl-cfg=$(shell which false) \
		--disable-ipv6 --disable-ssl --disable-platinum \
		--disable-wx --disable-x11 --disable-x11-shm --disable-x11-xv \
		--disable-alsa --disable-oss-audio --disable-jack --disable-pulseaudio \
		--disable-dvb4linux \
		--use-js=no --use-ft=no \
		--use-faad=no --use-mad=no --use-xvid=no --use-ffmpeg=no \
		--use-ogg=no --use-vorbis=no --use-theora=no \
		--use-openjpeg=no --use-a52=no && \
	$(MAKE) && \
	$(MAKE) install clean
