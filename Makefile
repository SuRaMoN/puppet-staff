
.PHONY: default ubuntu-dependencies test
UBUNTU_PACKAGES=ruby-rspec-puppet

default: test

ubuntu-dependencies:
	@if grep -q "Ubuntu" /etc/issue && [ "$$(dpkg-query -W -f='$${status}' $(UBUNTU_PACKAGES) 2>&1 | sed 's/install ok installed//g')" != "" ]; then \
		echo sudo apt-get install $(UBUNTU_PACKAGES); \
		sudo apt-get install $(UBUNTU_PACKAGES); \
	fi

test: ubuntu-dependencies
	rake spec

