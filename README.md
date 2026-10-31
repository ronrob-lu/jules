# Jules Mod for Luanti / Minetest

<p align="center">
  <img src="screenshot.png" alt="Jules Mod Screenshot" width="160" />
</p>
> Jules will wind down on December 31, 2026. You have until November 11th to continue finishing up sessions. After the 11th of November, we will be turning it to read-only until end of year. Try using Google Antigravity for agentic development.

> *"We say goodbye to Google Jules. Most loved tool in the world. GOODBYE."*

This mod was created in tribute following the announcement of Jules winding down. A memorial mod for **Luanti** (formerly **Minetest**) introducing the **Jules Monster Mob**, a custom **Spawn Egg**, natural world spawning, and 4 Google Font letter blocks (**G**, **O**, **L**, **E**).

---

## Features

### 1. Jules Monster Mob (`jules:jules`)
- Powered by the **Mobs Redo** (`mobs`) API.
- Aggressive monster mob that roams the world, attacking players and hostile intruders.
- Drops Google Font letter blocks (`jules:block_g`, `jules:block_o`, `jules:block_l`, `jules:block_e`) and mese crystal fragments when defeated.
- Broadcasts a memorial message to the server chat upon death:
  > *"Goodbye Jules! You were the most loved tool in the world."*

### 2. Spawn Egg
- Creative / inventory spawn egg (`jules:jules` / "Spawn Jules") allowing players to spawn Jules anytime.
- Uses a custom spotted purple egg texture (`jules_egg.png`).

### 3. Natural Spawning
- Jules spawns naturally in the Luanti world at an incredibly high frequency across land at all times (day and night)!
- Spawns across all land nodes including grass, dirt, sand, gravel, and stone surfaces.

### 4. Google Font Letter Blocks (`G`, `O`, `L`, `E`)
- Four commemorative decorative building blocks rendered using Google's signature typeface (Roboto Bold) and Google's signature brand colors:
  - **G Block** (`jules:block_g`): Google Blue (`#4285F4`)
  - **O Block** (`jules:block_o`): Google Red (`#EA4335`)
  - **L Block** (`jules:block_l`): Google Yellow (`#FBBC05`)
  - **E Block** (`jules:block_e`): Google Green (`#34A853`)
- **Crafting Recipes**:
  - `dye:blue` + `default:stone` $\rightarrow$ `jules:block_g`
  - `dye:red` + `default:stone` $\rightarrow$ `jules:block_o`
  - `dye:yellow` + `default:stone` $\rightarrow$ `jules:block_l`
  - `dye:green` + `default:stone` $\rightarrow$ `jules:block_e`
  - In addition, letter blocks can be cycled in a crafting grid: `G` $\rightarrow$ `O` $\rightarrow$ `L` $\rightarrow$ `E` $\rightarrow$ `G`.

### 5. Random "GOOGLE" Word Placements
- Horizontal 6-block rows spelling **GOOGLE** (`G` - `O` - `O` - `G` - `L` - `E`) generate randomly on surface land across the world.

---

## Requirements & Dependencies

- **Luanti** / **Minetest** 5.0.0 or later
- **default** (part of Minetest Game / Luanti default game)
- **mobs** (Mobs Redo API by TenPlus1)

---

## Installation

1. Copy or clone this repository into your Luanti `mods/` folder as `jules`.
2. Enable `mobs` (Mobs Redo) and `jules` in your world configuration.
3. Launch Luanti and explore your world!

---

## License

See `LICENSE.md` for full licensing information:
- **Code**: MIT License
- **Font Assets**: Google Roboto (Apache License, Version 2.0)
- **Jules Artwork**: Google Jules avatar/mascot logo, fair use memorial tribute
