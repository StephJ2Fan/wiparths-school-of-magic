# Evennia Project

## Overview

Evennia is a MU* framework built in Python, on Django. It uses a heavily customized Django project as the library, with the gamedir acting as an "overlay" on the evennia library "project". As such, while Django is an important component, it is vital to NOT treat an Evennia game as a Django project, but rather as its own type of project. Some key differences include the lack of a manage.py (this is the evennia library's launcher instead), and the entire typeclass system (which is used instead of creating custom models).

## Typeclasses and Attributes

Evennia's functionality hinges on the usage of *typeclass inheritance* and *attribute access*. Typeclasses are a customized form of Django model, where one can *inherit from* a typeclass and *persist as the same base model* despite the difference in active class. Creating subclasses of the primary typeclasses (Object, Character, Room, Exit, Account, Script) are the key ways to extend functionality of game mechanics.

Since the typeclass system means all objects share a fairly small set of defined model fields, there is an Attribute system - a different special Model - that acts as dynamic arbitrary "fields" on the typeclasses. Evennia handles serializing the data - anything that is a typeclassed object or a python built-in type can be assigned to and retrieved from an Attribute with NO additional validation.

Basic Attribute access and assignment is the format `obj.db.attrname` - where the `.db.` is a convenience accessor for the attributes handler `obj.attributes`. You NEVER need to validate the existence of an attribute's name - it will always simply return `None` if it doesn't exist. Do not use hasattr, getattr or setattr on the Attribute system.

Bad:
```
if hasattr(obj.db, "attrname"):
    print("There is no 'attrname' attribute.")
```
Good:
```
if obj.db.attrname is None:
    print("There is no 'attrname' attribute.")
```

(Note: for simple boolean values, it is better to use the tags system. Review documentation for Tag and obj.tags if needed.)

For non-persistent arbitrary data on objects, there is a parallel `obj.ndb`/`obj.nattributes`

## Utilities: When NOT to Implement Your Own Solution

Evennia comes with a large suite of useful utility functions, classes, and other tools, which are in `evennia.utils` - this includes the contained packages of `create` for creating any persistent entities, `search` for finding existing persistent entities, `evform` and `evmenu` for specialized formatting and interaction menus, and `utils` (that's `evennia.utils.utils`) for additional useful functions.

ALWAYS check if Evennia has any utility helper functions which will serve the need before writing your own.

## Prototypes and Spawning

While the Typeclass and Attributes system is how game mechanics are *connected to database entries*, it is of vital importance not to confuse *definining typeclasses* with *actual data creation*. Typeclasses do have some useful hooks for setting up initial data, but those should ideally be used only for ensuring that the code systems attached to the class have the expected Attribute data necessary to function.

When defining *actual data*, it is best to use the Prototypes system. This is a system which allows for defining reusable data as dicts that can be used to create an in-game object that has all of those attributes. For example, you can have a single `WanderingNPC` typeclass that defines the code logic for a character-based typeclass that can wander around the map, and then define individual prototypes for different wandering NPCs - a deer, a goblin, a lost hiker, etc. - which all use the same *code logic* but have different *definitive data*.

## Commands

Commands are the method by which players interact with the game. All text inputs that are received from players are parsed through the cmdhandler to identify which, if any, Command classes available in their cmdset match, and then execute those commands.

Commands can be treated as asynchronous - the twisted event loop back-end they rely on means they aren't *truly* async, but it's close enough for planning purposes. Commands also have a special feature where you can use `yield` in them to retrieve inputs from the player - but only from within the `func` method of the command class.

Example:
```
class ExampleCommand(Command):
    key = "not a real command"

    def func(self):
        response = yield "Is your refrigerator running?"
        if response.lower() in ("yes","y"):
            self.msg("Then you had better go catch it!")
```

The cmdhandler assigns many useful attributes to the instantiated command object before running the command, which can always be assumed to exist:

- self.caller (the entity which the command was input from)
- self.account (the account of the caller - may be the same)
- self.session (the specific session that command input came from)
- self.cmdstring (the actual string key used, if the command has aliases)
- self.args (the text that came after the matched command key)

Treat these as a given and use them.

When inheriting at any distance from MuxCommand, a large number of additional attributes are available due to its more complex parsing. See MuxCommand for details when necessary.

## Testing

Evennia uses `unittest` through Django and has custom test cases for convenient testing of typeclasses and commands. Subclass `EvenniaTest` when writing tests involving persistent typeclasses, or `EvenniaCommandTest` when needing to test Commands. For true unit tests that don't intersect with (or are mocking) any Django or Evennia objects, use the basic Django `TestCase`.

Running evennia tests MUST use the evennia launcher to ensure the Django settings load correctly: `evennia test path.to.test.module`

## Quick Reference

- Need new in-game mechanics? Subclass a base typeclass.
- Need data variation? Prototype, not new typeclass.
- Need persistent flag? Tag (else attribute for complex data).
- Need persistent object? evennia.utils.create.* helpers or evennia.prototype.spawner.spawn.
- Need persistent attributes? obj.db.attr or obj.attributes.get/add
- Need search? caller.search in a command or interactive, evennia.utils.search.* helpers elsewhere.
- Need interactive menu? evmenu
- Need custom layout? evform
- Running tests? evennia test path.to.test
