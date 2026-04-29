#!/usr/bin/env bash
# macOS sane defaults — install.sh'tan veya elle çalıştırılır.
# Tüm değişiklikler reversible — `defaults delete` ile geri alabilirsin.

set -e

echo "⚙️  macOS defaults uygulanıyor…"

# ───── Klavye (Neovim/vim için kritik) ─────
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false  # vim'de 'jjjj' çalışsın

# ───── Finder ─────
defaults write com.apple.finder AppleShowAllFiles -bool true        # Gizli dosyalar görünür
defaults write NSGlobalDomain AppleShowAllExtensions -bool true     # Uzantılar görünür
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # Default: bulunduğun klasörde ara
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# ───── Dock ─────
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.2
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false                # Spaces'i otomatik sıralama (aerospace için kritik)

# ───── Ekran görüntüsü ─────
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture disable-shadow -bool true

# ───── Trackpad ─────
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.0
defaults write -g com.apple.swipescrolldirection -bool true         # Natural scroll

# ───── Misc ─────
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Yenile
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "✅ macOS defaults uygulandı (bazıları logout/restart gerektirebilir)"
