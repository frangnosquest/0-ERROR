SMODS.Back{
    name = "Sparkling Deck",
    key = "sparkling",
    pos = { x = 0, y = 0 },
    atlas = 'zero_decks',
    config = { hands = -2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { colours = {G.C.SUITS[zero_Brights]} } }
    end,
    initial_deck = { suits = {} },
    apply = function(self, back)
        G.GAME.banned_keys["bl_club"] = true
        G.GAME.banned_keys["bl_goad"] = true
        G.GAME.banned_keys["bl_window"] = true
        G.GAME.banned_keys["bl_head"] = true
        G.E_MANAGER:add_event(Event({
            func = function()
                local ranks = {"A",2,3,4,5,6,7,8,9,10,"J","Q","K"}
                for k, v in ipairs(ranks) do
                    SMODS.add_card { set = "Base", rank = v, suit = "zero_Brights", area = G.deck }
                end
                return true
            end
        }))
    end
}

SMODS.Back{
    name = "Draft Deck",
    key = "draft", 
    pos = { x = 2, y = 1 },
    atlas = 'zero_decks'
}

SMODS.Back{
    name = "Divine Deck",
    key = "divine", 
    pos = { x = 3, y = 1 },
    atlas = 'zero_decks',
	unlocked = false,
	check_for_unlock = function(self, args)
		for _, j in ipairs(G.P_CENTER_POOLS.Joker) do
			if j.unlocked and j.rarity == "zero_patron" then
				return true
			end
		end
	end,
}

local old_start_run = Game.start_run
function Game:start_run(args)
    old_start_run(self, args)
    local back_key = G.GAME.selected_back.effect.center.key
    if (back_key == 'b_zero_draft' or back_key == 'b_zero_divine') and not G.GAME.zero_deck_drafted then
        G.GAME.zero_draft_type = (back_key == 'b_zero_draft') and "draft" or "divine"
        G.E_MANAGER:add_event(Event({
            func = function()
                G.SETTINGS.paused = true
                G.FUNCS.overlay_menu{
                    definition = create_UIBox_unified_draft(),
                    config = {no_esc = true}
                }
                return true
            end
        }))
    end
end


function create_UIBox_unified_draft()
    if not G.GAME.custom_draft_options then
        G.GAME.custom_draft_options = {}
        G.GAME.custom_draft_page = 1
        if G.GAME.zero_draft_type == "draft" then
            local pool = G.P_CENTER_POOLS.Joker
            local temp_pool = {}
            for _, v in ipairs(pool) do 
                if v.unlocked and v.discovered and (not v.in_pool or v.in_pool()) and type(v.rarity) == "number" and v.rarity < 4 and (v.eternal_compat == nil or v.eternal_compat == true) then
                    table.insert(temp_pool, v.key) 
                end
            end
            if #temp_pool == 0 then for _, v in ipairs(pool) do table.insert(temp_pool, v.key) end end
            for i = 1, 6 do
                if #temp_pool > 0 then
                    local r = pseudorandom('joker_draft_' .. i)
                    local chosen_idx = math.min(#temp_pool, math.floor(r * #temp_pool) + 1)
                    table.insert(G.GAME.custom_draft_options, table.remove(temp_pool, chosen_idx))
                end
            end
            G.GAME.custom_draft_viewed = G.P_CENTERS[G.GAME.custom_draft_options[1]]
        elseif G.GAME.zero_draft_type == "divine" then
            for _, v in ipairs(G.P_CENTER_POOLS.Joker) do 
                if v.rarity == "zero_patron" then
                    table.insert(G.GAME.custom_draft_options, v.key)
                end
            end
            if #G.GAME.custom_draft_options == 0 then table.insert(G.GAME.custom_draft_options, "j_joker") end
            for _, key in ipairs(G.GAME.custom_draft_options) do
                if G.P_CENTERS[key].unlocked then
                    G.GAME.custom_draft_viewed = G.P_CENTERS[key]
                    break
                end
            end
            G.GAME.custom_draft_viewed = G.GAME.custom_draft_viewed or G.P_CENTERS[G.GAME.custom_draft_options[1]]
        end
    end
    local items_per_page = 6
    local total_pages = math.max(1, math.ceil(#G.GAME.custom_draft_options / items_per_page))
    local grid_tables = {}
    G.custom_draft_selection = {}
    for i = 1, 2 do
        local row = {n=G.UIT.R, config={colour = G.C.CLEAR, padding=0.05}, nodes={}}
        for j = 1, 3 do
            local idx = j + (i-1)*3
            G.custom_draft_selection[idx] = CardArea(G.ROOM.T.x, G.ROOM.T.h, G.CARD_W, G.CARD_H, {card_limit = 1, type = "title", highlight_limit = 0})
            table.insert(row.nodes, {n=G.UIT.O, config={object = G.custom_draft_selection[idx]}})
        end
        table.insert(grid_tables, row)
    end
    for i = 1, 6 do
        local key = G.GAME.custom_draft_options[i]
        if key then
            local center = G.P_CENTERS[key]
            local card = Card(G.custom_draft_selection[i].T.x, G.custom_draft_selection[i].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
            card.no_ui = true; card.config.card.no_ui = true; card.ability.fake_draft_joker = true
            G.custom_draft_selection[i]:emplace(card)
        end
    end
    G.custom_draft_preview = CardArea(G.ROOM.T.x, G.ROOM.T.h, G.CARD_W, G.CARD_H, {card_limit = 1, type = "title", highlight_limit = 0})
    local center = G.GAME.custom_draft_viewed or G.P_CENTERS["j_joker"]
    local preview_card = Card(G.custom_draft_preview.T.x+G.custom_draft_preview.T.w/2-G.CARD_W/2, G.custom_draft_preview.T.y+G.custom_draft_preview.T.h/2-G.CARD_H/2, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
    preview_card.states.hover.can = false
    G.custom_draft_preview:emplace(preview_card)
    local minw = 3.5
    local UI_table = center.unlocked and generate_card_ui(center, nil, nil, "Joker") or generate_card_ui(center, nil, nil, "Locked")
    local desc_main = {n=G.UIT.ROOT, config={align = "cm", minw = minw, minh = 2, id = center.name, colour = G.C.CLEAR}, nodes={desc_from_rows(UI_table.main, true, minw-0.2)}}
    local pagination_row = {n=G.UIT.R, config={align = "cm", padding = 0.15}, nodes={
        {n=G.UIT.C, config={button = "custom_draft_prev", align = "cm", minw = 0.8, minh = 0.6, hover = true, shadow = true, colour = G.C.BLUE, r = 0.1}, nodes = {{n=G.UIT.T, config={text = "<", colour = G.C.UI.TEXT_LIGHT, scale = 0.4}}}},
        {n=G.UIT.C, config={align = "cm", minw = 1.5}, nodes = {{n=G.UIT.T, config={id = "custom_draft_page_text", text = G.GAME.custom_draft_page .. " / " .. total_pages, scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}}},
        {n=G.UIT.C, config={button = "custom_draft_next", align = "cm", minw = 0.8, minh = 0.6, hover = true, shadow = true, colour = G.C.BLUE, r = 0.1}, nodes = {{n=G.UIT.T, config={text = ">", colour = G.C.UI.TEXT_LIGHT, scale = 0.4}}}}
    }}
    return create_UIBox_generic_options({no_back = true, contents = {
        {n=G.UIT.R, config={align = "cm", minw = 7.5, padding = 0.15, r = 0.1, colour = G.C.L_BLACK}, nodes={
            {n=G.UIT.C, config={align = "cm", padding = 0.1, r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes={
                {n=G.UIT.R, config={align="cm"}, nodes=grid_tables},
                total_pages > 1 and pagination_row or nil
            }},
            {n=G.UIT.C, config={align = "tm", minw = 4, minh = 4.5, r = 0.1, colour = G.C.BLACK, padding = 0.15, emboss = 0.05}, nodes={
                {n=G.UIT.R, config={align = "cm", emboss = 0.1, r = 0.1, minw = 3, minh = 0.5}, nodes={
                    {n=G.UIT.O, config={id = nil, func = "RUN_SETUP_check_unified_name", object = Moveable()}},
                }},
                {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.O, config={id = center.name, func = "RUN_SETUP_check_unified_card", object = G.custom_draft_preview}},
                }},
                {n=G.UIT.R, config={align = "cm", colour = G.C.WHITE, emboss = 0.1, r = 0.1}, nodes={
                    {n=G.UIT.O, config={id = center.name, func = "RUN_SETUP_check_unified_desc", object = UIBox{definition = desc_main, config = {offset = {x=0,y=0}}}}}
                }}
            }},
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
            {n=G.UIT.C, config={minw = 2.5, minh = 0.8, r = 0.1, hover = true, button = "custom_draft_random", colour = G.C.BLUE, align = "cm", emboss = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = "Random", scale = 0.5, colour = G.C.WHITE}}}}
            }},
            {n=G.UIT.C, config={align = "cm", minw = 0.4}, nodes={}},
            {n=G.UIT.C, config={minw = 3.0, minh = 0.8, r = 0.1, hover = true, button = "custom_draft_select", func = "custom_draft_select_button", align = "cm", emboss = 0.1}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = "Confirm", scale = 0.5, colour = G.C.WHITE}}}}
            }},
        }},
    }})
end
G.FUNCS.custom_draft_prev = function(e)
    if G.GAME.custom_draft_page > 1 then
        G.GAME.custom_draft_page = G.GAME.custom_draft_page - 1
        G.FUNCS.update_custom_draft_grid()
    end
end
G.FUNCS.custom_draft_next = function(e)
    local total_pages = math.max(1, math.ceil(#G.GAME.custom_draft_options / 6))
    if G.GAME.custom_draft_page < total_pages then
        G.GAME.custom_draft_page = G.GAME.custom_draft_page + 1
        G.FUNCS.update_custom_draft_grid()
    end
end
G.FUNCS.update_custom_draft_grid = function()
    for i = 1, 6 do
        if G.custom_draft_selection[i].cards[1] then
            local c = G.custom_draft_selection[i]:remove_card(G.custom_draft_selection[i].cards[1])
            c:remove()
        end
    end
    local offset = (G.GAME.custom_draft_page - 1) * 6
    for i = 1, 6 do
        local key = G.GAME.custom_draft_options[offset + i]
        if key then
            local card = Card(G.custom_draft_selection[i].T.x, G.custom_draft_selection[i].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[key])
            card.no_ui = true; card.config.card.no_ui = true; card.ability.fake_draft_joker = true
            G.custom_draft_selection[i]:emplace(card)
        end
    end
    if G.OVERLAY_MENU then
        local page_node = G.OVERLAY_MENU:get_UIE_by_ID("custom_draft_page_text")
        if page_node then
            local total_pages = math.max(1, math.ceil(#G.GAME.custom_draft_options / 6))
            page_node.config.text = G.GAME.custom_draft_page .. " / " .. total_pages
            page_node.UIBox:recalculate()
        end
    end
end
G.FUNCS.RUN_SETUP_check_unified_name = function(e)
    local viewed = G.GAME.custom_draft_viewed or G.P_CENTERS["j_joker"]
    if e.config.object and viewed.name ~= e.config.id then
        local name_text = viewed.unlocked and localize{type = "name_text", set = "Joker", key = viewed.key} or localize("k_locked")
        e.config.object:remove()
        e.config.object = UIBox{
            definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={{n=G.UIT.O, config={id = viewed.name, func = "RUN_SETUP_check_unified_name", object = DynaText({string = name_text, maxw = 4, colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.5, pop_in = 0, silent = true})}}}},
            config = {offset = {x=0,y=0}, align = "cm", parent = e}
        }
        e.config.id = viewed.name
    end
end

G.FUNCS.RUN_SETUP_check_unified_card = function(e)
    if e.config.object and G.GAME.custom_draft_viewed.name ~= e.config.id then
        local c = G.custom_draft_preview:remove_card(G.custom_draft_preview.cards[1])
        c:remove()
        local card = Card(G.custom_draft_preview.T.x+G.custom_draft_preview.T.w/2-G.CARD_W/2, G.custom_draft_preview.T.y+G.custom_draft_preview.T.h/2-G.CARD_H/2, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.GAME.custom_draft_viewed)
        card.states.hover.can = false
        G.custom_draft_preview:emplace(card)
        e.config.id = G.GAME.custom_draft_viewed.name
    end
end

G.FUNCS.RUN_SETUP_check_unified_desc = function(e)
    local viewed = G.GAME.custom_draft_viewed or G.P_CENTERS["j_joker"]
    if viewed.name ~= e.config.id then
        local minw = 3.5
        local UI_table = viewed.unlocked and generate_card_ui(viewed, nil, nil, "Joker") or generate_card_ui(viewed, nil, nil, "Locked")
        local desc_main = {n=G.UIT.ROOT, config={align = "cm", minw = minw, minh = 2, id = viewed.name, colour = G.C.CLEAR}, nodes={desc_from_rows(UI_table.main, true, minw-0.2)}}
        e.config.object:remove() 
        e.config.object = UIBox{ definition = desc_main, config = {offset = {x=0,y=0}, align = "cm", parent = e} }
        e.config.id = viewed.name
    end
end

local Card_click_ref = Card.click
function Card:click()
    Card_click_ref(self)
    if self.ability.fake_draft_joker then
        G.GAME.custom_draft_viewed = self.config.center
    end
end

G.FUNCS.custom_draft_select_button = function(e)
    local viewed = G.GAME.custom_draft_viewed or G.P_CENTERS["j_joker"]
    if viewed and viewed.unlocked then
        e.config.colour = G.C.GREEN
        e.config.button = "custom_draft_select"
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.custom_draft_random = function()
    local unlocked_options = {}
    for _, key in ipairs(G.GAME.custom_draft_options) do
        if G.P_CENTERS[key].unlocked then table.insert(unlocked_options, key) end
    end
    if #unlocked_options > 0 then
        local random_key = pseudorandom_element(unlocked_options, pseudoseed(os.time()))
        G.GAME.custom_draft_viewed = G.P_CENTERS[random_key]
        for i, key in ipairs(G.GAME.custom_draft_options) do
            if key == random_key then
                local target_page = math.max(1, math.ceil(i / 6))
                if G.GAME.custom_draft_page ~= target_page then
                    G.GAME.custom_draft_page = target_page
                    G.FUNCS.update_custom_draft_grid()
                end
                break
            end
        end
    end
end

G.FUNCS.custom_draft_select = function()
    G.FUNCS.exit_overlay_menu()
    local center = G.GAME.custom_draft_viewed or G.P_CENTERS["j_joker"]
    G.E_MANAGER:add_event(Event({
        func = function()
            local card = Card(G.deck.T.x+G.deck.T.w-G.CARD_W*0.6, G.deck.T.y-G.CARD_H*1.6, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
            if G.GAME.zero_draft_type == "draft" then
                card.ability.eternal = true
            end
            card:add_to_deck()
            G.jokers:emplace(card)
            card:juice_up(0.3, 0.5)
            G.GAME.zero_deck_drafted = true
            save_run()
            G.GAME.custom_draft_options = nil
            G.GAME.custom_draft_viewed = nil
            G.GAME.custom_draft_page = nil
            G.GAME.zero_draft_type = nil
            G.custom_draft_selection = nil
            G.custom_draft_preview = nil
            return true 
        end
    }))
end