#!/opt/homebrew/bin/bash

REPO="StephJ2Fan/wiparths-school-of-magic"

MILESTONES=(
"Release 1.0 — Core System Foundation|2026-01-15T00:00:00Z"
"Release 1.1 — Magic System Alpha|2026-03-15T00:00:00Z"
"Release 1.2 — Worldbuilding Pass 1|2026-05-15T00:00:00Z"
"Release 1.3 — NPC & Creatures Framework|2026-07-15T00:00:00Z"
"Release 1.4 — Items & Crafting|2026-09-15T00:00:00Z"
"Release 1.5 — Quests System|2026-11-15T00:00:00Z"
"Release 1.6 — Combat & Encounters|2027-01-15T00:00:00Z"
"Release 1.7 — Flying & Movement Enhancements|2027-03-15T00:00:00Z"
"Release 1.8 — Social & Events|2027-05-15T00:00:00Z"
"Release 1.9 — Housing & Ownership|2027-07-15T00:00:00Z"
"Release 1.10 — Docs, Tutorials, and Testing|2027-09-15T00:00:00Z"
)

existing=$(gh api repos/$REPO/milestones --jq '.[].number' 2>/dev/null)
total_existing=$(echo "$existing" | wc -w | tr -d ' ')

echo "Deleting existing milestones ($total_existing)..."

i=1
for mid in $existing; do
  gh api repos/$REPO/milestones/$mid -X DELETE >/dev/null 2>&1
  echo "Deleted milestone $mid ($i of $total_existing)"
  ((i++))
done

echo "Creating new milestones with due dates..."
i=1
total_new=${#MILESTONES[@]}

for entry in "${MILESTONES[@]}"; do
  title="${entry%%|*}"
  date="${entry##*|}"

  gh api repos/$REPO/milestones \
    -X POST \
    -f title="$title" \
    -f due_on="$date" >/dev/null 2>&1

  echo "Created milestone: '$title' with due date $date ($i of $total_new)"
  ((i++))
done

echo "Milestone setup complete."
