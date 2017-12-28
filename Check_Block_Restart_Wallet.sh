# # #                     # # #
# # # run next 2 commands # # #
# nano ~/checkmn.sh
# chmod +x ~/checkmn.sh
# # #                     # # #
# # # add task to crontab # # #
# crontab -e
# */5 * * * * /bin/sh ~/checkmn.sh
# # #                     # # #
# # # check if all works  # # #
# ./checkmn.sh
# ./Sparks-cli getinfo
# ./Sparks-cli masternode status


#####################################################################
cd
echo Getting current network block..
wget http://spk.explorerz.top:3019/api/getblockcount -O getblockcount
netblock=$(cat "getblockcount")
echo Net Block $netblock

vpsblock=$(./Sparks-cli getinfo | grep blocks)
vpsblock=${vpsblock#*:}
vpsblock=${vpsblock%,*}
echo VPS Block $vpsblock
vpsblock=$((vpsblock+2))
echo VPS Block $vpsblock

if [ "$netblock" -gt "$vpsblock" ]
then
  echo "VPS Stucked. Restarting with reindex"
  cd
  ./Sparks-cli stop
  echo Waiting 10 sec after stop...
  sleep 10
  cd
  cd .Sparks
  rm governance.dat
  rm netfulfilled.dat
  rm peers.dat
  rm -r blocks
  rm mncache.dat
  rm -r chainstate
  rm fee_estimates.dat
  rm mnpayments.dat
  rm banlist.dat
  cd
  ./Sparksd -daemon -reindex
fi
#####################################################################
