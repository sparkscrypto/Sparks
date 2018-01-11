#!/bin/bash
#
# tool to check masternode status / block height and compare it to an external api
# should be run via crontab once every 5 minutes
#
# */5 * * * * tool-path.sh
#

# tool paths
cli='/usr/local/bin/Sparks-cli'
daemon='/usr/local/bin/Sparksd'

# data dir
data="~/.Sparks"

# api url
api_url='http://spk.explorerz.top:3019/api/getblockcount'

# get local and remote block count
api_blocks=$(curl -s ${api_url})
local_blocks=$(${cli} getblockcount)

if (( api_blocks > local_blocks )); then
        # cleaning up
        ${cli} stop
        sleep 0.5
        rm -rf ${data}/{governance.dat,netfulfilled.dat,peers.dat,blocks,mncache.dat,chainstate,fee_estimates.dat,mnpayments.dat,banlist.dat}
        sleep 1
        ${daemon} -reindex
        exit 1
else
        exit 0
fi
