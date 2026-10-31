--[[
    Jules Mod for Minetest / Luanti
    "We say goodbye to Google Jules. Most loved tool in the world. GOODBYE"

    Features:
    - Monster mob: "jules:jules" using Mobs Redo API
    - Spawn egg: "jules:jules"
    - Natural spawning: Nighttime / dark spawns on dirt & stone
    - 4 Google Font letter blocks: G, O, L, E with crafting recipes
]]

local modname = minetest.get_current_modname() or "jules"

-- =====================================================================
-- 1. Register Blocks (G, O, L, E) in Google Font
-- =====================================================================

local letter_blocks = {
    {id = "block_g", desc = "Google Font Block (G)", texture = "jules_block_g.png", dye = "dye:blue"},
    {id = "block_o", desc = "Google Font Block (O)", texture = "jules_block_o.png", dye = "dye:red"},
    {id = "block_l", desc = "Google Font Block (L)", texture = "jules_block_l.png", dye = "dye:yellow"},
    {id = "block_e", desc = "Google Font Block (E)", texture = "jules_block_e.png", dye = "dye:green"},
}

for _, block in ipairs(letter_blocks) do
    minetest.register_node(modname .. ":" .. block.id, {
        description = block.desc,
        tiles = {block.texture},
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        sounds = default.node_sound_stone_defaults and default.node_sound_stone_defaults() or nil,
    })

    -- Crafting recipe: Dye + Stone/Clean Block = Letter Block
    if minetest.register_craft then
        minetest.register_craft({
            output = modname .. ":" .. block.id,
            recipe = {
                {"", block.dye, ""},
                {"", "default:stone", ""},
                {"", "", ""},
            }
        })
    end
end

-- Also a recipe to cycle through the letters (G -> O -> L -> E -> G)
if minetest.register_craft then
    minetest.register_craft({
        output = modname .. ":block_o",
        recipe = {{modname .. ":block_g"}}
    })
    minetest.register_craft({
        output = modname .. ":block_l",
        recipe = {{modname .. ":block_o"}}
    })
    minetest.register_craft({
        output = modname .. ":block_e",
        recipe = {{modname .. ":block_l"}}
    })
    minetest.register_craft({
        output = modname .. ":block_g",
        recipe = {{modname .. ":block_e"}}
    })
end

-- =====================================================================
-- 2. Register Jules Monster Mob using Mobs Redo
-- =====================================================================

if minetest.global_exists("mobs") and mobs.register_mob then
    mobs:register_mob(modname .. ":jules", {
        type = "monster",
        passive = false,
        attack_type = "dogfight",
        attack_players = true,
        attack_animals = false,
        attack_npcs = true,
        attack_monsters = false,
        reach = 2,
        damage = 4,
        hp_min = 20,
        hp_max = 35,
        armor = 90,
        collisionbox = {-0.35, -0.4, -0.35, 0.35, 0.6, 0.35},
        visual = "upright_sprite",
        visual_size = {x = 1.1, y = 1.1},
        textures = {
            {"jules_mob.png"},
        },
        blood_amount = 12,
        blood_texture = "jules_mob.png",
        makes_footstep_sound = false,
        sounds = {
            random = "default_cool_lava",
            war_cry = "default_cool_lava",
            attack = "default_punch",
            damage = "default_hurt",
            death = "default_death",
            distance = 16,
        },
        walk_velocity = 1.8,
        run_velocity = 3.6,
        jump = true,
        jump_height = 1.1,
        view_range = 14,
        walk_chance = 75,
        stand_chance = 25,
        water_damage = 0,
        lava_damage = 4,
        light_damage = 0,
        fall_damage = true,
        fear_height = 4,
        floats = 1,
        drops = {
            {name = modname .. ":block_g", chance = 2, min = 1, max = 1},
            {name = modname .. ":block_o", chance = 2, min = 1, max = 1},
            {name = modname .. ":block_l", chance = 2, min = 1, max = 1},
            {name = modname .. ":block_e", chance = 2, min = 1, max = 1},
            {name = "default:mese_crystal_fragment", chance = 3, min = 1, max = 2},
        },
        on_die = function(self, pos)
            minetest.chat_send_all("Goodbye Jules! You were the most loved tool in the world.")
        end,
    })

    -- =================================================================
    -- 3. Register Spawn Egg
    -- =================================================================
    mobs:register_egg(modname .. ":jules", "Spawn Jules", "jules_egg.png", 0)

    -- =================================================================
    -- 4. Register Natural Spawning
    -- =================================================================
    mobs:spawn({
        name = modname .. ":jules",
        nodes = {"group:dirt", "group:stone", "default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
        neighbors = {"air"},
        min_light = 0,
        max_light = 8,
        interval = 30,
        chance = 6000,
        active_object_count = 2,
        min_height = -31000,
        max_height = 31000,
        day_toggle = false, -- spawns at night / in dark caves
    })
else
    minetest.log("warning", "[jules] mobs_redo mod is missing! Jules monster could not be registered.")
end
