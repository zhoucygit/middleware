FROM ubuntu:24.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ADD ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources
ADD google-chrome-stable_current_amd64.deb /tmp/google-chrome-stable_current_amd64.deb
RUN    apt-get update && \
    apt-get install -y --no-install-recommends \
        nocache \
        fontconfig \
        curl  \
        tcpdump \
        locales \
        tzdata \
        wget \
        vim \
        unzip \
        adduser adwaita-icon-theme alsa-topology-conf alsa-ucm-conf at-spi2-common at-spi2-core ca-certificates cpp cpp-13 cpp-13-x86-64-linux-gnu cpp-x86-64-linux-gnu dbus dbus-bin dbus-daemon \
  dbus-session-bus-common dbus-system-bus-common dbus-user-session dconf-gsettings-backend dconf-service dmsetup fontconfig fontconfig-config fonts-liberation fonts-liberation-sans-narrow gcc-13-base \
  gir1.2-girepository-2.0 gir1.2-glib-2.0 gsettings-desktop-schemas gtk-update-icon-cache hicolor-icon-theme humanity-icon-theme krb5-locales libapparmor1 libargon2-1 \
  libasound2-data libasound2t64 libatk-bridge2.0-0t64 libatk1.0-0t64 libatspi2.0-0t64 libauthen-sasl-perl libavahi-client3 libavahi-common-data libavahi-common3 libbrotli1 libbsd0 libcairo-gobject2 \
  libcairo2 libclone-perl libcolord2 libcryptsetup12 libcups2t64 libcurl3t64-gnutls libdata-dump-perl libdatrie1 libdbus-1-3 libdconf1 libdeflate0 libdevmapper1.02.1 libdrm-amdgpu1 libdrm-common \
  libdrm-intel1 libdrm2 libedit2 libegl-mesa0 libegl1 libelf1t64 libencode-locale-perl libepoxy0 libexpat1 libfdisk1 libfile-basedir-perl libfile-desktopentry-perl libfile-listing-perl \
  libfile-mimeinfo-perl libfont-afm-perl libfontconfig1 libfreetype6 libfribidi0 libgbm1 libgdbm-compat4t64 libgdbm6t64 libgdk-pixbuf-2.0-0 libgdk-pixbuf2.0-bin libgdk-pixbuf2.0-common \
  libgirepository-1.0-1 libgl1 libgl1-mesa-dri libgles2 libglib2.0-0t64 libglib2.0-data libglvnd0 libglx-mesa0 libglx0 libgraphite2-3 libgssapi-krb5-2 libgtk-3-0t64 libgtk-3-bin libgtk-3-common \
  libharfbuzz0b libhtml-form-perl libhtml-format-perl libhtml-parser-perl libhtml-tagset-perl libhtml-tree-perl libhttp-cookies-perl libhttp-daemon-perl libhttp-date-perl libhttp-message-perl \
  libhttp-negotiate-perl libice6 libicu74 libio-html-perl libio-socket-ssl-perl libio-stringy-perl libipc-system-simple-perl libisl23 libjbig0 libjpeg-turbo8 libjpeg8 libjson-c5 libk5crypto3 \
  libkeyutils1 libkmod2 libkrb5-3 libkrb5support0 liblcms2-2 libldap-common libldap2 liblerc4 libllvm20 liblwp-mediatypes-perl liblwp-protocol-https-perl libmailtools-perl libmpc3 libmpfr6 \
  libnet-dbus-perl libnet-http-perl libnet-smtp-ssl-perl libnet-ssleay-perl libnghttp2-14 libnspr4 libnss-systemd libnss3 libpam-systemd libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 \
  libpciaccess0 libperl5.38t64 libpixman-1-0 libpng16-16t64 libpsl5t64 libpython3-stdlib libpython3.12-minimal libpython3.12-stdlib libreadline8t64 librsvg2-2 librsvg2-common librtmp1 libsasl2-2 \
  libsasl2-modules libsasl2-modules-db libsensors-config libsensors5 libsharpyuv0 libsm6 libsqlite3-0 libssh-4 libsystemd-shared libtext-iconv-perl libthai-data libthai0 libtie-ixhash-perl libtiff6 \
  libtimedate-perl libtry-tiny-perl liburi-perl libvulkan1 libwayland-client0 libwayland-cursor0 libwayland-egl1 libwayland-server0 libwebp7 libwww-perl libwww-robotrules-perl libx11-6 libx11-data \
  libx11-protocol-perl libx11-xcb1 libxau6 libxaw7 libxcb-dri3-0 libxcb-glx0 libxcb-present0 libxcb-randr0 libxcb-render0 libxcb-shape0 libxcb-shm0 libxcb-sync1 libxcb-xfixes0 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxdmcp6 libxext6 libxfixes3 libxft2 libxi6 libxinerama1 libxkbcommon0 libxkbfile1 libxml-parser-perl libxml-twig-perl libxml-xpathengine-perl libxml2 libxmu6 libxmuu1 \
  libxpm4  libxrandr2 libxrender1 libxshmfence1 libxt6t64 libxtst6 libxv1 libxxf86dga1 libxxf86vm1 media-types mesa-libgallium mesa-vulkan-drivers netbase networkd-dispatcher openssl perl \
  perl-modules-5.38 \
  perl-openssl-defaults publicsuffix python3 python3-dbus python3-gi python3-minimal python3.12 python3.12-minimal readline-common session-migration shared-mime-info systemd systemd-dev \
  systemd-resolved \
  systemd-sysv systemd-timesyncd tzdata ubuntu-mono wget x11-common x11-utils x11-xserver-utils xdg-user-dirs xdg-utils xkb-data zutty \
        openjdk-11-jdk \
        net-tools && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd --gid 200 spider && useradd --home-dir /home/spider --create-home --uid 200 --gid 200 spider 
    

ADD eng.traineddata /app/shopping-spider/eng.traineddata
ADD chi_sim.traineddata /app/shopping-spider/chi_sim.traineddata
ADD dejavu /usr/share/fonts/truetype/dejavu
RUN fc-cache -f -v  && cd /tmp && \
    apt-get install -y  ./google-chrome-stable_current_amd64.deb &&  \
    mkdir -p /opt/google/chrome/ && \
    chown -R spider:spider /app && \
    apt-get autoremove -y && apt-get clean
ADD  chromedriver /opt/google/chrome/chromedriver
RUN chmod +x /opt/google/chrome/chromedriver