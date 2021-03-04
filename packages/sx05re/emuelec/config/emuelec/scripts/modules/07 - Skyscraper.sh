#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

if [ ! -L "/storage/.skyscraper" ]; then
ln -sTf /storage/.config/skyscraper /storage/.skyscraper
fi

source /emuelec/scripts/env.sh
source "$scriptdir/scriptmodules/supplementary/skyscraper.sh"
rp_registerAllModules

joy2keyStart

function scrape_confirm() {
     if dialog --ascii-lines --yesno "This will Kill Emulationstation and will Skyscraper, do you want to continue?"  22 76 >/dev/tty; then
		start_skyscraper
      fi
 }

function start_skyscraper() {
systemd-run bash /emuelec/scripts/fbterm.sh /emuelec/scripts/modules/Skyscraper.start
systemctl stop emustation
}

scrape_confirm
