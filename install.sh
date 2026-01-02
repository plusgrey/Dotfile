set -e

sudo pacman -S --needed --noconfirm \
  yazi \
  wezterm \
  zsh \
  fzf \
  neovim \
  tmux \
  lazygit \
  ibus-rime librime rime-essay \
  noto-fonts-cjk \
  ttf-meslo-nerd \
  git \
  base-devel \
  xorg-xwayland \
  wl-clipboard \
  grim slurp \
  swaybg \
  mako \
  poolkit-gnome \
  wayland-protocols \
  fcitx5-qt \
  fcitx5-gtk \
  fcitx5-configtool \
  fcitx5 \
  fcitx5-rime \
  xwayland-satellite \

#install rime-ice
cd ~/Downloads
if [ ! -d "plum" ]; then
  git clone --depth 1 https://github.com/rime/plum
  cd plum/
  bash rime-install iDvel/rime-ice:others/recipes/full
  cd ..
  rm -rf plum
fi
cd ~

# intall paru
cd ~/Downloads
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~
rm -rf ~/Downloads/paru

# install paru packages
paru -S --needed --noconfirm \
  visual-studio-code-bin \
  google-chrome \
  niri \
  noctalia-shell \
  vim-wayland-clipboard \
  rime-ice-git \

curl -fsSL https://pixi.sh/install.sh | sh

# 可选：让当前 shell 立刻可用 pixi
export PATH="$HOME/.pixi/bin:$PATH"

	
# set zsh as default shell
chsh -s /bin/zsh

#config nvidia for niri
sudo tee /etc/modprobe.d/nvidia.conf << 'EOF'
options nvidia-drm modeset=1
EOF
sudo mkinitcpio -P
