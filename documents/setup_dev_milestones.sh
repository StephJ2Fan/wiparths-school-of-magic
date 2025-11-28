#!/opt/homebrew/bin/bash

REPO="StephJ2Fan/wiparths-school-of-magic"

echo "Fetching existing release milestones..."

RELEASES=$(gh api repos/$REPO/milestones --jq '.[] | select(.title|startswith("Release"))')

if [[ -z "$RELEASES" ]]; then
  echo "No Release milestones found. Exiting."
  exit 1
fi

echo "Creating Dev milestones (7 days earlier)..."

count=0

while IFS="|" read -r title due; do

  # Prefix Dev
  dev_title="Dev $title"

# Convert to epoch, subtract 7 days, convert back
dev_due=$(date -u -jf "%Y-%m-%dT%H:%M:%SZ" "$due" +"%s")
dev_due=$(date -u -r $((dev_due-604800)) +"%Y-%m-%dT%H:%M:%SZ")




  echo "Creating: '$dev_title' (due: $dev_due)"

  gh api repos/$REPO/milestones \
    -X POST \
    -f title="$dev_title" \
    -f due_on="$dev_due" >/dev/null 2>&1

  if [[ $? -eq 0 ]]; then
    echo "  ✔ Created"
  else
    echo "  ⚠ Failed"
  fi

  ((count++))

done < <(
  # This formatting matches your original working script style
  echo "$RELEASES" | jq -r '.title + "|" + .due_on'
)

echo "Dev milestone setup complete. Total created: $count"
