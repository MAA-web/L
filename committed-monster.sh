#!/bin/bash

dates=(

# L - 2,3,4,5,6,7,8,15,22,29 Aug
"2026-08-02"
"2026-08-03"
"2026-08-04"
"2026-08-05"
"2026-08-06"
"2026-08-07"
"2026-08-08"
"2026-08-15"
"2026-08-22"
"2026-08-29"

)

for date in "${dates[@]}"
do
  # random number between 30 and 40 commits
  num_commits=50

  # start time: 11:29:00
  base_hour=11
  base_minute=29
  base_second=0

  for ((i=0; i<num_commits; i++))
  do
    # increment time by random 20–120 seconds each commit
    increment=$((20 + RANDOM % 101))
    base_second=$((base_second + increment))

    # normalize time
    base_minute=$((base_minute + base_second / 60))
    base_second=$((base_second % 60))
    base_hour=$((base_hour + base_minute / 60))
    base_minute=$((base_minute % 60))

    timestamp=$(printf "%s %02d:%02d:%02d" "$date" "$base_hour" "$base_minute" "$base_second")

    echo "$date commit $((i+1))" >> commits.txt
    git add commits.txt

    GIT_AUTHOR_DATE="$timestamp" \
    GIT_COMMITTER_DATE="$timestamp" \
    git commit -m "Commit $((i+1)) for $date"
  done
done
