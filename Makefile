## MP4Box

GPAC_VERSION    = 2.0.0
NGHTTP2_VERSION = 1.49.0
OPENSSL_VERSION = 3.0.5

ifeq ($(shell uname),Darwin)
	OPENSSL_ARCH = darwin64-x86_64-cc
	MAKE_ARGS   += -j$(shell sysctl -n hw.ncpu)
endif
ifeq ($(shell uname),FreeBSD)
	OPENSSL_ARCH = BSD-x86_64
	MAKE_ARGS   += -j$(shell sysctl -n hw.ncpu)
endif
ifeq ($(shell uname),Linux)
	OPENSSL_ARCH = linux-generic64
	MAKE_ARGS   += -j$(shell nproc)
endif
ifneq ($(wildcard /etc/redhat-release),)
	OPENSSL_DIR ?= /etc/pki/tls
else
	OPENSSL_DIR ?= /etc/ssl
endif

all: bin/MP4Box

clean:
	$(RM) -r bin/gpac include lib share/doc share/gpac share/nghttp2
	find share/man/man1 -type f -not -name 'mp4box.1' -delete

bin/MP4Box: lib/libnghttp2.a lib/libssl.a
	cd src/gpac-$(GPAC_VERSION) && \
	./configure --prefix=$(PWD) --mandir=$(PWD)/share/man \
		--static-bin --strip \
		--sdl-cfg=$(shell which false) \
		--disable-ipv6 --disable-platinum --disable-alsa --disable-oss-audio \
		--disable-jack --disable-pulseaudio --disable-x11 --disable-x11-shm \
		--disable-x11-xv --disable-ssl --disable-dvb4linux \
		--use-ft=no --use-zlib=local --use-jpeg=no --use-png=no \
		--use-faad=no --use-mad=no --use-xvid=no --use-ffmpeg=no \
		--use-ogg=no --use-vorbis=no --use-theora=no --use-openjpeg=no \
		--use-a52=no && \
	$(MAKE) $(MAKE_ARGS) && \
	$(MAKE) install clean

lib/libnghttp2.a: lib/libssl.a
	cd src/nghttp2-$(NGHTTP2_VERSION) && \
	./configure --prefix=$(PWD) --disable-dependency-tracking \
		--enable-static --disable-shared \
		--enable-lib-only --disable-assert \
		--with-zlib --with-openssl \
		--without-libxml2 --without-jansson --without-libevent-openssl \
		--without-libcares --without-libev --without-cunit --without-jemalloc \
		--without-systemd --without-libngtcp2 --without-libnghttp3 \
		--without-boost && \
	$(MAKE) $(MAKE_ARGS) && \
	$(MAKE) install clean

lib/libssl.a:
	cd src/openssl-$(OPENSSL_VERSION) && \
	perl ./Configure --prefix=$(PWD) --openssldir=$(OPENSSL_DIR) \
		no-shared \
		no-comp \
		no-ssl2 \
		no-ssl3 \
		no-zlib \
		enable-cms \
		$(OPENSSL_ARCH) && \
	$(MAKE) depend && \
	$(MAKE) $(MAKE_ARGS) && \
	$(MAKE) install_dev
