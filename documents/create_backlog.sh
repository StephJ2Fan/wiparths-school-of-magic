#!/bin/bash

OWNER="StephJ2Fan"
REPO="wiparths-school-of-magic"
ASSIGNEE="StephJ2Fan"

DRYRUN=false

# parse arguments
if [[ "$1" == "--dry-run" || "$1" == "-n" ]]; then
    DRYRUN=true
    echo "Running in DRY RUN mode. No issues will be created."
fi

########################################
# ISSUE CREATION ENGINE
########################################

create_issue() {
    local title="$1"
    local body="$2"
    local milestone="$3"
    local label="$4"

    # duplicate check by exact title match
    if gh issue list -R "$OWNER/$REPO" --state all \
        --search "\"$title\"" --json title | \
        jq -e '.[] | select(.title=="'"$title"'")' >/dev/null; then
        echo "SKIP (already exists): $title"
        return
    fi

    if $DRYRUN; then
        echo "DRY RUN -> Would create: $title"
        return
    fi

    echo "CREATING: $title"
    gh issue create \
      -R "$OWNER/$REPO" \
      --title "$title" \
      --body "$body" \
      --milestone "$milestone" \
      --label "$label" \
      --assignee "$ASSIGNEE"
}

########################################
# YOUR ISSUE DEFINITIONS (trimmed for clarity)
########################################

M="Admin/Builder Tools"
L="admin"

create_issue \
"Implement role-based permission system for staff roles" \
"## Description
Hierarchical roles and promotion/demotion flow.

## Acceptance Criteria
- [ ] Roles persisted
- [ ] Role enforcement
- [ ] Role-based commands validated
" \
"$M" "$L"

create_issue \
"Add admin command for promoting and demoting accounts" \
"## Description
Admin-level account role modification.

## Acceptance Criteria
- [ ] Admins can modify roles
- [ ] Roles validated
- [ ] Errors handled
- [ ] Actions logged
" \
"$M" "$L"

create_issue \
"Implement moderation logging system" \
"## Description
Store all moderation and staff actions.

## Acceptance Criteria
- [ ] Logs stored
- [ ] Logs queryable
- [ ] Staff access only
" \
"$M" "$L"

create_issue \
"Add admin-only account inspection tool" \
"## Description
Admin view into account/user state.

## Acceptance Criteria
- [ ] Staff can inspect accounts
- [ ] Displays role/state/history
- [ ] Errors handled cleanly
" \
"$M" "$L"

create_issue \
"Implement builder/admin online list and staff console commands" \
"## Description
Show online players and staff state.

## Acceptance Criteria
- [ ] Show online players
- [ ] Show staff roles
- [ ] Restricted to staff
" \
"$M" "$L"


########################################
# POST-CREATION VERIFICATION
########################################
if ! $DRYRUN; then
    echo ""
    echo "====== VERIFYING MILESTONES ======"
    gh issue list -R "$OWNER/$REPO" --limit 200 \
      --json number,title,milestone --jq '.[] | "\(.number)  →  \(.milestone.title)"'
fi

echo ""
echo "Done."
