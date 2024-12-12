## MP4Box

GPAC_VERSION = 2.4.0

all: bin/MP4Box

clean:
	$(RM) -r bin/gpac include lib share/gpac
	find share/man/man1 -type f -not -name 'mp4box.1' -delete

bin/MP4Box:
	cd src/gpac-$(GPAC_VERSION) && \
	./configure --prefix=$(PWD) --mandir=$(PWD)/share/man \
		--strip --static-bin --sdl-cfg=$(shell which false) \
		--disable-remotery --disable-x11 --disable-x11-shm --disable-x11-xv \
		--use-zlib=local --use-opensvc=no --use-openhevc=no --use-platinum=no \
		--use-freetype=no --use-ssl=no --use-jpeg=no --use-openjpeg=no \
		--use-png=no --use-mad=no --use-a52=no --use-xvid=no --use-faad=no \
		--use-ffmpeg=no --use-freenect=no --use-vorbis=no --use-theora=no \
		--use-nghttp2=no --use-oss=no --use-dvb4linux=no --use-alsa=no \
		--use-pulseaudio=no --use-jack=no --use-directfb=no --use-hid=no \
		--use-lzma=no --use-tinygl=no --use-vtb=no --use-ogg=no --use-sdl=no \
		--use-caption=no --use-mpeghdec=no --use-libcaca=no && \
	$(MAKE) install clean
