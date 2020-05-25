#!/bin/ash

set -e

stamp() {
   date -u +'%s'
}

case "$1" in

   # Verifies that service is healthy by checking /var/run/health timestamp and comparing
   # it to current timestamp. If the lag is more than 15 minutes, we report the service as 
   # unhealthy.
   verify)
      t0=$(cat /var/run/health)
      diff=$(($(stamp) - $t0))

      if [ "$diff" -gt "900" ]
      then
         echo "The lag of $diff second(s) is too big: assuming that service is not healthy."
         exit 1
      fi

      shift
      ;;

   # Writes a timestamp to /var/run/health file. This is what cron calls every 15 minutes.
   *)
      echo -n $(stamp) > /var/run/health

      shift
      ;;
esac
