local function init()
  if remote.interfaces.freeplay then
    if remote.interfaces.freeplay.set_disable_crashsite then
      remote.call("freeplay", "set_disable_crashsite", true)
    end

    -- local created_items = remote.call("freeplay", "get_created_items")
    -- created_items["iron-plate"] = nil
    -- created_items["burner-mining-drill"] = nil
    -- created_items["burner-ore-crusher"] = nil
    -- created_items["stone-furnace"] = nil
    -- created_items["iron-plate"] = nil
    -- created_items["wood"] = nil
    -- remote.call("freeplay", "set_created_items", created_items)
  end
end

script.on_init(init)

script.on_event(defines.events.on_player_created, function(event)
  local player = game.get_player(event.player_index)
  player.clear_items_inside()

  local starting_items = {
    {name = "iron-plate", count = 8},
    {name = "burner-mining-drill", count = 1},
    {name = "stone-furnace", count = 1}
  }
  local inventory = player.get_main_inventory()
	for i, v in pairs(starting_items) do
		inventory.remove({name=v.name, count=v.count})
	end

  player.insert{name="tree-farm", count=1}
  player.insert{name="seed", count=1}
  player.insert{name="log", count=5}
end)
