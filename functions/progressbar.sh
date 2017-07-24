#!/bin/bash

progress_bar()
{
  local PROG_BAR_MAX=${1:-30}
  local PROG_BAR_DELAY=${2:-1}
  local PROG_BAR_TODO=${3:-" "}
  local PROG_BAR_DONE=${4:-"X"}
  local i

  echo -en "["
  for i in `seq 1 $PROG_BAR_MAX`
  do
    echo -en "$PROG_BAR_TODO"
  done
  # Note: The following line echoes:
  # 1)   "]" (to end the "[...]" bar)
  # 2)   Control-M (aka Carriage Return) (aka Octal \0015)
  # 3)   "[" (to replace the original "[" and put the cursor in the right place)
  #echo -en "]^M["
  echo -en "]\0015["
  for i in `seq 1 $PROG_BAR_MAX`
  do
    echo -en "$PROG_BAR_DONE"
    sleep ${PROG_BAR_DELAY}
  done
  echo
}

while :
do
  curl http://localhost/status 2>/dev/null | grep "Ready" && break
  echo "`date`: System is not ready. Checking again in 10 seconds..."
  progress_bar 10
done
echo "`date`: System is ready."
