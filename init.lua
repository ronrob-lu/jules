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
    -- Spawns on land at an incredibly high frequency every time (day and night)
    mobs:spawn({
        name = modname .. ":jules",
        nodes = {
            "group:dirt",
            "group:stone",
            "group:sand",
            "default:dirt_with_grass",
            "default:dirt_with_dry_grass",
            "default:dirt_with_coniferous_litter",
            "default:dirt_with_rainforest_litter",
            "default:dirt_with_snow",
            "default:dry_dirt_with_dry_grass",
            "default:desert_sand",
            "default:sand",
            "default:silver_sand",
            "default:stone",
            "default:desert_stone",
            "default:gravel",
        },
        neighbors = {"air"},
        min_light = 0,
        max_light = 15,
        interval = 1,
        chance = 1,
        active_object_count = 100,
        min_height = 1,
        max_height = 31000,
        day_toggle = nil,
    })
else
    minetest.log("warning", "[jules] mobs_redo mod is missing! Jules monster could not be registered.")
end

-- =====================================================================
-- 5. Randomly place "GOOGLE" locks/blocks in the world (6 blocks in a row)
-- =====================================================================

local google_letters = {
    modname .. ":block_g",
    modname .. ":block_o",
    modname .. ":block_o",
    modname .. ":block_g",
    modname .. ":block_l",
    modname .. ":block_e",
}

if minetest.register_on_generated then
    minetest.register_on_generated(function(minp, maxp, seed)
        -- Only generate above sea level / on land
        if maxp.y < 1 or minp.y > 1000 then
            return
        end

        local pr = PseudoRandom and PseudoRandom(seed + 42) or {
            next = function(self, min, max)
                return math.random(min, max)
            end
        }

        -- Attempt placing 1-3 GOOGLE word lines per chunk
        local attempts = pr:next(1, 3)
        for _ = 1, attempts do
            -- Choose a random X, Z within chunk boundaries
            -- Ensure room for 6 blocks along chosen axis
            local axis = pr:next(0, 1) -- 0: along X, 1: along Z
            local rx = (axis == 0) and pr:next(minp.x, maxp.x - 6) or pr:next(minp.x, maxp.x)
            local rz = (axis == 1) and pr:next(minp.z, maxp.z - 6) or pr:next(minp.z, maxp.z)

            -- Scan downwards from maxp.y to find surface land
            local top_y = math.min(maxp.y, 200)
            local bottom_y = math.max(minp.y, 1)

            local ground_y = nil
            for y = top_y, bottom_y, -1 do
                local node = minetest.get_node({x = rx, y = y, z = rz})
                local nodename = node.name
                if nodename ~= "air" and nodename ~= "ignore" then
                    -- Check if it is a solid walkable surface node (not water/liquids)
                    local def = minetest.registered_nodes[nodename]
                    if def and (def.walkable == true or def.walkable == nil) and def.liquidtype == "none" then
                        ground_y = y
                    end
                    break
                end
            end

            if ground_y and ground_y >= bottom_y and (ground_y + 1) <= maxp.y then
                -- Check if space above is clear and flat enough for 6 blocks
                local can_place = true
                for i = 0, 5 do
                    local px = (axis == 0) and (rx + i) or rx
                    local pz = (axis == 1) and (rz + i) or rz

                    local above = minetest.get_node({x = px, y = ground_y + 1, z = pz})
                    local below = minetest.get_node({x = px, y = ground_y, z = pz})
                    local below_def = minetest.registered_nodes[below.name]

                    -- Must have air above and solid land below
                    if above.name ~= "air" or not below_def or below_def.liquidtype ~= "none" then
                        can_place = false
                        break
                    end
                end

                if can_place then
                    for i = 0, 5 do
                        local px = (axis == 0) and (rx + i) or rx
                        local pz = (axis == 1) and (rz + i) or rz
                        minetest.set_node({x = px, y = ground_y + 1, z = pz}, {name = google_letters[i + 1]})
                    end
                end
            end
        end
    end)
end
