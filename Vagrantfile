# -*- mode: ruby -*-
# vi: set ft=ruby :

$build_dir = "/vagrant"
$archiso_sha256sum = "7ac2214abd5e217d7602ce1679e4a956a76692bec29841fbc5f68bafe02c248b"
$archios_url = "https://github.com/archlinux/archiso/archive/v43.tar.gz"

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = "4096"
    libvirt.cpus = "2"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo pacman-key -r DDF7DB817396A49B2A2723F7403BD972F75D9D76 && \
    sudo pacman-key --lsign-key DDF7DB817396A49B2A2723F7403BD972F75D9D76 && \
    echo "#$archiso_sha256sum v43.tar.gz" > checksum.sha256 && \
    curl -O -L #$archios_url && \
    sha256sum -c checksum.sha256 && \
    tar -xvf v43.tar.gz && \
    pacman -Sy --noconfirm \
      grub \
      edk2-shell \
      make patch \
      arch-install-scripts \
      dosfstools \
      e2fsprogs \
      libisoburn \
      mtools \
      squashfs-tools \
      binutils \
    && \
    for patch in #$build_dir/patches/*.patch; do patch -ruN -d archiso-43 -p1 < ${patch}; done && \
    cd archiso-43 && \
    sudo make install && \
    cd #$build_dir && \
    sudo ./build.sh -N systemrescue_custom -v
  SHELL
end
