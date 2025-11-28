#!/bin/bash

OWNER="StephJ2Fan"
REPO="wiparths-school-of-magic"

assign() {
  local num=$1
  local milestone=$2
  echo "Assigning issue #$num → $milestone"
  gh issue edit $num -R $OWNER/$REPO --milestone "$milestone"
}

# Fetch issue numbers + labels
issues=$(gh issue list -R $OWNER/$REPO --limit 200 --json number,labels)

for row in $(echo "$issues" | jq -r '.[] | @base64'); do
  _jq() { echo "$row" | base64 --decode | jq -r "$1"; }

  num=$(_jq '.number')
  labels=$(_jq '.labels[].name?')

  if [[ $labels == *combat* ]]; then
    assign $num "Combat, Stats & Conditions"
  elif [[ $labels == *npc* ]]; then
    assign $num "NPCs & AI Behavior"
  elif [[ $labels == *magic* ]]; then
    assign $num "Magic Framework & Spellcasting"
  elif [[ $labels == *housing* || $labels == *items* ]]; then
    assign $num "Items, Inventory & Economy"
  elif [[ $labels == *world* ]]; then
    assign $num "World Systems & Rooms"
  elif [[ $labels == *core* ]]; then
    assign $num "Core Server & Framework"
  elif [[ $labels == *quests* || $labels == *tutorial* || $labels == *docs* || $labels == *social* ]]; then
    assign $num "UX, Onboarding & Quality of Life"
  elif [[ $labels == *admin* || $labels == *events* || $labels == *planning* ]]; then
    assign $num "Admin/Builder Tools"
  else
    echo "Unmatched labels for issue #$num"
  fi

done
