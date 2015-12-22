#!/bin/sh

LOCAL_FORMAT="<fc=#999>%_d %b</fc> %H:%M <fc=#999>%Z</fc>"
EXTRA_FORMAT="<fc=#777>%H:%M</fc> <fc=#555>%Z</fc>"

echo -n $(date +"$LOCAL_FORMAT")

for TZ in UTC America/Los_Angeles; do
  echo -n " <fc=#333>|</fc> $(TZ=$TZ date +"$EXTRA_FORMAT")"
done
