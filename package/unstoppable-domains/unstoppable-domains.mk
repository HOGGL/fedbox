################################################################################
#
# unstoppable-domains
#
################################################################################

UNSTOPPABLE_DOMAINS_VERSION = 2.0.2
UNSTOPPABLE_DOMAINS_SITE = $(call github,unstoppabledomains,resolution-cli,v$(UNSTOPPABLE_DOMAINS_VERSION))
UNSTOPPABLE_DOMAINS_LICENSE = MIT
UNSTOPPABLE_DOMAINS_LICENSE_FILES = LICENSE

UNSTOPPABLE_DOMAINS_BUILD_TARGETS = ./resolution
UNSTOPPABLE_DOMAINS_INSTALL_BINS = resolution

# The following is required until commit 24ac316 is included in a
# Buildroot release.
define UNSTOPPABLE_DOMAINS_SYNC_VENDOR_DIR
	cd $(@D); go mod vendor
endef

UNSTOPPABLE_DOMAINS_PRE_BUILD_HOOKS += UNSTOPPABLE_DOMAINS_SYNC_VENDOR_DIR

$(eval $(golang-package))
