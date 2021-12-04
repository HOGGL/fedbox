PLEROMA_VERSION = v2.4.1
PLEROMA_SITE = https://git.pleroma.social/pleroma/pleroma.git
PLEROMA_SITE_METHOD = git
PLEROMA_LICENSE = AGPL-3
PLEROMA_LICENSE_FILES = COPYING AGPL-3
PLEROMA_DEPENDENCIES = host-elixir host-cmake host-file erlang file
# Add exiftool to strip location data from uploaded images

PLEROMA_TARGET_DEST = $(TARGET_DIR)/opt/pleroma

define PLEROMA_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) -f $(PLEROMA_PKGDIR)/Makefile
endef

define PLEROMA_INSTALL_TARGET_CMDS
	cd $(@D)/release; find lib releases -type f \! -executable -exec \
		$(INSTALL) -D -m 644 "{}" "$(PLEROMA_TARGET_DEST)/{}" \;

	$(INSTALL) -d -m 755 $(PLEROMA_TARGET_DEST)/bin
	$(INSTALL) -m 755 $(@D)/release/bin/* $(PLEROMA_TARGET_DEST)/bin

	cd $(@D)/release; find releases -type f -executable \
		\( -name "elixir" -o -name "iex" \) -exec \
		$(INSTALL) -D -m 755 "{}" "$(PLEROMA_TARGET_DEST)/{}" \;

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
