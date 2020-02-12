[Unit]
Description=Start {{TYPE}} {{NAME}}

[Service]
ExecStart=/usr/bin/crun --log /var/log/crun.log run --no-pivot --bundle {{DIR}}/ {{NAME}}
ExecStop=/usr/bin/crun kill {{NAME}}
ExecStopPost=/usr/bin/crun delete {{NAME}}; /bin/rm -rf /run/crun/docker
Type=simple

[Install]
WantedBy={{TYPE}}.target
