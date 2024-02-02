#!/bin/bash

systemctl --user daemon-reload
systemctl --user start startup.service
systemctl --user start active_miner.service
