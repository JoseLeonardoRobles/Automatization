#!/bin/bash

while getopts ":wrhplzu:" opt; do
  case $opt in
    w)
      lynx -dump -listonly -nonumbers "http://147.96.21.177/" > URL_Lynx_links.txt
      ;;
    r)
      wget -r --no-parent http://147.96.21.177/ >&2
      ;;
    p)
      wget -qO- http://147.96.21.177
      ;;
    l)
      grep '/2' URL_Lynx_links.txt > urllinks.txt
      tail -n 2 urllinks.txt > nightly.txt
      wget -r -np  -i nightly.txt
      ;;
    u)
      SEL=$OPTARG
      wget -r -np http://147.96.21.177/$SEL
      ;;
    z)
      cat /Users/joserobles/repos/dm_nsb_afs_fetching/URL_Lynx_links.txt >&2
      ;;
    h)
      echo "Usage:"
      echo "-h                                      Display this help message."
      echo "-p <URL>                                Parse URL (HTML URL information)."
      echo "-w <URL>                                List all available URL links from server recursively."
      echo "-z <URL>                                Display all available URL links on screen."
      echo "-r <URL>                                Retrieve entire URL recursively."
      echo "-l <URL>                                Retrieve URLs from previous two nights."
      echo "-u <DATE>                               Retrieve a unique URL by date YYYYMMDD/."
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
  esac
done
shift $((OPTIND-1))





