# MP4Box

PREFIX ?= /opt/gpac

GPAC_VERSION = svn-r4027

all: $(PREFIX)/bin/MP4Box

$(PREFIX)/bin/MP4Box:
	cd src/gpac-$(GPAC_VERSION) && \
	./configure --prefix=$(PREFIX) --mandir=$(PREFIX)/share/man --strip \
		--static-mp4box \
		--sdl-cfg=/usr/bin/false \
		--disable-ipv6 --disable-ssl --disable-platinum \
		--disable-wx --disable-x11-shm --disable-x11-xv \
		--disable-alsa --disable-oss-audio --disable-jack --disable-pulseaudio \
		--disable-dvb4linux \
		--use-js=no --use-ft=no \
		--use-faad=no --use-mad=no --use-xvid=no --use-ffmpeg=no \
		--use-ogg=no --use-vorbis=no --use-theora=no \
		--use-openjpeg=no --use-a52=no && \
	$(MAKE) && \
	$(MAKE) install clean
