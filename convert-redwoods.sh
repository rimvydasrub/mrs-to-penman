#!/bin/bash

base='profiles'
#  See: http://svn.delph-in.net/erg/tags/1214/etc/redwoods.xls
#  + -> train
#  = -> dev
#  ? -> test
# LOGON
  # "+hike"
  # "+jh0"
  # "+jh1"
  # "+jh2"
  # "+jh3"
  # "+jh4"
  # "+tg1"
  # "+ps"
  # "=jh5"
  # "=tg2"
  # "?jhk"
  # "?jhu"
  # "?tgk"
  # "?tgu"
  # "?psk"
  # "?psu"
  # "?rondane"
# WeScience
  # "+ws201"
  # "+ws202"
  # "+ws203"
  # "+ws204"
  # "+ws205"
  # "+ws206"
  # "+ws207"
  # "+ws208"
  # "+ws209"
  # "+ws210"
  # "+ws211"
  # "=ws212"
  # "?ws213"
  # "?ws214"
# Jacy
  # "+tc-006"
  # "+tc-007"
  # "+tc-008"
  # "+tc-009"
  # "+tc-010"
  # "+tc-011"
  # "+tc-012"
  # "=tc-013"
  # "?tc-014"
  # "?tc-015"
testsuites=(

)

mkdir -p data/{train,dev,test}
mkdir -p error/{train,dev,test}
for ts in ${testsuites[*]}; do
    prefix="${ts:0:1}"
    name="${ts:1}"
    case "$prefix" in
      # "+") datapath="data/train/${name}.txt"; errpath="error/train/${name}.err" ;;
      # "=") datapath="data/dev/${name}.txt"  ; errpath="error/dev/${name}.err" ;;
      "?") datapath="data/test/${name}.txt" ; errpath="error/test/${name}.err" ;;
      *)
        echo "Testsuite not designated as train (+), dev (=) or test (?): $ts"
        exit 1
        ;;
    esac
    echo "Converting $base/$name" >&2
    python3 mrs_to_penman.py \
        -i "$base/$name" \
        -p parameters.json \
        2> "$errpath"
done
