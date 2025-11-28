#!/bin/bash

OWNER="StephJ2Fan"
REPO="wiparths-school-of-magic"

MILESTONES=(
"Core Server & Framework"
"Player Systems & Interaction"
"World Systems & Rooms"
"Magic Framework & Spellcasting"
"NPCs & AI Behavior"
"Combat, Stats & Conditions"
"Items, Inventory & Economy"
"Admin/Builder Tools"
"UX, Onboarding & Quality of Life"
)

LABELS=(
"core-framework"
"player-systems"
"world-building"
"magic-system"
"npc-ai"
"combat-stats"
"items-economy"
"admin-tools"
"ux-polish"
"documentation"
"P1-critical"
"P2-high"
"P3-normal"
"P4-low"
"in-progress"
"blocked"
"needs-discussion"
"ready-to-implement"
"ready-for-test"
"completed"
)

echo "Fetching existing labels..."
existing_labels=$(gh label list -R "$OWNER/$REPO" --json name --jq '.[].name')

echo "Creating missing labels..."
for label in "${LABELS[@]}"; do
  if echo "$existing_labels" | grep -Fxq "$label"; then
    echo "Label '$label' already exists. Skipping..."
  else
    gh label create "$label" \
      -R "$OWNER/$REPO" \
      --color "4B0082"
    echo "Created label '$label'"
  fi
done

echo "Creating milestones..."
for title in "${MILESTONES[@]}"; do
    due=$(date -u -v+90d +"%Y-%m-%dT%H:%M:%SZ")

    # Your fixed date-logic stays the same 👇
    dev_due=$(date -u -jf "%Y-%m-%dT%H:%M:%SZ" "$due" +"%s")
    dev_due=$(date -u -r $((dev_due-604800)) +"%Y-%m-%dT%H:%M:%SZ")

    gh api repos/$OWNER/$REPO/milestones \
      -f title="$title" \
      -f due_on="$dev_due"
done

echo "All labels + milestones processed!"
