-- ==========================================================
-- WARNING!
-- This page contains progression-related spoilers
-- for the mod, we'd recommend not looking at the
-- content of this lua file unless you are a dev
-- looking to reference some code.
-- thank you and have a great day!
-- ==========================================================
--
--
--
--					      _          ___
--					    /' '\       / " \
--					   |  ,--+-----4 /   |
--					   ',/   o  o     --.;
--					--._|_   ,--.  _.,-- \----.
--					------'--`--' '-----,' VJ  |
--					     \_  ._\_.   _,-'---._.'
--					       `--...--``  /
--					         /###\   | |
--					         |.   `.-'-'.
--					        .||  /,     |
--					       do_o00oo_,.ob
--					
--
--
--
--
-- you have been warned

SMODS.Atlas {
  key = "zero_secret_jokers",
  px = 71,
  py = 95,
  path = "secret/zero_secret_jokers.png"
}

SMODS.Rarity({
	key = "secret",
	loc_txt = {name = "Secret Rare"},
	badge_colour = SMODS.Gradients.zero_rainbow,
	text_colour = HEX("454454"),
	default_weight = 0.005,
	pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
})

local old_create_UIBox_your_collection = create_UIBox_your_collection
function create_UIBox_your_collection()
	for _, v in pairs(G.P_CENTER_POOLS.Joker) do
		if v.rarity == "zero_secret" then
			if v.unlocked then
				v.no_collection = false
			else
				v.no_collection = true
			end
		end
	end
	return old_create_UIBox_your_collection()
end

G.zero_soshi_condition_met = false
G.zero_soshi_page = 1
G.zero_soshi_list_items = {
    { text = "zero_sc_hint_soshi", center = "j_zero_soshi", password = "elgato" },
    { text = "zero_sc_hint_jericho", center = "j_zero_jericho", password = "zombiesonyourlawn" },
    { text = "zero_sc_hint_oulala", center = "j_zero_oulala", password = "spaceball" },
    { text = "zero_sc_hint_", center = "j_zero_darkasso", password = "cellardoor" },
    { text = "zero_sc_hint_channeler", center = "j_zero_channeler", password = "saligia" },
    { text = "zero_sc_hint_no_default_voice", center = "j_zero_no_default_voice", password = "daisydaisy" },
}

function G.UIDEF.zero_soshi_wrapper()
    return G.UIDEF.zero_soshi_content()
end

function G.UIDEF.zero_soshi_content()
    if not G.zero_soshi_condition_met then
        G.zero_soshi_area = CardArea(
            G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
            4.25 * G.CARD_W, 0.95 * G.CARD_H,
            { card_limit = 5, type = 'title', highlight_limit = 0, collection = true }
        )
        local area = G.zero_soshi_area
        local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS["j_zero_soshi"], { bypass_discovery_center = true, bypass_discovery_ui = true })
		area:emplace(card)
        card:juice_up(0.3, 0.2)
        card.no_ui = true
        return {
            n = G.UIT.ROOT, 
            config = {align = "cm", padding = 0.5, colour = G.C.BLACK, r = 0.1, minw = 6, minh = 4}, 
            nodes = {
                {n = G.UIT.R, config = {align = "cm"}, nodes = {
                    {n = G.UIT.C, config = {align = "cm"}, nodes = {
                        {n = G.UIT.O, config = {object = area}}
                    }}
                }},
            }
        }
    else
        local items_per_page = 4
        local total_pages = math.max(1, math.ceil(#G.zero_soshi_list_items / items_per_page))
        G.zero_soshi_page = math.max(1, math.min(G.zero_soshi_page or 1, total_pages))
        
        local list_rows = {}
        table.insert(list_rows, {
            n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {
                {n = G.UIT.T, config = {text = "Secret Unlocks", scale = 0.6, colour = G.C.RAINBOW}}
            }
        })
        local start_idx = (G.zero_soshi_page - 1) * items_per_page + 1
        local end_idx = math.min(G.zero_soshi_page * items_per_page, #G.zero_soshi_list_items)
        local current_row_nodes = {}
		G.zero_secret_unlocks_area = {}
        for i = start_idx, end_idx do
            local item = G.zero_soshi_list_items[i]
            local text_nodes = {}
            for line in string.gmatch(localize(item.text), "[^\n]+") do
                table.insert(text_nodes, {
                    n = G.UIT.R, config = {align = "cm", padding = 0.02}, nodes = {
                        {n = G.UIT.T, config = {text = line, scale = 0.4, colour = G.C.UI.TEXT_LIGHT}}
                    }
                })
            end
            local mini_area = CardArea(
                0, 0, 1.2 * G.CARD_W, 1.2 * G.CARD_H,
                { card_limit = 1, type = 'title', highlight_limit = 0, collection = true }
            )
			G.zero_secret_unlocks_area[#G.zero_secret_unlocks_area + 1] = mini_area
            local card = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[item.center] or G.P_CENTERS["j_joker"])
            if not card.config.center.unlocked then
				card:set_edition("e_zero_occult",true,true)
			end
			mini_area:emplace(card)
            card:juice_up(0.3, 0.2)
            card.no_ui = true
            local item_cell = {
                n = G.UIT.C, config = {align = "cm", padding = 0.15, minw = 4.4, minh = 1.6}, nodes = {
                    {n = G.UIT.R, config = {align = "cm"}, nodes = {
                        {n = G.UIT.C, config = {align = "cm", minw = 2.8, padding = 0.1}, nodes = text_nodes},
                        {n = G.UIT.C, config = {align = "cm", padding = 0.1}, nodes = {
                            {n = G.UIT.O, config = {object = mini_area}}
                        }}
                        
                    }}
                }
            }
            table.insert(current_row_nodes, item_cell)
            if #current_row_nodes == 2 then
                table.insert(list_rows, {
                    n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = current_row_nodes
                })
                current_row_nodes = {} 
            elseif i == end_idx then
                table.insert(current_row_nodes, {
                    n = G.UIT.C, config = {align = "cm", padding = 0.15, minw = 4.4, minh = 1.6}
                })
                table.insert(list_rows, {
                    n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = current_row_nodes
                })
            end
        end
        if #list_rows == 2 then
            table.insert(list_rows, {
                n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {
                    {n = G.UIT.C, config = {minw = 8.8, minh = 1.6}}
                }
            })
        end
        G.zero_soshi_input_text = G.zero_soshi_input_text or "" 

        table.insert(list_rows, {
            n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {
                {n = G.UIT.C, config = {align = "cm", padding = 0.1}, nodes = {
                    create_text_input({
                        max_length = 20, 
                        ref_table = G, 
                        ref_value = "zero_soshi_input_text", 
                        prompt_text = "Password...",
                        id = "zs_text_input",
						colour = G.C.RED -- using a gradient here causes a stack overflow ¯\_(ツ)_/¯
                    })
                }},
                {n = G.UIT.C, config = {align = "cm", padding = 0.1}, nodes = {
                    {n = G.UIT.C, config = {button = "submit_zs_text", align = "cm", minw = 1.5, minh = 0.7, hover = true, shadow = true, colour = G.C.RED, r = 0.1}, nodes = {
                        {n = G.UIT.T, config = {text = "Submit", colour = G.C.UI.TEXT_LIGHT, scale = 0.4}}
                    }}
                }}
            }
        })
        table.insert(list_rows, {
            n = G.UIT.R, config = {align = "cm", padding = 0.2}, nodes = {
                {n = G.UIT.C, config = {button = "zs_prev_page", align = "cm", minw = 1, minh = 0.6, hover = true, shadow = true, colour = G.C.RAINBOW, r = 0.1}, nodes = {
                    {n = G.UIT.T, config = {text = "<", colour = HEX("454454"), scale = 0.45}}
                }},
                {n = G.UIT.C, config = {align = "cm", minw = 2, minh = 0.6, hover = true, shadow = true, colour = G.C.RAINBOW, r = 0.1}, nodes = {
                    {n = G.UIT.T, config = {text = G.zero_soshi_page .. " / " .. total_pages, scale = 0.45, colour = HEX("454454")}}
                }},
                {n = G.UIT.C, config = {button = "zs_next_page", align = "cm", minw = 1, minh = 0.6, hover = true, shadow = true, colour = G.C.RAINBOW, r = 0.1}, nodes = {
                    {n = G.UIT.T, config = {text = ">", colour = HEX("454454"), scale = 0.45}}
                }}
            }
        })
        return {
            n = G.UIT.ROOT, 
            config = {align = "cm", padding = 0.2, colour = G.C.BLACK, r = 0.1, minw = 9.2, minh = 6.2}, 
            nodes = {
                {n = G.UIT.C, config = {align = "cm"}, nodes = list_rows}
            }
        }
    end
end

local function refresh_zero_soshi_ui()
    if not G.OVERLAY_MENU then return end
    local tab_contents = G.OVERLAY_MENU:get_UIE_by_ID("tab_contents")
    if not tab_contents then return end
    if tab_contents.config.object then
        tab_contents.config.object:remove()
    end
    tab_contents.config.object = UIBox({
        definition = G.UIDEF.zero_soshi_content(),
        config = {offset = {x = 0, y = 0}, parent = tab_contents, type = "cm"}
    })
    tab_contents.UIBox:recalculate()
end

G.FUNCS.zs_prev_page = function(e)
    if G.zero_soshi_page > 1 then
        G.zero_soshi_page = G.zero_soshi_page - 1
        refresh_zero_soshi_ui()
    end
end

G.FUNCS.zs_next_page = function(e)
    local total_pages = math.max(1, math.ceil(#G.zero_soshi_list_items / 4))
    if G.zero_soshi_page < total_pages then
        G.zero_soshi_page = G.zero_soshi_page + 1
        refresh_zero_soshi_ui()
    end
end

G.FUNCS.trigger_zs_condition = function(e)
    G.zero_soshi_condition_met = true
    refresh_zero_soshi_ui()
end

G.FUNCS.submit_zs_text = function(e)
    local typed_text = string.lower(G.zero_soshi_input_text) or ""
    local success = false
	if typed_text == "gaster" then
		SMODS.restart_game()
	end
    for i, item in ipairs(G.zero_soshi_list_items) do
        if item.password and string.lower(typed_text) == item.password then
            local center = G.P_CENTERS[item.center]
            if center and not center.unlocked then
                unlock_card(center)
                discover_card(center)
                center.no_collection = false
                success = true
                break
            end
        end
    end
    if success then
        play_sound('tarot1')
    else
        play_sound('cancel')
    end
    G.zero_soshi_input_text = ""
    refresh_zero_soshi_ui()
end

--Joker petting made by bepisfever, referenced from partner api

local centerX, centerY = 0, 0 
local tracking = false          
local totalAngle = 0            
local prevAngle = nil           
local minRadius = 0.5            
local resetTime = 0.2
local countedTime = 0
local petTime = 0
local hoveredCard = nil

local ref = Card.hover
function Card:hover()
    tracking = true
    hoveredCard = self
    local ret = ref(self)
    return ret
end

local ref = Card.stop_hover
function Card:stop_hover()
    if hoveredCard == self then
        tracking = false
        hoveredCard = nil
    end
    local ret = ref(self)
    return ret
end

function math.sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    else
        return 0
    end
end


local ref = love.update
function love.update(dt)
    ref(dt)
    countedTime = countedTime + dt
    if countedTime >= resetTime then
        local x, y = love.mouse.getPosition()
        countedTime = countedTime - resetTime
        centerX, centerY = x, y 
        prevAngle = nil
    end
    if tracking then
        petTime = petTime + dt
        local x, y = love.mouse.getPosition()
        centerX = centerX or x
        centerY = centerY or y
        local dx, dy = x - centerX, y - centerY
        local radius = math.sqrt(dx*dx + dy*dy)
        if radius >= minRadius then
            local angle = math.atan2(dy, dx) 
            if prevAngle then
                local diff = angle - prevAngle
                if diff > math.pi then
                    diff = diff - 2 * math.pi
                elseif diff < -math.pi then
                    diff = diff + 2 * math.pi
                end
                if math.sign(totalAngle) ~= math.sign(diff) and totalAngle ~= 0 and diff ~= 0 then
                    petTime = 0
                    totalAngle = 0
                end
                totalAngle = totalAngle + diff
                
                if math.abs(totalAngle) >= 2 * math.pi then
                    totalAngle = 0
                    petTime = 0
					SMODS.calculate_context({pet_card = hoveredCard, pet_time = petTime, pet_direction = (totalAngle > 0 and "clockwise" or "counter-clockwise")})
					if hoveredCard.config.center.key == "j_zero_soshi" then
						play_sound('zero_meow', 1.2 + math.random()*0.1, 0.5)
						if not G.zero_soshi_condition_met and G.zero_soshi_area and hoveredCard.area == G.zero_soshi_area then
							unlock_card(hoveredCard.config.center)
							discover_card(hoveredCard.config.center)
							hoveredCard.config.center.no_collection = false
							G.FUNCS.trigger_zs_condition()
						end
					end
				end
            end
            prevAngle = angle
        else
            prevAngle = nil 
        end
    else
        totalAngle = 0
        petTime = 0
    end
end

SMODS.Joker {
    key = "soshi",
	atlas = "zero_secret_jokers",
    pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	hidden_pos = { x = 4, y = 2 },
	hidden_soul_pos = { x = 4, y = 3 },
    rarity = "zero_secret",
    blueprint_compat = true,
    cost = 12,
	unlocked = false,
	no_collection = true,
	config = { extra = { xmult = 1, xmult_mod = 0.5, lives = 9, found = false } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, card.ability.extra.lives, card.ability.extra.lives == 1 and "" or "s" } }
    end,
	calculate = function(self, card, context)
		if context.forcetrigger or context.joker_main then
			return {
                xmult = card.ability.extra.xmult
            }
		end
		if context.blueprint then return end
		if context.end_of_round and context.main_eval then
			if pseudorandom('soshi') < 2 / 5 then
				card.ability.extra.found = true
				local eval = function(card) return card.ability.extra.found end
				juice_card_until(card, eval, true)
			end
			if context.game_over and card.ability.extra.lives > 0 then
				card.ability.extra.lives = card.ability.extra.lives - 1
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
				G.E_MANAGER:add_event(Event({
					func = function()
						G.hand_text_area.blind_chips:juice_up()
						G.hand_text_area.game_chips:juice_up()
						play_sound('tarot1')
						return true
					end
				}))
				return {
					message = localize('k_saved_ex'),
					saved = 'ph_zero_soshi',
					colour = G.C.RED
				}
			end
		end
        if context.pet_card and context.pet_card == card and card.ability.extra.found == true then
			card.ability.extra.found = false
			G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    SMODS.add_card {
                        set = "Consumeables",
						edition = "e_negative",
                        key_append = 'zero_soshi'
                    }
                    return true
                end)
            }))
            return {
                message = localize('k_gift_ex'),
                colour = G.C.RAINBOW,
            }
        end
    end,
	pronouns = "she_her"
}

SMODS.Joker {
    key = "jericho",
	atlas = "zero_secret_jokers",
    pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },
	hidden_pos = { x = 4, y = 2 },
	hidden_soul_pos = { x = 4, y = 3 },
    rarity = "zero_secret",
    blueprint_compat = true,
	demicoloncompat = false,
    cost = 15,
	unlocked = false,
	no_collection = true,
	config = { extra = { odds = 3 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal } }
    end,
	calculate = function(self, card, context)
        if context.buying_card and not context.buying_self and pseudorandom('jericho') < G.GAME.probabilities.normal / card.ability.extra.odds then
			card:juice_up()
			context.card:set_edition("e_negative",true)
		end
	end,
	check_for_unlock = function(self, args)
        for _, v in pairs({ "fabled_rose_of_isola", "magic_tree_of_fragrance", "golden_berries_of_wealth", "rose_of_joy", "fruit_of_life", "flower_of_knowledge" }) do
			if not next(SMODS.find_card('j_zero_' .. v, true)) then
				return false
			end
		end
		discover_card(G.P_CENTERS["j_zero_jericho"])
		G.P_CENTERS["j_zero_jericho"].no_collection = false
		return true
    end
}

local function zero_oulala_digits(n)
	if type(n) == 'number' then
		if n ~= n then return 1 end
		if n >= 1.8e308 then return 309 end
		n = math.floor(n)
		if n < 1 then return 1 end
		return math.floor(math.log10(n)) + 1
	end
	if n.log10 then return math.floor(to_number(n:log10())) + 1 end
	return 1
end

SMODS.Joker {
    key = "oulala",
	atlas = "zero_secret_jokers",
    pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
	hidden_pos = { x = 4, y = 2 },
	hidden_soul_pos = { x = 4, y = 3 },
    rarity = "zero_secret",
    blueprint_compat = true,
    cost = 12,
	unlocked = false,
	no_collection = true,
	config = { extra = { mult = 15, xmult = 4, started = {}, finished = {}, first = {}, diff = {} } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.xmult } }
    end,
	calculate = function(self, card, context)
		local extra = card.ability.extra
		local actor = context.blueprint_card or card
		local id = actor.sort_id
		if context.before and not context.blueprint then
			extra.started, extra.finished, extra.first, extra.diff = {}, {}, {}, {}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card == context.scoring_hand[1] and not extra.started[id] then
				extra.started[id] = true
				extra.first[id] = zero_oulala_digits(mult + extra.mult)
				SMODS.calculate_effect({ mult = extra.mult }, actor)
			end
			if context.other_card == context.scoring_hand[#context.scoring_hand] then
				if not extra.finished[id] then
					extra.finished[id] = true
					extra.diff[id] = math.max(0, zero_oulala_digits(mult * extra.xmult) - (extra.first[id] or zero_oulala_digits(mult)))
				end
				return { xmult = extra.xmult }
			end
		end
		if context.forcetrigger or context.joker_main then
			return { xmult = math.max(1, extra.diff[id] or 1) }
		end
	end,
	check_for_unlock = function(self, args)
        if args.type == 'chip_score' and args.chips >= 1.80e308 then
			discover_card(G.P_CENTERS["j_zero_oulala"])
			G.P_CENTERS["j_zero_oulala"].no_collection = false
			return true
		end
		return false
    end
}

SMODS.Joker {
    key = "darkasso",
	atlas = "zero_secret_jokers",
    pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	hidden_pos = { x = 4, y = 2 },
	hidden_soul_pos = { x = 4, y = 3 },
    rarity = "zero_secret",
    blueprint_compat = true,
    cost = 14,
	unlocked = false,
	no_collection = true,
	config = { extra = { slots = 2 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_zero_occult
        return { vars = { card.ability.extra.slots } }
    end,
	add_to_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
	end,
	calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Tarot',
								edition = 'e_zero_occult',
                                key_append = 'zero_darkasso'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_tarot'), colour = G.C.PURPLE },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
	end
}

local zero_sin_challenge_keys = {
	"c_zero_most_dangerous_game",
	"c_zero_glittering_golden",
	"c_zero_forever_feast",
	"c_zero_love_me_forever",
	"c_zero_dont_forget_me",
	"c_zero_lotus_eater",
	"c_zero_world_revolving",
	"c_zero_50000_shades_of_grey",
}

function zero_channeler_unleash(card, key, sin)
	for _, joker in ipairs(G.jokers.cards) do
		if joker.config.center.key == key then return false end
	end
	card.ability.extra.unleashed = true
	card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_zero_sin_' .. sin), colour = G.C.PATRON })
	G.E_MANAGER:add_event(Event({
		func = function()
			card:start_dissolve({ G.C.PATRON })
			local patron = SMODS.add_card({ key = key, area = G.jokers, key_append = 'zero_channeler' })
			card_eval_status_text(patron, 'extra', nil, nil, nil, { message = localize('k_zero_unleashed_ex'), colour = G.C.PATRON })
			return true
		end
	}))
	return true
end

SMODS.Joker {
	key = "channeler",
	atlas = "zero_secret_jokers",
	pos = { x = 4, y = 0 },
	soul_pos = { x = 4, y = 1 },
	hidden_pos = { x = 4, y = 2 },
	hidden_soul_pos = { x = 4, y = 3 },
	rarity = "zero_secret",
	blueprint_compat = false,
	cost = 15,
	unlocked = false,
	no_collection = true,
	config = { extra = { dollars = 50, destroyed = 0, destroyed_needed = 5, skips = 0, skips_needed = 2, consumed = 0, consumed_needed = 3, hearts_needed = 5, pride = 5 } },
	loc_vars = function(self, info_queue, card)
		return { key = math.random() < 0.5 and "j_zero_channeler_vice" or "j_zero_channeler" }
	end,
	calculate = function(self, card, context)
		local extra = card.ability.extra
		if context.blueprint or extra.unleashed then return end
		if context.setting_blind then
			extra.skips = 0
		end
		if context.starting_shop or context.ending_shop then
			extra.consumed = 0
		end
		if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.dollars + (G.GAME.dollar_buffer or 0) >= extra.dollars then
			zero_channeler_unleash(card, "j_zero_conlasse", "greed")
		elseif context.remove_playing_cards and context.removed then
			extra.destroyed = extra.destroyed + #context.removed
			if extra.destroyed >= extra.destroyed_needed then
				zero_channeler_unleash(card, "j_zero_tachtyk", "wrath")
			end
		elseif context.skip_blind then
			extra.skips = extra.skips + 1
			if extra.skips >= extra.skips_needed then
				zero_channeler_unleash(card, "j_zero_reffa", "sloth")
			end
		elseif context.selling_card and context.card ~= card and context.card.ability.set == "Joker" then
			local others = 0
			for _, joker in ipairs(G.jokers.cards) do
				if joker ~= card and joker ~= context.card then
					others = others + 1
				end
			end
			if others == 0 then
				zero_channeler_unleash(card, "j_zero_ivan", "envy")
			end
		elseif context.using_consumeable and G.shop then
			extra.consumed = extra.consumed + 1
			if extra.consumed >= extra.consumed_needed then
				zero_channeler_unleash(card, "j_zero_avide", "gluttony")
			end
		elseif context.before and #context.scoring_hand >= extra.hearts_needed then
			for _, scored in ipairs(context.scoring_hand) do
				if not scored:is_suit("Hearts") then return end
			end
			zero_channeler_unleash(card, "j_zero_orched", "lust")
		elseif context.after then
			local score = SMODS.last_hand_score or SMODS.calculate_round_score()
			if score >= G.GAME.blind.chips * extra.pride then
				zero_channeler_unleash(card, "j_zero_egeo", "pride")
			elseif context.scoring_name == "High Card" and G.GAME.current_round.hands_left <= 0 and G.GAME.chips + score < G.GAME.blind.chips then
				if zero_channeler_unleash(card, "j_zero_kana", "despair") then
					ease_hands_played(G.GAME.current_round.hands_played + 1)
				end
			end
		end
	end,
	check_for_unlock = function(self, args)
		if args.type ~= 'win_challenge' then return false end
		local completed = G.PROFILES[G.SETTINGS.profile].challenge_progress.completed
		for _, key in ipairs(zero_sin_challenge_keys) do
			if not completed[key] then
				return false
			end
		end
		discover_card(G.P_CENTERS["j_zero_channeler"])
		G.P_CENTERS["j_zero_channeler"].no_collection = false
		return true
	end,
	pronouns = "empty"
}

local zero_mod = SMODS.current_mod
local zero_synth_triggers_needed = 100
local old_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context)
	local ret, post = old_calculate_joker(self, context)
	if type(ret) == "table" and next(ret) and not self.debuff and zero_is_vocal_synth(self.config.center) then
		zero_config.synth_triggers = (zero_config.synth_triggers or 0) + 1
		local no_default_voice = G.P_CENTERS.j_zero_no_default_voice
		if zero_config.synth_triggers >= zero_synth_triggers_needed and no_default_voice and not no_default_voice.unlocked then
			check_for_unlock({ type = 'zero_synth_triggers' })
		end
	end
	return ret, post
end

local old_end_round = end_round
function end_round()
	old_end_round()
	SMODS.save_mod_config(zero_mod)
end

SMODS.Joker {
	key = "no_default_voice",
	atlas = "zero_secret_jokers",
	pos = { x = 0, y = 2 },
	soul_pos = { x = 0, y = 3 },
	hidden_pos = { x = 4, y = 2 },
	hidden_soul_pos = { x = 4, y = 3 },
	rarity = "zero_secret",
	blueprint_compat = true,
	cost = 15,
	unlocked = false,
	no_collection = true,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
			G.E_MANAGER:add_event(Event({
				func = function()
					SMODS.add_card({ set = 'zero_VocalSynth', edition = 'e_negative', key_append = 'zero_no_default_voice' })
					return true
				end
			}))
			return {
				message = localize('k_plus_joker'),
				colour = G.C.DARK_EDITION
			}
		end
	end,
	check_for_unlock = function(self, args)
		if args.type == 'zero_synth_triggers' and (zero_config.synth_triggers or 0) >= zero_synth_triggers_needed then
			discover_card(G.P_CENTERS["j_zero_no_default_voice"])
			G.P_CENTERS["j_zero_no_default_voice"].no_collection = false
			SMODS.save_mod_config(zero_mod)
			return true
		end
		return false
	end,
	pronouns = "it_its"
}

SMODS.Joker:take_ownership('smiley', {
	loc_vars = function(self, info_queue, card)
		return { key = math.random(20) == 1 and 'j_zero_verity' or nil, vars = { card.ability and card.ability.extra or self.config.extra } }
	end,
}, true)
