-- disable all vanilla recipes
for _,recipe in pairs(data.raw.recipe) do
    recipe.enabled = false

    if recipe.normal then
        recipe.normal.enabled = false
    end
    if recipe.expensive then
        recipe.expensive.enabled = false
    end
end

data:extend{
  ----------------------------------------------------------------
  -- Resources
  {
    type = "item",
    name = "log",
    icon = "__base__/graphics/icons/wood.png",
    icon_size = 64, icon_mipmaps = 4,
    fuel_value = "1MJ",
    fuel_category = "chemical",
    subgroup = "raw-resource",
    order = "a[log]",
    stack_size = 50
  },
  {
    type = "item",
    name = "plank",
    icon = "__base__/graphics/icons/wood.png",
    icon_size = 64, icon_mipmaps = 4,
    fuel_value = "500kJ",
    fuel_category = "chemical",
    order = "a[plank]",
    stack_size = 200
  },
  {
    type = "item",
    name = "seed",
    icon = "__base__/graphics/icons/wood.png",
    icon_size = 64, icon_mipmaps = 4,
    order = "a[seed]",
    stack_size = 50
  },

  ----------------------------------------------------------------
  -- Entities
  {
    type = "item",
    name = "tree-farm",
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "production-machine",
    order = "a[tree-farm]",
    place_result = "tree-farm",
    stack_size = 20
  },

  ----------------------------------------------------------------
  -- Recipes
  {
    type = "recipe",
    -- TODO: it's looking for item-names.split-log and not finding anything
    name = "split-log",
    enabled = true,
    energy_required = 0.5,
    ingredients = {{"log", 1}},
    result = "plank",
    result_count = 2,
  },

  {
    type = "recipe-category",
    name = "tree-farm",
  },
  {
    type = "recipe",
    name = "grow-tree",
    category = "tree-farm",
    enabled = true,
    energy_required = 30,
    ingredients = {{"seed", 1}},
    results = {
      { name = "log", amount_min = 8, amount_max = 12 },
      { name = "seed", amount = 1 },
      { name = "seed", amount = 1, probability = 0.1 },
    },
    main_product = "log",
    -- icon = "__base__/graphics/icons/wood.png",
    -- icon_size = 64, icon_mipmaps = 4,
  },
}

function make_assembling_machine(
    name,
    crafting_categories,
    crafting_speed,
    energy_usage)
  return {
    type = "assembling-machine",
    name = name,
    icon = "__base__/graphics/icons/assembling-machine-1.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = name},
    max_health = 300,
    corpse = "assembling-machine-1-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    collision_box = {{-2.2, -2.2}, {2.2, 2.2}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    -- damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "assembling-machine",
    -- next_upgrade = "assembling-machine-2",
    alert_icon_shift = util.by_pixel(-3, -12),
    animation =
    {
      layers =
      {
        {
          filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1.png",
          priority="high",
          width = 108,
          height = 114,
          frame_count = 32,
          line_length = 8,
          shift = util.by_pixel(0, 2),
          hr_version =
          {
            filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1.png",
            priority="high",
            width = 214,
            height = 226,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, 2),
            scale = 0.5
          }
        },
        {
          filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-shadow.png",
          priority="high",
          width = 95,
          height = 83,
          frame_count = 1,
          line_length = 1,
          repeat_count = 32,
          draw_as_shadow = true,
          shift = util.by_pixel(8.5, 5.5),
          hr_version =
          {
            filename = "__base__/graphics/entity/assembling-machine-1/hr-assembling-machine-1-shadow.png",
            priority="high",
            width = 190,
            height = 165,
            frame_count = 1,
            line_length = 1,
            repeat_count = 32,
            draw_as_shadow = true,
            shift = util.by_pixel(8.5, 5),
            scale = 0.5
          }
        }
      }
    },
    crafting_categories = crafting_categories,
    crafting_speed = crafting_speed,
    -- energy_source =
    -- {
    --   type = "burner",
    --   usage_priority = "secondary-input",
    --   emissions_per_minute = 4
    -- },
    energy_source =
    {
      type = "burner",
      fuel_category = "chemical",
      effectivity = 1,
      fuel_inventory_size = 1,
      emissions_per_minute = 12,
      -- light_flicker = {color = {0,0,0}},
      -- smoke =
      -- {
      --   {
      --     name = "smoke",
      --     deviation = {0.1, 0.1},
      --     frequency = 3
      --   }
      -- }
    },
    energy_usage = energy_usage,
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/assembling-machine-t1-1.ogg",
          volume = 0.5
        }
      },
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }
  }
end

data:extend{
  make_assembling_machine("tree-farm", {"tree-farm"}, 1, "10kW"),
}
