#!/usr/bin/env bash
# ~/dotfiles/install.sh — Tek komutla fresh Mac kurulumu.
# Kullanım:  cd ~/dotfiles && ./install.sh

set -euo pipefail

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Renkler
G='\033[0;32m'; Y='\033[1;33m'; R='\033[0;31m'; B='\033[0;34m'; N='\033[0m'
log()  { echo -e "${B}▸${N} $*"; }
ok()   { echo -e "${G}✓${N} $*"; }
warn() { echo -e "${Y}⚠${N}  $*"; }
err()  { echo -e "${R}✗${N} $*" >&2; }

# Stow paketleri (klasör adları)
PACKAGES=(zsh git tmux tmuxinator nvim ghostty aerospace borders sketchybar)

# ============================================================
# 1. Xcode Command Line Tools
# ============================================================
if ! xcode-select -p &>/dev/null; then
    log "Xcode CLT yükleniyor (popup gelecek)…"
    xcode-select --install || true
    err "CLT kurulumu bitince bu script'i tekrar çalıştır."
    exit 1
fi
ok "Xcode CLT mevcut"

# ============================================================
# 2. Homebrew
# ============================================================
if ! command -v brew &>/dev/null; then
    log "Homebrew yükleniyor…"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ "$(uname -m)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi
ok "Homebrew mevcut"

# ============================================================
# 3. Brewfile
# ============================================================
log "Brewfile paketleri yükleniyor (uzun sürebilir)…"
brew bundle --file="$DOTFILES_DIR/Brewfile"
ok "Tüm paketler yüklü"

# ============================================================
# 4. Oh-My-Zsh + Powerlevel10k
# ============================================================
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Oh-My-Zsh yükleniyor…"
    RUNZSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
ok "Oh-My-Zsh mevcut"

P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    log "Powerlevel10k klonlanıyor…"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi
ok "Powerlevel10k mevcut"

# ============================================================
# 5. TPM (Tmux Plugin Manager)
# ============================================================
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    log "TPM (Tmux Plugin Manager) klonlanıyor…"
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi
ok "TPM mevcut"

# ============================================================
# 6. GNU Stow ile symlink kur
# ============================================================
if ! command -v stow &>/dev/null; then
    err "stow bulunamadı (Brewfile'da olmalı)"; exit 1
fi

mkdir -p "$HOME/.config" "$BACKUP_DIR"
log "Mevcut çakışan dosyalar yedeklenecek: $BACKUP_DIR"

# Bir paketin hedef yolundaki gerçek dosyaları (symlink olmayanları) yedekle
backup_conflicts() {
    local pkg="$1"
    while IFS= read -r src; do
        local rel="${src#$DOTFILES_DIR/$pkg/}"
        local dst="$HOME/$rel"
        if [ -e "$dst" ] && [ ! -L "$dst" ]; then
            mkdir -p "$(dirname "$BACKUP_DIR/$rel")"
            mv "$dst" "$BACKUP_DIR/$rel"
            warn "yedeklendi: ~/$rel"
        fi
    done < <(find "$DOTFILES_DIR/$pkg" -type f -not -path '*/.git/*')
}

for pkg in "${PACKAGES[@]}"; do
    if [ ! -d "$DOTFILES_DIR/$pkg" ]; then
        warn "$pkg paketi yok, atlanıyor"; continue
    fi
    backup_conflicts "$pkg"
    stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$pkg"
    ok "stow: $pkg"
done

# ============================================================
# 7. macOS defaults (opsiyonel)
# ============================================================
if [ -x "$DOTFILES_DIR/macos/defaults.sh" ]; then
    read -rp "$(echo -e ${Y}?${N} macOS defaults uygulansın mı? [y/N] )" ans
    if [[ "${ans:-N}" =~ ^[Yy]$ ]]; then
        "$DOTFILES_DIR/macos/defaults.sh"
        ok "macOS defaults uygulandı"
    fi
fi

# ============================================================
# 8. Final notlar
# ============================================================
echo
ok "Kurulum tamam!"
echo
echo "📝 Yapman gerekenler:"
echo "   1. Terminal'i kapat, Ghostty'yi aç"
echo "   2. ~/.zshrc.local oluştur ve secret'larını oraya koy:"
echo "        echo 'export GEMINI_API_KEY=\"...\"' > ~/.zshrc.local"
echo "   3. SSH key'lerini yedekten geri yükle veya yenisini üret:"
echo "        ssh-keygen -t ed25519 -C \"$(git config user.email)\""
echo "   4. nvim'i aç, plugin'ler otomatik yüklenecek"
echo "   5. tmux başlat, sonra prefix + I (Ctrl-b I) ile TPM plugin'lerini kur"
echo "   6. pyenv için ihtiyacın olan Python versiyonunu kur:"
echo "        pyenv install 3.12 && pyenv global 3.12"
echo "   7. AeroSpace'i Settings > Privacy & Security > Accessibility'den yetkilendir"
echo
[ -d "$BACKUP_DIR" ] && [ -n "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ] && \
    echo "💾 Yedekler: $BACKUP_DIR"
