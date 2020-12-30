# Utilities for PICO-8

Small utilities to copy-paste and tweak to become as specific as possible to _your_ game, ensuring no waste around token usage. Welcome to PICO-8!

## Shoot for the Moon!

All of these are part of [Shoot for the Moon!](https://jgradim.itch.io/shoot-for-the-moon), [@jgradim](https://github.com/jgradim)'s, [@pkoch](https://github.com/pkoch)'s and mine entry for [Game Off 2020](https://itch.io/jam/game-off-2020).

The source code at the time of submission can be found [here](https://github.com/jgradim/gameoff-2020/blob/24d1a5e196d25ded0444eea2a28666d4e947cbbf/moonshot.p8).

## Path finding

Path findind didn't make it to the final submission itself, but is used [here](https://github.com/jgradim/gameoff-2020/blob/279f97415dace0b907709a003bf378137e87d81d/moonshot.p8) (search for `path` to find its declaration and usage).

Here is a demo:

![Green finds red](https://user-images.githubusercontent.com/102931/103327540-d9fae300-4a4c-11eb-845c-5b5a8dc530ff.gif)

Note that the search works by simulating "actions" (represented by player functions) and analyzing results. If the state of the world is not the same during search and and application, it might lead to different results.

## Collisions

Collision handling is quite powerful, allowing your sprite to define internal rectangles for pixel-perfect collisions.

Here is an example:

![T sprite](https://user-images.githubusercontent.com/102931/103326597-f9900c80-4a48-11eb-9155-9aa1d858f5f8.png)

And the respective hitbox definition: `[65]={{0,0,8,6},{1,0,6,8}}`

If you only want tile-based collisions (i.e., 8x8), most of the code that deals with hitboxes is unecessary and should be deleted.
