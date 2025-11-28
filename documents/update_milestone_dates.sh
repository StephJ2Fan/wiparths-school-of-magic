#!/bin/bash

OWNER="StephJ2Fan"
REPO="wiparths-school-of-magic"

IDS=(
  23
  24
  25
  26
  27
  28
  29
  30
  31
)

DUES=(
  "2026-02-17T08:00:00Z"
  "2026-04-17T08:00:00Z"
  "2026-06-17T08:00:00Z"
  "2026-08-17T08:00:00Z"
  "2026-10-17T08:00:00Z"
  "2026-12-17T08:00:00Z"
  "2027-02-17T08:00:00Z"
  "2027-04-17T08:00:00Z"
  "2027-06-17T08:00:00Z"
)

for i in "${!IDS[@]}"; do
  id=${IDS[$i]}
  due=${DUES[$i]}

  echo "Updating milestone $id to due_on=$due ..."
  gh api repos/$OWNER/$REPO/milestones/$id \
    -X PATCH \
    -f due_on="$due"
done

echo "Milestone due dates updated."
