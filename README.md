
# dsoquad-hello

This is the Hello World application for the DSO Quad open-source hand-held oscilliscope


## Installing a tool chain

These instructions assume that you are using Debian.

    apt-get install --no-install-recommends  build-essential autoconf flex \
                                             bison texinfo libncurses5-dev \
                                             libgmp3-dev libmpfr-dev \
                                             libmpc-dev libftdi-dev
    cd
    git clone git://github.com/esden/summon-arm-toolchain.git
    cd summon-arm-toolchain
    $EDITOR summon-arm-toolchain

..and ensure that the following settings are in force:

    TARGET=arm-none-eabi
    PREFIX=${HOME}/DSO-Quad/arm-toolchain
    USE_LINARO=1
    LIBSTM32_EN=1
    DEFAULT_TO_CORTEX_M3=1

..then:

    ./summon-arm-toolchain

The toolchain installs to whatever you set `PREFIX` to.  Next:

    export PATH=$PATH:~/DSO-Quad/arm-toolchain/bin  # and put this in .bashrc
    cd
    git clone git://github.com/neilstockbridge/dsoquad-hello.git
    cd dsoquad-hello
    make
    # Power up the DSO with the first button held down, then:
    sudo mount -t vfat /dev/sdb /media/DSO-Quad/  && \
      sudo cp APP3.HEX /media/DSO-Quad/  && sync  && \
      sudo umount /media/DSO-Quad/
    # Wait 3 seconds, power off the DSO then power up again with button 3 held down


### Storage for the tool chain

    $ du -sh  summon-arm-toolchain/  arm-toolchain/
    117M    summon-arm-toolchain/
    229M    arm-toolchain/

