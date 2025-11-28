#!/opt/homebrew/bin/bash

REPO="StephJ2Fan/wiparths-school-of-magic"

create_issue() {
  local title="$1"
  local body="$2"
  local milestone_title="$3"
  shift 3
  local labels=("$@")

  local args=(--repo "$REPO" --title "$title" --body "$body" --milestone "$milestone_title")
  for lbl in "${labels[@]}"; do
    args+=(--label "$lbl")
  done

  if gh issue create "${args[@]}" >/dev/null 2>&1; then
    echo "Created issue: $title"
    return 0
  else
    echo "Failed to create issue: $title"
    return 1
  fi
}

echo "Creating issues..."
success=0
failure=0

create_issue "Define core technical direction" "Document high-level technical goals and constraints for the project." "Release 1.0 — Core System Foundation" planning core && ((success++)) || ((failure++))
create_issue "Setup core project structure" "Create initial repository layout for the Evennia-based MUD, including game, server, and config directories." "Release 1.0 — Core System Foundation" planning core && ((success++)) || ((failure++))
create_issue "Implement base Account and Character models" "Verify and extend Evennia default Account and Character models to match game needs." "Release 1.0 — Core System Foundation" core data && ((success++)) || ((failure++))
create_issue "Implement base Room typeclass" "Create a custom Room typeclass for the wizard school environment." "Release 1.0 — Core System Foundation" core world && ((success++)) || ((failure++))
create_issue "Implement base Exit typeclass" "Create a custom Exit typeclass to support castle corridors and special door behaviors." "Release 1.0 — Core System Foundation" core world && ((success++)) || ((failure++))
create_issue "Implement basic player commands" "Ensure look, say, get, drop, inventory, and movement commands work and are themed for the setting." "Release 1.0 — Core System Foundation" core && ((success++)) || ((failure++))
create_issue "Implement admin and builder commands" "Set up core admin and builder commands for spawning, editing, and inspecting objects and rooms." "Release 1.0 — Core System Foundation" admin core && ((success++)) || ((failure++))
create_issue "Configure logging and error reporting" "Set up structured logging for server events, errors, and debug output." "Release 1.0 — Core System Foundation" core testing && ((success++)) || ((failure++))

create_issue "Design magic system overview" "Write a short design document outlining goals and constraints for the magic system." "Release 1.1 — Magic System Alpha" planning magic && ((success++)) || ((failure++))
create_issue "Implement spell registry" "Create a central registry for all spells, including metadata like difficulty and school." "Release 1.1 — Magic System Alpha" magic data && ((success++)) || ((failure++))
create_issue "Implement base Spell typeclass" "Create a Spell typeclass or handler that defines common spell behavior." "Release 1.1 — Magic System Alpha" magic && ((success++)) || ((failure++))
create_issue "Implement cast spell command" "Add a cast command that allows players to cast spells at targets with basic validation." "Release 1.1 — Magic System Alpha" magic core && ((success++)) || ((failure++))
create_issue "Implement spell resource and fatigue system" "Add a resource or fatigue system that limits how often spells can be cast." "Release 1.1 — Magic System Alpha" magic && ((success++)) || ((failure++))
create_issue "Implement spell Lumos" "Add Lumos as a simple utility spell that affects lighting or visibility." "Release 1.1 — Magic System Alpha" magic world && ((success++)) || ((failure++))
create_issue "Implement spell Expelliarmus" "Add Expelliarmus as a combat-related disarming spell." "Release 1.1 — Magic System Alpha" magic combat && ((success++)) || ((failure++))
create_issue "Implement spell Wingardium Leviosa" "Add Wingardium Leviosa as a spell that manipulates or moves objects." "Release 1.1 — Magic System Alpha" magic world && ((success++)) || ((failure++))

create_issue "Draft high-level world map" "Sketch a first pass of the school layout, key locations, and travel flows." "Release 1.2 — Worldbuilding Pass 1" planning world && ((success++)) || ((failure++))
create_issue "Build starter zone: castle entrance" "Create rooms and exits for the main entrance area of the school." "Release 1.2 — Worldbuilding Pass 1" world && ((success++)) || ((failure++))
create_issue "Build dormitories for each house" "Create dormitory room clusters for each house, including common rooms." "Release 1.2 — Worldbuilding Pass 1" world housing && ((success++)) || ((failure++))
create_issue "Build first classroom" "Create the first classroom zone for early lessons and quests." "Release 1.2 — Worldbuilding Pass 1" world && ((success++)) || ((failure++))
create_issue "Build courtyard or outdoor test area" "Create an outdoor zone where testing, duels, or practice can occur." "Release 1.2 — Worldbuilding Pass 1" world && ((success++)) || ((failure++))
create_issue "Implement ambient room events" "Add periodic ambient messages and magical flavor text to key rooms." "Release 1.2 — Worldbuilding Pass 1" world events && ((success++)) || ((failure++))
create_issue "Implement house assignment flow" "Create a basic flow to assign new characters to a house." "Release 1.2 — Worldbuilding Pass 1" world social && ((success++)) || ((failure++))
create_issue "Define core travel paths between key rooms" "Ensure intuitive routes between entrance, dorms, classroom, and courtyard." "Release 1.2 — Worldbuilding Pass 1" world && ((success++)) || ((failure++))

create_issue "Design NPC taxonomy" "Define categories and roles for NPCs such as teachers, students, and creatures." "Release 1.3 — NPC & Creatures Framework" planning npc && ((success++)) || ((failure++))
create_issue "Implement base NPC typeclass" "Create a base NPC typeclass with stats, behavior hooks, and messaging." "Release 1.3 — NPC & Creatures Framework" npc && ((success++)) || ((failure++))
create_issue "Implement base Creature typeclass" "Create a base creature typeclass for non-humanoid magical beings." "Release 1.3 — NPC & Creatures Framework" npc combat && ((success++)) || ((failure++))
create_issue "Implement NPC dialogue handler" "Add a simple dialogue or conversation handler for interacting with NPCs." "Release 1.3 — NPC & Creatures Framework" npc social && ((success++)) || ((failure++))
create_issue "Implement teacher NPC archetype" "Create a template or archetype for teacher NPCs with appropriate behaviors." "Release 1.3 — NPC & Creatures Framework" npc && ((success++)) || ((failure++))
create_issue "Implement student NPC archetype" "Create a template or archetype for student NPCs with ambient behaviors." "Release 1.3 — NPC & Creatures Framework" npc && ((success++)) || ((failure++))
create_issue "Implement roaming behavior for NPCs" "Allow selected NPCs to wander between rooms on a schedule." "Release 1.3 — NPC & Creatures Framework" npc world && ((success++)) || ((failure++))

create_issue "Design item categories and flags" "Define item categories, rarity, and flags such as magical, quest, or consumable." "Release 1.4 — Items & Crafting" planning items && ((success++)) || ((failure++))
create_issue "Implement base Item typeclass" "Create a base Item typeclass that supports stacking, descriptions, and flags." "Release 1.4 — Items & Crafting" items && ((success++)) || ((failure++))
create_issue "Improve inventory handling" "Polish inventory viewing and management commands for players." "Release 1.4 — Items & Crafting" items core && ((success++)) || ((failure++))
create_issue "Implement containers" "Add container items such as trunks or bags with capacity limits." "Release 1.4 — Items & Crafting" items housing && ((success++)) || ((failure++))
create_issue "Design crafting system model" "Outline how crafting recipes, ingredients, and results will work." "Release 1.4 — Items & Crafting" planning crafting && ((success++)) || ((failure++))
create_issue "Implement recipe registry" "Create a registry to hold crafting recipes and their requirements." "Release 1.4 — Items & Crafting" crafting data && ((success++)) || ((failure++))
create_issue "Implement basic crafting command" "Add a command that allows players to craft items using known recipes." "Release 1.4 — Items & Crafting" crafting items && ((success++)) || ((failure++))

create_issue "Design quest structure and states" "Define how quests are represented, including steps, states, and rewards." "Release 1.5 — Quests System" planning quests && ((success++)) || ((failure++))
create_issue "Implement quest registry" "Create a central registry for all quests." "Release 1.5 — Quests System" quests data && ((success++)) || ((failure++))
create_issue "Implement quest state tracking per character" "Track a character's active, completed, and failed quests." "Release 1.5 — Quests System" quests data && ((success++)) || ((failure++))
create_issue "Implement quest journal command" "Add a command for players to view their active and completed quests." "Release 1.5 — Quests System" quests && ((success++)) || ((failure++))
create_issue "Implement teacher quest-giver NPC" "Add at least one teacher NPC that can assign and complete quests." "Release 1.5 — Quests System" quests npc && ((success++)) || ((failure++))
create_issue "Implement quest rewards" "Implement rewards such as XP, spells, or items on quest completion." "Release 1.5 — Quests System" quests items magic && ((success++)) || ((failure++))
create_issue "Implement class attendance quest loop" "Create a basic loop of attending class, completing a task, and receiving rewards." "Release 1.5 — Quests System" quests social events && ((success++)) || ((failure++))

create_issue "Design combat system goals" "Document goals and constraints for the combat and encounter system." "Release 1.6 — Combat & Encounters" planning combat && ((success++)) || ((failure++))
create_issue "Implement combat handler" "Create a central handler to manage combat turns and resolutions." "Release 1.6 — Combat & Encounters" combat core && ((success++)) || ((failure++))
create_issue "Implement basic attack command" "Add a simple attack command that works with the combat handler." "Release 1.6 — Combat & Encounters" combat && ((success++)) || ((failure++))
create_issue "Integrate spells into combat resolution" "Allow combat to use spells as actions within fights." "Release 1.6 — Combat & Encounters" combat magic && ((success++)) || ((failure++))
create_issue "Implement damage types and resistances" "Add different damage types and resistance handling for creatures and players." "Release 1.6 — Combat & Encounters" combat && ((success++)) || ((failure++))
create_issue "Implement defeat and death handling" "Define what happens when a character or creature is defeated or knocked out." "Release 1.6 — Combat & Encounters" combat && ((success++)) || ((failure++))
create_issue "Implement encounter spawning in selected rooms" "Add simple encounter spawning logic for specific rooms or zones." "Release 1.6 — Combat & Encounters" combat world && ((success++)) || ((failure++))
create_issue "Add combat logging and debug tools" "Provide additional logging and tools for testing combat scenarios." "Release 1.6 — Combat & Encounters" combat testing && ((success++)) || ((failure++))

create_issue "Design flying rules and constraints" "Document how flying works, where it is allowed, and its risks." "Release 1.7 — Flying & Movement Enhancements" planning flying && ((success++)) || ((failure++))
create_issue "Implement broom item" "Create broom items that can enable flying mode for characters." "Release 1.7 — Flying & Movement Enhancements" flying items && ((success++)) || ((failure++))
create_issue "Implement flying movement mode" "Add a flying movement mode with appropriate commands and restrictions." "Release 1.7 — Flying & Movement Enhancements" flying && ((success++)) || ((failure++))
create_issue "Mark safe and restricted flight zones" "Mark which rooms or areas allow or forbid flying." "Release 1.7 — Flying & Movement Enhancements" flying world && ((success++)) || ((failure++))
create_issue "Implement flight hazards and failures" "Add basic hazards or failure chances while flying in certain areas." "Release 1.7 — Flying & Movement Enhancements" flying events && ((success++)) || ((failure++))

create_issue "Design social feature set" "Document which social features and commands are in scope for the first release." "Release 1.8 — Social & Events" planning social && ((success++)) || ((failure++))
create_issue "Implement emote and social commands" "Add common social and emote commands for player expression." "Release 1.8 — Social & Events" social && ((success++)) || ((failure++))
create_issue "Implement house points tracking" "Add tracking for house points as a shared house-level score." "Release 1.8 — Social & Events" social data && ((success++)) || ((failure++))
create_issue "Implement scheduled school events system" "Create a simple scheduler for recurring school events." "Release 1.8 — Social & Events" events social && ((success++)) || ((failure++))
create_issue "Implement announcement and broadcast tools" "Add commands for staff to send announcements or event reminders." "Release 1.8 — Social & Events" events admin && ((success++)) || ((failure++))
create_issue "Implement basic club or group membership system" "Allow players to join and leave clubs or groups linked to social activities." "Release 1.8 — Social & Events" social && ((success++)) || ((failure++))

create_issue "Design housing and ownership rules" "Document how player housing and room ownership should work." "Release 1.9 — Housing & Ownership" planning housing && ((success++)) || ((failure++))
create_issue "Implement player-owned room model" "Add support for rooms that can be owned by players or groups." "Release 1.9 — Housing & Ownership" housing world && ((success++)) || ((failure++))
create_issue "Implement room claim and release flow" "Add commands or processes to claim and relinquish ownership of rooms." "Release 1.9 — Housing & Ownership" housing && ((success++)) || ((failure++))
create_issue "Implement basic room customization" "Allow limited customization of owned rooms such as descriptions or decor items." "Release 1.9 — Housing & Ownership" housing items && ((success++)) || ((failure++))
create_issue "Implement secure storage containers" "Add secure storage options in owned rooms for items." "Release 1.9 — Housing & Ownership" housing items && ((success++)) || ((failure++))
create_issue "Implement access permissions for owned rooms" "Add access control so only allowed players can enter or modify owned rooms." "Release 1.9 — Housing & Ownership" housing admin && ((success++)) || ((failure++))

create_issue "Write developer setup documentation" "Create documentation describing how to set up the development environment and run the server." "Release 1.10 — Docs, Tutorials, and Testing" docs && ((success++)) || ((failure++))
create_issue "Write player getting-started guide" "Write a short guide to help new players create characters and move around." "Release 1.10 — Docs, Tutorials, and Testing" docs tutorial && ((success++)) || ((failure++))
create_issue "Implement in-game tutorial flow" "Add a simple in-game tutorial or onboarding quest for new players." "Release 1.10 — Docs, Tutorials, and Testing" tutorial quests && ((success++)) || ((failure++))
create_issue "Expand automated test coverage for core systems" "Add tests for core systems such as rooms, commands, and magic." "Release 1.10 — Docs, Tutorials, and Testing" testing core && ((success++)) || ((failure++))
create_issue "Add debugging commands for admins" "Provide extra admin-only commands to inspect and debug game state." "Release 1.10 — Docs, Tutorials, and Testing" admin testing && ((success++)) || ((failure++))
create_issue "Create release checklist and maintenance docs" "Document release checklist, backup routines, and ongoing maintenance tasks." "Release 1.10 — Docs, Tutorials, and Testing" docs && ((success++)) || ((failure++))

echo "Issue creation attempted."
echo "Successfully created: $success"
echo "Failed to create: $failure"
