# 🍎 dotfiles — Ömer Düzgün

GNU Stow tabanlı, modern macOS dotfiles. **Fresh bir Mac'i (veya format'lanmış kendi Mac'ini) tek komutla eski haline döndürür.**

> Bu README hem **format öncesi yedekleme** hem **format/yeni-Mac sonrası restore** rehberidir. Her şey burada — başka yere bakmana gerek yok.

---

## 📦 Neler kurulu geliyor?

### CLI tools (Brewfile)
| Kategori | Paketler |
|---|---|
| **Shell** | zsh + Oh-My-Zsh + Powerlevel10k |
| **Editor** | neovim (LazyVim değil — kendi `omer` namespace'im) |
| **Terminal mux** | tmux + tmuxinator + TPM |
| **Search/Files** | ripgrep, fd, fzf, tree, wget, unzip |
| **Git/GH** | git, gh, stow |
| **Languages** | node, nvm, pyenv, python@3.13, ruby, rust, uv |
| **Data** | supabase (CLI), specify-cli (uv tool) |
| **Misc** | blueutil, nowplaying-cli (sketchybar widget'ları için) |

### GUI apps (cask)
| App | Ne için |
|---|---|
| **Ghostty** | Ana terminal (Catppuccin Mocha + 0.85 opacity + blur) |
| **AeroSpace** | i3-style tiling WM (workspace 1-9 + sketchybar entegre) |
| **SketchyBar** | Custom menubar (wifi/bluetooth/cpu/battery/spotify/clock) |
| **Claude Code** | AI pair-programming CLI'ı |
| **Obsidian** | Notes (My-Life-Notes vault) |
| **Slack** | Çalışma iletişimi |
| **Hack Nerd Font** | P10k + sketchybar için icon font |

---

## 🚀 Fresh Mac kurulumu (3 komut)

```bash
# 1. Git lazım, o yüzden Xcode Command Line Tools (sadece CLT, full Xcode değil — ~2GB)
xcode-select --install     # Popup çıkar, "Install" de, ~5-10 dk bekle.
                           # (Bu adımı atlasan da Homebrew installer kendisi tetikler.)

# 2. Repo
git clone https://github.com/Cecemaru/dotfiles.git ~/dotfiles

# 3. Her şey
cd ~/dotfiles && ./install.sh
```

`install.sh` ne yapar:
1. Homebrew kurar (yoksa)
2. Tüm `Brewfile` paketlerini kurar (CLI + cask)
3. `specify-cli`'ı `uv tool install` ile kurar
4. Oh-My-Zsh + Powerlevel10k klonlar
5. TPM (Tmux Plugin Manager) `~/.tmux/plugins/tpm`'ye klonlar
6. `stow` ile tüm config'leri `$HOME` altına symlink'ler
7. (Opsiyonel) `macos/defaults.sh`'i çalıştırır (klavye/Finder/Dock ayarları)

---

## 🔄 Format sonrası — el ile yapılacaklar (install.sh bitince)

Aşağıdaki sıra otomatik **değil**, manuel:

### 1. Secret'ları ve env'leri restore et
```bash
# env-vault private repo'sundan env dosyalarını çek
git clone https://github.com/Cecemaru/env-vault.git ~/env-vault

# Çalıştığım her şirket için ayrı .env'leri yerine koy
cp ~/env-vault/firsatlas/firsatlas-api.env       ~/projects/firsatlas/firsatlas-api/.env
cp ~/env-vault/firsatlas/firsatlas-web.env.local ~/projects/firsatlas/firsatlas-web/.env.local
cp ~/env-vault/datablast/frontend.env            ~/projects/datablast/frontend/.env
cp ~/env-vault/datablast/backend.env             ~/projects/datablast/backend/.env
cp ~/env-vault/flowtrack/flowtrack.env           ~/projects/rumicandle/flowtrack/.env
cp ~/env-vault/flowtrack/flowtrack.env.local     ~/projects/rumicandle/flowtrack/.env.local
```

### 2. Çalıştığım sirket repolarını klonla
```bash
mkdir -p ~/projects/{firsatlas,datablast,rumicandle}

# firsatlas
cd ~/projects/firsatlas
gh repo clone Cecemaru/firsatlas-api
gh repo clone Cecemaru/firsatlas-web

# datablast (organization repo'ları)
cd ~/projects/datablast
gh repo clone datablast-dataplatform/nuxt-ui frontend
gh repo clone datablast-dataplatform/django_api_aggragator backend
gh repo clone datablast-dataplatform/docs

# flowtrack (rumicandle)
cd ~/projects/rumicandle
gh repo clone Cecemaru/rumicandle flowtrack
```

### 3. `~/.zshrc.local` — Gemini / API key'leri
Bu dosya gitignore'da, **repo'da yok**. Format öncesi unutursan kayboldu gitti — `console.cloud.google.com`'dan veya `aistudio.google.com/apikey`'den yeni key al:
```bash
cat > ~/.zshrc.local <<'EOF'
export GEMINI_API_KEY="..."
export GOOGLE_CLOUD_PROJECT="..."
EOF
```

### 4. SSH key — GitHub auth için yeni key üret
```bash
ssh-keygen -t ed25519 -C "cecemaru@hotmail.com"
# Public key'i kopyala:
pbcopy < ~/.ssh/id_ed25519.pub
# github.com/settings/keys → "New SSH key" → yapıştır
```
Alternatif: `gh auth login` ile HTTPS + PAT (Personal Access Token) yöntemi.

### 5. Python — pyenv ile sürüm kur
```bash
pyenv install 3.13
pyenv global 3.13
```

### 6. Node — nvm ile sürüm kur
```bash
nvm install --lts
nvm alias default lts/*
```

### 7. tmux plugin'leri kur
```bash
tmux                    # tmux başlat
# içerideyken: prefix + I  →  TPM tüm plugin'leri kurar
# (prefix benim setup'ımda Ctrl+Space, Ctrl+b DEĞİL)
```

### 8. neovim plugin'leri — otomatik
İlk `nvim` açışında `lazy.nvim` kendini bootstrap eder, sonra `lua/omer/lazy/*.lua` içindeki tüm plugin'leri klonlar. Sadece bir kere `:Lazy sync` çalıştır.

### 9. AeroSpace'e accessibility izni ver
**Sistem Ayarları → Privacy & Security → Accessibility → AeroSpace ✓**
(Olmadan workspace shortcut'ları çalışmaz.)

### 10. (Opsiyonel) macOS defaults
`install.sh` sırasında "uygulansın mı?" diye sormuştu. Atlamışsan:
```bash
~/dotfiles/macos/defaults.sh
```
Sonra **logout** veya restart — bazı ayarlar (klavye repeat, Finder) yeniden başlatma ister.

---

## 🔐 Format ÖNCESİ checklist

Hiçbiri repo'da yok, kaybolursa geri gelmez:

- [ ] **`~/dotfiles`** — `git status` temiz, son düzeltmeler push'lu mu? (`git log origin/main..HEAD` boş olmalı)
- [ ] **`~/projects/`** altında uncommitted/unpushed olan repo VAR mı?
  ```bash
  find ~/projects -maxdepth 4 -name .git -type d | while read g; do
    cd "${g%/.git}"
    [[ $(git status --porcelain) || $(git log @{u}..HEAD --oneline 2>/dev/null) ]] && pwd
  done
  ```
- [ ] **`env-vault`** repo'su güncel mi? Yeni bir projede `.env` varsa ekledin mi?
- [ ] **`~/.zshrc.local`** içeriği bir yere not edildi mi? (Format = bu dosya kayıp)
- [ ] **`~/Documents/`** önemli dosyalar (PDF, notlar, vs.) external'a kopyalandı mı?
- [ ] **iCloud Photos** açık mı? (Fotoğraflar için)
- [ ] **iCloud Keychain** açık mı? (Safari/Brave şifreleri için)
- [ ] **Cursor Settings Sync** açık mı? (Cmd+Shift+P → "Settings Sync")
- [ ] **Postman** account login'li mi? (Collection'lar için)

---

## 🗂️ Repo yapısı

```
dotfiles/
├── install.sh                          # Bootstrap script
├── Brewfile                            # brew bundle paket listesi
├── macos/defaults.sh                   # macOS sane defaults
├── zsh/
│   ├── .zshrc                          # → ~/.zshrc
│   ├── .zshenv                         # → ~/.zshenv
│   └── .p10k.zsh                       # → ~/.p10k.zsh (Powerlevel10k config)
├── git/.gitconfig                      # → ~/.gitconfig
├── tmux/.config/tmux/tmux.conf         # → ~/.config/tmux/tmux.conf
├── tmuxinator/.config/tmuxinator/      # → ~/.config/tmuxinator/
├── nvim/.config/nvim/                  # → ~/.config/nvim/
│   ├── init.lua                        # require("omer")
│   └── lua/omer/
│       ├── init.lua                    # set → remap → lazy_init sırası
│       ├── set.lua                     # Vim option'ları
│       ├── remap.lua                   # Keymapler (leader=Space)
│       ├── lazy_init.lua               # lazy.nvim bootstrap
│       └── lazy/*.lua                  # Her plugin için ayrı spec
├── ghostty/.config/ghostty/config      # → ~/.config/ghostty/config
├── aerospace/.config/aerospace/        # → ~/.config/aerospace/
└── sketchybar/.config/sketchybar/      # → ~/.config/sketchybar/
```

GNU Stow her paketin iç yapısını `$HOME` ağacının birebir aynası gibi tutar. `stow nvim` çalıştırıldığında `dotfiles/nvim/.config/nvim/` altındaki her şey `~/.config/nvim/` olarak symlink'lenir.

---

## ⚡ Günlük kullanım

### Config değişikliği yapınca
Symlink olduğu için zaten repo'daki dosyaya yazıyorsun — sadece commit'le:
```bash
cd ~/dotfiles && git add -A && git commit -m "tweak: ..." && git push
```

### Yeni paket ekleyince
```bash
cd ~/dotfiles && stow yeni-paket
```

### Brewfile güncelleme (yeni bir şey kurdun)
```bash
cd ~/dotfiles
brew bundle dump --force --file=Brewfile
git add Brewfile && git commit -m "brew: add ..."
```

### env-vault güncelleme (yeni `.env` yedeği)
```bash
cp ~/projects/yeni-sirket/yeni-proje/.env ~/env-vault/yeni-sirket/yeni-proje.env
cd ~/env-vault && git add -A && git commit -m "add: yeni-proje env" && git push
# README'sindeki tabloya satır eklemeyi unutma
```

---

## 🆘 Troubleshooting

| Sorun | Çözüm |
|---|---|
| `brew bundle` patlıyor | `Brewfile`'da geçersiz direktif var mı bak (tap/brew/cask/mas dışı) |
| `stow` "WARNING: target X is a file" | `~/dotfiles_backup/$(date)` altına otomatik backup'lar |
| Ghostty Catppuccin yok | `font-hack-nerd-font` yüklü mü kontrol et |
| tmux'ta plugin görünmüyor | `prefix + I` (büyük I), prefix = `Ctrl+Space` |
| nvim'de plugin yok | `:Lazy sync` |
| AeroSpace shortcut çalışmıyor | Settings → Privacy → Accessibility'den izin ver |
| pyenv "command not found" | `~/.zshrc` pyenv init guard'lı; brew install pyenv eksik olabilir |
| Powerlevel10k karakterler `?` | Hack Nerd Font yüklü değil veya terminal font'u o ayarlanmamış |

---

## 🔗 İlgili private repolar

| Repo | İçerik |
|---|---|
| `Cecemaru/dotfiles` | (bu repo) |
| `Cecemaru/env-vault` | Tüm proje `.env`'leri (private) |
| `Cecemaru/firsatlas-api` | Fırsatlas API (private) |
| `Cecemaru/firsatlas-web` | Fırsatlas Web (private) |
| `Cecemaru/rumicandle` | Flowtrack (private) |
| `datablast-dataplatform/*` | Datablast şirket repoları (org) |

---

## 📝 Notlar

- **SSH key'ler repo'da YOK.** Yeni Mac'te ya yedekten geri yükle ya yenisini üret + GitHub'a ekle.
- **macOS defaults** bazıları logout/restart sonrası aktif olur.
- **Powerlevel10k instant prompt** ilk açılışta cache'ini yaratmak için 1-2 saniye geç gelebilir, normal.
- **`lazy-lock.json`** gitignore'da — fresh kurulumda plugin'ler en güncel sürümle gelir. Reprodüksiyon istiyorsan `.gitignore`'dan çıkar.
