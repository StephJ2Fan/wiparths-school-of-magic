#!/opt/homebrew/bin/bash

REPO="StephJ2Fan/wiparths-school-of-magic"

declare -A LABELS=(
  ["admin"]="#E99695"
  ["characters"]="#EF9A9A"
  ["combat"]="#C62828"
  ["completed"]="#4CAF50"
  ["considering"]="#03A9F4"
  ["core"]="#6A1B9A"
  ["crafting"]="#8D6E63"
  ["data"]="#00897B"
  ["docs"]="#1E88E5"
  ["events"]="#FDD835"
  ["flying"]="#FFB300"
  ["housing"]="#8E24AA"
  ["items"]="#5E35B1"
  ["magic"]="#7E57C2"
  ["not planned"]="#9E9E9E"
  ["npc"]="#3949AB"
  ["planning"]="#1565C0"
  ["quests"]="#43A047"
  ["social"]="#00ACC1"
  ["testing"]="#EF5350"
  ["tutorial"]="#29B6F6"
  ["world"]="#4FC3F7"
  ["events"]="#FDD835"
)

echo "Deleting existing labels..."
existing=$(gh label list --repo "$REPO" --json name --jq '.[].name' 2>/dev/null)
deleted=0

for lbl in $existing; do
  gh label delete "$lbl" --repo "$REPO" --yes >/dev/null 2>&1
  ((deleted++))
done

echo "Deleted $deleted labels."

echo "Creating labels..."
count=0
for name in "${!LABELS[@]}"; do
  color="${LABELS[$name]}"
  gh label create "$name" --color "$color" --repo "$REPO" >/dev/null 2>&1
  echo "Created: $name"
  ((count++))
done

echo "Created $count labels."
