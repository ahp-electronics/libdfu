#!/bin/bash
$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin/
export HOMEBREW_NO_INSTALL_FROM_API=1
directory=$(cat ${CMAKE_CURRENT_SOURCE_DIR}/.git/config | grep origin -A 1 | head -n 2 | tail -n 1 | cut -d ':' -f 2)
repository=$(echo $directory | cut -d '/' -f 1)
project=$(echo $directory | cut -d '/' -f 2)
brew tap --force homebrew/core
brew create --cmake https://github.com/$repository/$project/archive/refs/tags/v@DFU_VERSION@.tar.gz --set-name "$project@@DFU_VERSION@" --set-version '@DFU_VERSION@' --tap homebrew/core
brew audit --new $project@@DFU_VERSION@
brew install --build-from-source --verbose --debug $project@@DFU_VERSION@
brew test $project@@DFU_VERSION@
#Editing /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/lib/$project@@DFU_VERSION@.rb
