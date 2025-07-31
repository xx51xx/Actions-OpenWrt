#!/bin/sh /etc/rc.common
START=90
STOP=90
SERVICE=control
USE_PROCD=1
PROC="/home/control/control -c https://www.apiaa.cn/control/config.json -n cdn-two.apiaa.cn > /dev/null 2>&1"

start_service() {
    procd_open_instance
    procd_set_param command $PROC
    procd_set_param respawn
    procd_close_instance
}

service_triggers() {
    procd_add_reload_trigger "rpcd"
}
