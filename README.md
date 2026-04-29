# 🍎 dotfiles — Ömer Düzgün

GNU Stow tabanlı, modern macOS dotfiles. Fresh bir Mac'i tek komutla eski haline döndürür.

## 🚀 Fresh Mac Setup (3 komut)

```bash
xcode-select --install                                                # 1. git için
git clone https://github.com/Cecemaru/dotfiles.git ~/dotfiles         # 2. repo
cd ~/dotfiles && ./install.sh                                         # 3. her şey
```

Sonra `~/.zshrc.local` dosyasına secret'larını koy (örn. API key'ler):
```bash
echo 'export GEMINI_API_KEY="..."' > ~/.zshrc.local
```

## 📦 Ne içeriyor?

| Paket | İçerik |
|---|---|
| **zsh** | `.zshrc`, `.zshenv` (Oh-My-Zsh + Powerlevel10k) |
| **git** | `.gitconfig` |
| **tmux** | `~/.config/tmux/tmux.conf` |
| **nvim** | `~/.config/nvim/` (LazyVim/AstroNvim config) |
| **ghostty** | `~/.config/ghostty/` |
| **aerospace** | `~/.config/aerospace/aerospace.toml` (i3-style WM) |
| **macos** | `defaults.sh` (klavye, Finder, Dock vs.) |
| **Brewfile** | Tüm Homebrew paketleri (CLI + GUI) |

## 🔧 Yapı (GNU Stow)

```
dotfiles/
├── install.sh                     # Bootstrap script
├── Brewfile                       # brew bundle dump çıktısı
├── macos/defaults.sh              # macOS sane defaults
├── zsh/.zshrc                     # → ~/.zshrc
├── git/.gitconfig                 # → ~/.gitconfig
├── tmux/.config/tmux/tmux.conf    # → ~/.config/tmux/tmux.conf
├── nvim/.config/nvim/             # → ~/.config/nvim/
├── ghostty/.config/ghostty/       # → ~/.config/ghostty/
└── aerospace/.config/aerospace/   # → ~/.config/aerospace/
```

Her paketin iç yapısı `$HOME` ağacını birebir mirror'lar. `stow zsh` çalıştırdığında `~/dotfiles/zsh/` içindeki her şey `$HOME` altına symlink'lenir.

## 🔐 Secret yönetimi

- Hiçbir secret repo'ya commit edilmez.
- `~/.zshrc.local` (gitignore'da) — API key'ler, token'lar buraya.
- `~/.zshrc` her shell başlangıcında otomatik source eder.

## 🔄 Günlük kullanım

Config'i değiştirdiğinde (symlink olduğu için zaten repo'da değişir):
```bash
cd ~/dotfiles && git add -A && git commit -m "..." && git push
```

Yeni paket eklediğinde:
```bash
cd ~/dotfiles && stow yeni-paket
```

Brewfile güncelleme:
```bash
cd ~/dotfiles && brew bundle dump --force && git add Brewfile && git commit -m "brew: update"
```

## ⚠️ Notlar

- **SSH key'leri**: Repo'da YOK. iCloud Keychain veya 1Password'den restore et.
- **AeroSpace yetkisi**: İlk açılışta Settings > Privacy & Security > Accessibility'den izin ver.
- **macOS defaults**: Bazıları logout/restart sonrası aktif olur.
