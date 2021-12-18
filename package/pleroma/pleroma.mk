ifdef BR2_x86_64
PLEROMA_FLAVOUR=amd64
else ifdef BR2_arm
PLEROMA_FLAVOUR=arm
else ifdef BR2_aarch64
PLEROMA_FLAVOUR=aarch64
endif

ifeq ($(BR2_TOOLCHAIN_BUILDROOT_MUSL),y)
PLEROMA_FLAVOUR := $(PLEROMA_FLAVOUR)-musl
endif

PLEROMA_VERSION = develop # stable had arm builds polluted with aarch64 executables
PLEROMA_SITE = https://git.pleroma.social/api/v4/projects/2/jobs/artifacts/$(PLEROMA_VERSION)
PLEROMA_SOURCE = download?job=$(PLEROMA_FLAVOUR)
PLEROMA_LICENSE = AGPL-3
PLEROMA_LICENSE_FILES = COPYING AGPL-3
PLEROMA_DEPENDENCIES = ncurses file
# Add exiftool to strip location data from uploaded images

# The uuid-ossp extension is used by the setup_db.psql script
POSTGRESQL_CONF_OPTS+=--with-uuid=e2fs

define PLEROMA_EXTRACT_CMDS
	unzip $(PLEROMA_DL_DIR)/$(PLEROMA_SOURCE) -d $(@D)
endef

define PLEROMA_INSTALL_TARGET_CMDS
	rsync -a --exclude=/installation/ $(@D)/release/* $(TARGET_DIR)/opt/pleroma

	$(INSTALL) -d -m 755 \
		$(TARGET_DIR)/var/lib/pleroma/{uploads,static} \
		$(TARGET_DIR)/etc/pleroma
endef

define PLEROMA_USERS
	pleroma 60 social 60 - /opt/pleroma - - Twitter alternative
endef

define PLEROMA_PERMISSIONS
	/var/lib/pleroma r 750 pleroma social - - - - -
	/etc/pleroma d 755 pleroma social - - - - -
endef

define PLEROMA_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(PLEROMA_PKGDIR)/S90pleroma \
		$(TARGET_DIR)/etc/init.d
endef

define PLEROMA_INSTALL_INIT_OPENRC
	$(INSTALL) -D -m 0755 $(@D)/release/installation/init.d/pleroma \
		$(TARGET_DIR)/etc/init.d
endef

define PLEROMA_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/release/installation/pleroma.service \
		$(TARGET_DIR)/usr/lib/systemd/system
endef

$(eval $(generic-package))
