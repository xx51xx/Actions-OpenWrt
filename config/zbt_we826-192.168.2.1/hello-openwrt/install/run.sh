#!/bin/sh

# 一般情况下不要动！
if [ -f /root/setting.sh ]; then

    (sleep 300 && chmod 0755 /root/setting.sh && /root/setting.sh) &

else

    rm -rf /etc/rc.d/SSS99init_run.sh
    
fi
exit 0