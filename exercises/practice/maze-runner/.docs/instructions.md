# Instructions

The entrance and exit to the labyrinth are marked with the same symbol, `⇨`. 
[Box-drawing][] characters draw the maze, while spaces represent the path. 
Your task is to mark the way from the entrance to the exit in the maze with the dots.

For example, the following maze:

```text
────┬─────────┬─────────┬───────┬───┐
⇨   │         │         │       │   │
┌─┐ └─┐ ┌─┐ │ └─┐ ──┬── │ ──┐ │ │ ──┘
│ │   │ │ │ │   │   │   │   │ │ │   ⇨
│ └─┐ │ │ │ ├─┐ └─┐ └─┐ │ ┌─┘ │ │ │ │
│   │ │   │ │ │   │   │ │ │   │ │ │ │
│ ──┘ ├───┘ │ └── │ │ └─┘ │ ┌─┘ │ │ │
│     │     │     │ │     │ │   │ │ │
│ ────┤ ────┴───┐ ├─┴───┐ │ │ ┌─┴─┤ │
│     │         │ │     │ │ │ │   │ │
├──── └──────── │ │ ┌── └─┘ │ │ │ │ │
│               │   │       │   │   │
└───────────────┴───┴───────┴───┴───┘
```

Should be marked like this:

```text
────┬─────────┬─────────┬───────┬───┐
⇨⋅⋅⋅│      ⋅⋅⋅│         │    ⋅⋅⋅│   │
┌─┐⋅└─┐ ┌─┐⋅│⋅└─┐ ──┬── │ ──┐⋅│⋅│ ──┘
│ │⋅⋅⋅│ │ │⋅│⋅⋅⋅│   │   │   │⋅│⋅│  ⋅⇨
│ └─┐⋅│ │ │⋅├─┐⋅└─┐ └─┐ │ ┌─┘⋅│⋅│ │⋅│
│   │⋅│   │⋅│ │⋅⋅⋅│   │ │ │⋅⋅⋅│⋅│ │⋅│
│ ──┘⋅├───┘⋅│ └──⋅│ │ └─┘ │⋅┌─┘⋅│ │⋅│
│⋅⋅⋅⋅⋅│⋅⋅⋅⋅⋅│    ⋅│ │     │⋅│⋅⋅⋅│ │⋅│
│⋅────┤⋅────┴───┐⋅├─┴───┐ │⋅│⋅┌─┴─┤⋅│
│⋅⋅⋅⋅⋅│⋅⋅⋅⋅⋅⋅⋅⋅⋅│⋅│⋅⋅⋅⋅⋅│ │⋅│⋅│⋅⋅⋅│⋅│
├────⋅└────────⋅│⋅│⋅┌──⋅└─┘⋅│⋅│⋅│⋅│⋅│
│    ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅│⋅⋅⋅│  ⋅⋅⋅⋅⋅│⋅⋅⋅│⋅⋅⋅│
└───────────────┴───┴───────┴───┴───┘
```
[Box-drawing]: https://en.wikipedia.org/wiki/Box-drawing_character
