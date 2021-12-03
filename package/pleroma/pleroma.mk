# ifdef BR2_arm
# 	PLEROMA_FLAVOUR = "arm"
# endif

# ifdef BR2_aarch64
# 	PLEROMA_FLAVOUR = "arm64"
# endif

# ifdef BR2_x86_64
# 	PLEROMA_FLAVOUR = "amd64"
# endif

# ifeq ($(BR2_TOOLCHAIN_BUILDROOT_LIBC),"musl")
# 	PLEROMA_FLAVOUR := $(PLEROMA_FLAVOUR)"-musl")
# endif

PLEROMA_VERSION = v2.4.1
PLEROMA_SITE = https://git.pleroma.social/pleroma/pleroma.git
PLEROMA_SITE_METHOD = git
PLEROMA_LICENSE = AGPL-3
PLEROMA_LICENSE_FILES = COPYING AGPL-3
PLEROMA_DEPENDENCIES = host-elixir host-cmake host-file erlang file

define PLEROMA_BUILD_CMDS
	sed -i '/include_executables_for/a include_erts: false,' \
		$(@D)/mix.exs
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) -f $(PLEROMA_PKGDIR)/Makefile
endef

define PLEROMA_INSTALL_TARGET_CMDS
	cp -r $(@D)/release $(TARGET_DIR)/opt/pleroma
# $(INSTALL) -d -m 755 $(TARGET_DIR)/opt/pleroma \
# 	$(TARGET_DIR)/opt/pleroma/{bin,lib,releases}
# $(foreach dir, $(wildcard $(@D)/release/lib/*),
# 	$(eval lib = $(dir:$(@D)/release/lib/%=%))
# 	$(INSTALL) -d -m 755 $(TARGET_DIR)/opt/pleroma/lib/$(lib)
# 	$(INSTALL) -d -m 755 $(TARGET_DIR)/opt/pleroma/lib/$(lib)/ebin
# 	$(INSTALL) -m 644 $(wildcard $(dir)/ebin/*) \
# 		$(TARGET_DIR)/opt/pleroma/lib/$(lib)/ebin)
endef

$(eval $(generic-package))
