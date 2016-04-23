#!/bin/bash

cd ~/du6-aosp

# Turn off break on error to allow build process to run
set +e

############################################################
# BUILD ROM                                                #
############################################################

# Turn on compiler caching
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 85G

export USE_PREBUILT_CACHE=1
export DU_BUILD_TYPE=TEST

# Start build process
. build/envsetup.sh && lunch du_mako-userdebug
time make -j16 bacon

############################################################
# COPY ROM TO DU-Official FOLDER                           #
############################################################

set -e

# Copy build from /out to /DU-Official folder
cp ~/du6-aosp/out/target/product/mako/DU_mako_6*.zip ~/DU-Official/mako

# Remove the /out or make clobber
# rm -rf ~/du6-aosp/out/target/product/mako
# make clobber

# Notify user of success
beep -f 784 -r 3 -l 100
sleep .1
beep -f 784 -l 600
beep -f 622 -l 600
beep -f 698 -l 600
beep -f 784 -l 200
sleep .2
beep -f 698 -l 200
beep -f 784 -l 800

echo -e "\n"

echo 'Build completed successfully and copied over to DU-Official!'

exit
