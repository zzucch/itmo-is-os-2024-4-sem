#!/usr/bin/env bash

PS3="Select from following: "

select opt in vi nano links quit; do
  case $opt in
    vi)
      vi
      ;;
    nano)
      nano
      ;;
    links)
      links
      ;;
    quit)
      break
      ;;
    *)
      error "Unexpected expression '${opt}'"
      ;;
  esac
done
