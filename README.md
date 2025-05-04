````markdown
# 🌿 Jeriel's Dotfiles

A fully riced Arch Linux setup powered by [Hyprland](https://hyprland.org/), tuned for frontend development and terminal workflow.  
Includes shell, rice, launcher, theming, and dev configs—all version controlled and portable.

---

## 🚀 Features

- 🖥 Hyprland (Wayland window manager)
- 📟 Kitty terminal + Starship prompt
- 🧠 Zsh shell with clean, fast startup
- 🍚 Themed Waybar, Wofi, Mako, and GTK
- 🎨 Custom wallpapers and consistent rice
- ⚙️ Package list for full rebuilds

---

## 🧰 What's Tracked

- `.zshrc`, `.gitconfig`, `.tmux.conf`
- `~/.config/`:
  - `hypr/`
  - `waybar/`
  - `wofi/`
  - `mako/`
  - `kitty/`
  - `hyprpaper/`
  - `starship.toml`
- `~/.themes/`, `~/.icons/`, `~/.gtkrc-2.0`, `~/.config/gtk-3.0/`
- `install.sh` — bootstrap script for fresh installs
- `pkglist.txt`, `aurlist.txt` — all packages you use

---

## 🧪 Quick Install (for fresh Arch machines)

### 1. Clone bare repo

```bash
git clone --bare git@github.com:beanguap/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
````

### 2. Clone full repo and run install script

```bash
git clone https://github.com/beanguap/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

---

## 📦 Reinstall Packages (Optional)

To reinstall your saved system packages:

```bash
sudo pacman -S --needed - < ~/.config/pkglist.txt
```

---

## 🖼 Rice Preview

> Here's a screenshot of my current setup:

---

## ✨ Credits

* [Hyprland](https://github.com/hyprwm/Hyprland)
* [Starship Prompt](https://starship.rs/)
* [Arch Wiki](https://wiki.archlinux.org/)
* [Anuraghazra's GitHub Readme Stats](https://github.com/anuraghazra/github-readme-stats)

````

---

### ✅ Final Command to Push

Once that file is saved to `~/dotfiles/README.md`:

```bash
config add ~/dotfiles/README.md
config commit -m "Add full README with setup instructions and rice preview"
config push
````
