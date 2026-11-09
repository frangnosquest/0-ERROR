SMODS.Atlas {
	key = "zero_stickers",
	px = 71,
	py = 95,
	path = "zero_stickers.png"
}

SMODS.Challenge {
	key = "alpine_garden",
	jokers = {
		{ id = "j_zero_alpine_lily", eternal = true },
		{ id = "j_zero_alpine_lily", eternal = true },
		{ id = "j_zero_alpine_lily", eternal = true },
		{ id = "j_zero_alpine_lily", eternal = true },
		{ id = "j_zero_alpine_lily", eternal = true },
	},
}

SMODS.Challenge {
	key = "self_made_fortune",
	jokers = {
		{ id = "j_zero_watering_can", eternal = true, edition = "negative" },
	},
	rules = {
		custom = {
			{id = "zero_no_shop", value = true}
		}
	},
	restrictions = {
		banned_cards = {
			{ id = 'j_credit_card' },
			{ id = 'j_chaos' },
			{ id = 'j_vagabond' },
			{ id = 'j_flash' },
			{ id = 'j_perkeo' },
			{ id = 'j_zero_downx2' },
			{ id = 'j_zero_strange_seeds' },
			{ id = 'j_zero_smoke_bomb' },
			{ id = 'j_zero_jericho' },
			{ id = 'c_zero_harmonycrystal' },
			{ id = 'c_zero_artifact' }
		},
		banned_tags = {
			{ id = 'tag_uncommon' },
			{ id = 'tag_rare' },
			{ id = 'tag_negative' },
			{ id = 'tag_foil' },
			{ id = 'tag_holo' },
			{ id = 'tag_polychrome' },
			{ id = 'tag_voucher' },
			{ id = 'tag_coupon' },
			{ id = 'tag_d_six' },
			{ id = 'tag_zero_gala' },
			{ id = 'tag_zero_occult' },
		},
	}
}

SMODS.Challenge {
	key = "no_man",
	jokers = {
		{ id = "j_zero_wall", eternal = true, edition = "negative" },
	},
	rules = {
		modifiers = {
			{id = "consumable_slots", value = -1}
		}
	},
}

SMODS.Challenge {
	key = "black_hole_sun",
	rules = {
		custom = {
			{id = "zero_level_zero", value = true},
			{id = "zero_no_planets", value = true},
			{id = "zero_patron_unlock", value = true}
		}
	},
	restrictions = {
		banned_cards = {
			{ id = 'j_space' },
			{ id = 'j_burnt' },
			{ id = 'j_constellation' },
			{ id = 'j_astronomer' },
			{ id = 'j_8_ball' },
			{ id = 'j_zero_crux' },
			{ id = 'j_zero_watering_can' },
			{ id = 'c_high_priestess' },
			{ id = 'c_trance' },
			{ id = 'c_black_hole' },
			{ id = 'c_zero_cups_two' },
			{ id = 'v_telescope' },
			{ id = 'v_observatory' },
			{ id = 'v_planet_merchant' },
			{ id = 'v_planet_tycoon' },
			{ id = 'v_zero_homeworld' },
			{ id = 'v_zero_cataclysm' },
			{ id = 'p_celestial_normal_1' },
			{ id = 'p_celestial_normal_2' },
			{ id = 'p_celestial_normal_3' },
			{ id = 'p_celestial_normal_4' },
			{ id = 'p_celestial_jumbo_1' },
			{ id = 'p_celestial_jumbo_2' },
			{ id = 'p_celestial_mega_1' },
			{ id = 'p_celestial_mega_2' },
		},
		banned_tags = {
			{ id = 'tag_meteor' }
		},
	},
	apply = function(self, back)
        SMODS.upgrade_poker_hands({ level_up = -1, instant = true })
		G.GAME.planet_rate = 0
		G.GAME.banned_keys["Blue"] = true
    end,
	button_colour = SMODS.Gradients.zero_patron
}

SMODS.Challenge {
	key = "edge_of_space",
	rules = {
		modifiers = {
			{id = "joker_slots", value = 2},
			{id = "consumable_slots", value = 5}
		},
		custom = {
			{id = "zero_no_tarots", value = true},
			{id = "zero_no_planets", value = true},
			{id = 'zero_win_ante', value = 12},
			{id = "zero_patron_unlock", value = true}
		}
	},
	vouchers = {
		{ id = 'v_zero_homeworld' },
	},
	restrictions = {
		banned_cards = {
			{ id = 'v_omen_globe' },
			{ id = 'v_telescope' },
			{ id = 'v_observatory' },
			{ id = 'v_planet_merchant' },
			{ id = 'v_planet_tycoon' },
			{ id = 'v_tarot_merchant' },
			{ id = 'v_tarot_tycoon' },
			{ id = 'p_arcana_normal_1' },
			{ id = 'p_arcana_normal_2' },
			{ id = 'p_arcana_normal_3' },
			{ id = 'p_arcana_normal_4' },
			{ id = 'p_arcana_jumbo_1' },
			{ id = 'p_arcana_jumbo_2' },
			{ id = 'p_arcana_mega_1' },
			{ id = 'p_arcana_mega_2' },
			{ id = 'p_celestial_normal_1' },
			{ id = 'p_celestial_normal_2' },
			{ id = 'p_celestial_normal_3' },
			{ id = 'p_celestial_normal_4' },
			{ id = 'p_celestial_jumbo_1' },
			{ id = 'p_celestial_jumbo_2' },
			{ id = 'p_celestial_mega_1' },
			{ id = 'p_celestial_mega_2' },
			{ id = 'p_standard_normal_1' },
			{ id = 'p_standard_normal_2' },
			{ id = 'p_standard_normal_3' },
			{ id = 'p_standard_normal_4' },
			{ id = 'p_standard_jumbo_1' },
			{ id = 'p_standard_jumbo_2' },
			{ id = 'p_standard_mega_1' },
			{ id = 'p_standard_mega_2' },
			{ id = 'p_buffoon_normal_1' },
			{ id = 'p_buffoon_normal_2' },
			{ id = 'p_buffoon_jumbo_1' },
			{ id = 'p_buffoon_mega_1' },
			{ id = 'p_spectral_normal_1' },
			{ id = 'p_spectral_normal_2' },
			{ id = 'p_spectral_jumbo_1' },
			{ id = 'p_spectral_mega_1' },
		},
		banned_tags = {
			{ id = 'tag_buffoon' },
			{ id = 'tag_charm' },
			{ id = 'tag_ethereal' },
			{ id = 'tag_meteor' }
		},
	},
	apply = function(self, back)
		G.GAME.tarot_rate = 0
		G.GAME.planet_rate = 0
    end,
	button_colour = SMODS.Gradients.zero_patron
}

SMODS.Sticker {
	key = "russian_roulette",
	badge_colour = HEX("8B1E1E"),
	atlas = "zero_stickers",
	pos = { x = 0, y = 0 },
	sets = { Default = true, Enhanced = true },
	rate = 0,
	should_apply = false,
	config = { odds = 6 },
	loc_vars = function(self, info_queue, card)
		local odds = card.ability.zero_roulette_odds or self.config.odds
		local numerator, denominator = SMODS.get_probability_vars(card, 1, odds, 'zero_russian_roulette')
		return { vars = { numerator, denominator } }
	end,
	calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play and not G.GAME.zero_roulette_bang then
			local odds = card.ability.zero_roulette_odds or self.config.odds
			if SMODS.pseudorandom_probability(card, 'zero_russian_roulette', 1, odds, 'zero_russian_roulette') then
				G.GAME.zero_roulette_bang = true
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('zero_gunshot')
						card:juice_up(0.6, 0.6)
						attention_text({
							text = localize('k_zero_bang'),
							scale = 1.3,
							hold = 1.2,
							major = card,
							backdrop_colour = G.C.RED,
							align = 'tm',
							offset = { x = 0, y = -0.2 },
							silent = true
						})
						return true
					end
				}))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 1.2,
					func = function()
						G.E_MANAGER:clear_queue()
						G.STATE = G.STATES.GAME_OVER
						G:save_settings()
						G.FILE_HANDLER.force = true
						G.STATE_COMPLETE = false
						return true
					end
				}))
				return
			end
			card.ability.zero_roulette_odds = math.max(1, odds - 1)
			return { message = localize('k_zero_click'), colour = G.C.UI.TEXT_INACTIVE }
		end
	end
}

SMODS.Challenge {
	key = "most_dangerous_game",
	rules = {
		custom = {
			{id = "zero_russian_roulette", value = true},
			{id = "zero_patron_unlock", value = true}
		}
	},
	calculate = function(self, context)
		if context.after then
			for _, played in ipairs(context.full_hand) do
				if not played.ability.zero_russian_roulette then
					G.E_MANAGER:add_event(Event({
						func = function()
							played:add_sticker('zero_russian_roulette', true)
							played:juice_up(0.3, 0.3)
							return true
						end
					}))
					SMODS.calculate_effect({ message = localize('k_zero_loaded'), colour = G.C.RED }, played)
				end
			end
		end
	end,
	button_colour = SMODS.Gradients.zero_patron
}

SMODS.Challenge {
	key = "forever_feast",
	rules = {
		custom = {
			{id = "zero_only_food", value = true},
			{id = "zero_no_tarots", value = true},
			{id = "zero_patron_unlock", value = true}
		}
	},
	restrictions = {
		banned_cards = {
			{ id = 'j_zero_fruit_of_life' },
			{ id = 'c_wraith' },
			{ id = 'c_soul' },
			{ id = 'p_arcana_normal_1' },
			{ id = 'p_arcana_normal_2' },
			{ id = 'p_arcana_normal_3' },
			{ id = 'p_arcana_normal_4' },
			{ id = 'p_arcana_jumbo_1' },
			{ id = 'p_arcana_jumbo_2' },
			{ id = 'p_arcana_mega_1' },
			{ id = 'p_arcana_mega_2' },
			{ id = 'v_tarot_merchant' },
			{ id = 'v_tarot_tycoon' },
			{ id = 'p_zero_cups_normal_1' },
			{ id = 'p_zero_cups_normal_2' },
			{ id = 'p_zero_cups_jumbo_1' },
			{ id = 'p_zero_cups_mega_1' },
			{ id = 'p_zero_elemental_normal_1' },
			{ id = 'p_zero_elemental_normal_2' },
			{ id = 'p_zero_elemental_jumbo_1' },
			{ id = 'p_zero_elemental_mega_1' },
			{ id = 'v_zero_overturned' },
			{ id = 'v_zero_fine_wine' },
		},
		banned_tags = {
			{ id = 'tag_rare' },
			{ id = 'tag_charm' },
			{ id = 'tag_zero_chalice' },
			{ id = 'tag_zero_alchemical' },
		},
	},
	apply = function(self, back)
		for _, center in ipairs(G.P_CENTER_POOLS.Joker) do
			if not (center.pools and center.pools.Food) then
				G.GAME.banned_keys[center.key] = true
			end
		end
		for _, set in ipairs({ 'Cups', 'Elemental' }) do
			for _, center in ipairs(G.P_CENTER_POOLS[set] or {}) do
				G.GAME.banned_keys[center.key] = true
			end
		end
		G.GAME.banned_keys.v_zero_wine_cellar = true
		G.GAME.tarot_rate = 0
	end,
	button_colour = SMODS.Gradients.zero_patron
}

SMODS.Challenge {
	key = "glittering_golden",
	rules = {
		custom = {
			{id = "zero_hand_dollar_cap", value = true},
			{id = "zero_no_interest_cap", value = true},
			{id = "zero_inflation", value = true},
			{id = "zero_patron_unlock", value = true}
		},
		modifiers = {
			{id = "dollars", value = 600}
		}
	},
	jokers = {
		{ id = "j_golden", edition = "negative" },
		{ id = "j_golden", edition = "negative" },
	},
	deck = {
		type = 'Challenge Deck',
		enhancement = 'm_gold',
		seal = 'Gold'
	},
	restrictions = {
		banned_cards = {
			{ id = 'v_seed_money' },
			{ id = 'v_money_tree' },
			{ id = 'c_wraith' },
		},
		banned_other = {
			{ id = 'bl_final_vessel', type = 'blind' },
			{ id = 'bl_needle', type = 'blind' },
			{ id = 'bl_ox', type = 'blind' },
		},
	},
	apply = function(self, back)
		G.GAME.interest_cap = 1e9
	end,
	button_colour = SMODS.Gradients.zero_patron
}

SMODS.Challenge {
	key = "dont_forget_me",
	rules = {
		custom = {
			{id = "zero_forgotten", value = true},
			{id = "zero_patron_unlock", value = true}
		}
	},
	calculate = function(self, context)
		if context.post_trigger and context.other_card and context.other_card.ability.set == 'Joker' then
			context.other_card.ability.zero_remembered = true
		end
		if context.starting_shop then
			local forgotten = {}
			for _, joker in ipairs(G.jokers.cards) do
				if not joker.ability.zero_remembered and not SMODS.is_eternal(joker) then
					forgotten[#forgotten + 1] = joker
				end
				joker.ability.zero_remembered = nil
			end
			for _, joker in ipairs(forgotten) do
				SMODS.calculate_effect({ message = localize('k_zero_forgotten'), colour = G.C.UI.TEXT_INACTIVE }, joker)
			end
			if #forgotten > 0 then
				SMODS.destroy_cards(forgotten)
			end
		end
	end,
	button_colour = SMODS.Gradients.zero_patron
}

SMODS.Challenge {
	key = "lotus_eater",
	rules = {
		custom = {
			{id = "zero_drowsy", value = true},
			{id = "zero_patron_unlock", value = true}
		}
	},
	calculate = function(self, context)
		if context.after and G.GAME.current_round.hands_played >= 1 then
			local old_scaling = G.GAME.starting_params.ante_scaling
			G.GAME.starting_params.ante_scaling = old_scaling + 0.05
			local ratio = G.GAME.starting_params.ante_scaling / old_scaling
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.GAME.blind.chips = math.floor(G.GAME.blind.chips * ratio)
					G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
					G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
					G.HUD_blind:recalculate()
					G.hand_text_area.blind_chips:juice_up()
					play_sound('chips2')
					return true
				end
			}))
		end
	end,
	button_colour = SMODS.Gradients.zero_patron
}

SMODS.Challenge {
	key = "world_revolving",
	rules = {
		custom = {
			{id = "zero_world_revolving", value = true},
			{id = "zero_patron_unlock", value = true}
		}
	},
	calculate = function(self, context)
		if context.before then
			G.GAME.zero_best_before_hand = G.GAME.round_scores.hand.amt
		end
	end,
	button_colour = SMODS.Gradients.zero_patron
}

SMODS.Sticker {
	key = "desired",
	badge_colour = HEX("F03464"),
	atlas = "zero_stickers",
	pos = { x = 1, y = 0 },
	sets = { Default = true, Enhanced = true },
	rate = 0,
	should_apply = false,
}

local function zero_is_desired(card, suit)
	return card:is_suit(suit, true) or SMODS.has_any_suit(card) or card.base.suit == "zero_Brights"
end

SMODS.Challenge {
	key = "love_me_forever",
	rules = {
		custom = {
			{id = "zero_love_me_forever", value = true},
			{id = "zero_patron_unlock", value = true}
		}
	},
	restrictions = {
		banned_cards = {
			{ id = 'c_tower' },
			{ id = 'j_marble' },
			{ id = 'c_zero_earth' },
			{ id = 'j_zero_skye' },
			{ id = 'j_zero_obsessive_elementation' },
			{ id = 'j_zero_key_he4rt' },
			{ id = 'p_zero_elemental_normal_1' },
			{ id = 'p_zero_elemental_normal_2' },
			{ id = 'p_zero_elemental_jumbo_1' },
			{ id = 'p_zero_elemental_mega_1' },
		},
		banned_tags = {
			{ id = 'tag_zero_alchemical' },
		},
	},
	apply = function(self, back)
		G.GAME.banned_keys.m_stone = true
	end,
	calculate = function(self, context)
		if context.setting_blind then
			local suit = pseudorandom_element({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }, pseudoseed('zero_love_me_forever'))
			G.GAME.zero_desired_suit = suit
			for _, playing_card in ipairs(G.playing_cards) do
				if zero_is_desired(playing_card, suit) then
					playing_card:add_sticker('zero_desired', true)
				elseif playing_card.ability.zero_desired then
					playing_card:remove_sticker('zero_desired')
				end
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					attention_text({
						text = localize({ type = 'variable', key = 'zero_desire_of_the_round', vars = { localize(suit, 'suits_plural') } }),
						scale = 1,
						hold = 2,
						major = G.play,
						backdrop_colour = G.C.SUITS[suit],
						align = 'cm',
						offset = { x = 0, y = -1 },
						silent = true
					})
					play_sound('tarot2', 0.8)
					return true
				end
			}))
		end
		if context.playing_card_added and context.cards and G.GAME.zero_desired_suit then
			for _, added in ipairs(context.cards) do
				if type(added) == 'table' and added.ability and zero_is_desired(added, G.GAME.zero_desired_suit) then
					added:add_sticker('zero_desired', true)
				end
			end
		end
		if context.debuff_hand then
			for _, played in ipairs(context.full_hand) do
				if not played.ability.zero_desired then
					return {
						debuff = true,
						debuff_text = localize('k_zero_undesired_hand')
					}
				end
			end
		end
	end,
	button_colour = SMODS.Gradients.zero_patron
}

local zero_sin_challenges = {
	wrath = "c_zero_most_dangerous_game",
	greed = "c_zero_glittering_golden",
	gluttony = "c_zero_forever_feast",
	lust = "c_zero_love_me_forever",
	envy = "c_zero_dont_forget_me",
	sloth = "c_zero_lotus_eater",
	pride = "c_zero_world_revolving",
}
local zero_sin_order = { "wrath", "greed", "gluttony", "lust", "envy", "sloth", "pride" }

local zero_sin_start = {
	greed = function()
		G.GAME.modifiers.zero_inflation = true
	end,
	gluttony = function()
		G.GAME.zero_sin_food_bans = {}
		for _, center in ipairs(G.P_CENTER_POOLS.Joker) do
			if not (center.pools and center.pools.Food) and not G.GAME.banned_keys[center.key] then
				G.GAME.banned_keys[center.key] = true
				G.GAME.zero_sin_food_bans[#G.GAME.zero_sin_food_bans + 1] = center.key
			end
		end
	end,
	pride = function()
		G.GAME.modifiers.zero_world_revolving = true
		G.GAME.zero_best_before_hand = nil
	end,
}

local zero_sin_end = {
	greed = function()
		G.GAME.modifiers.zero_inflation = nil
		for _, area in ipairs({ G.jokers, G.consumeables }) do
			for _, owned in ipairs(area.cards) do
				owned:set_cost()
			end
		end
	end,
	gluttony = function()
		for _, key in ipairs(G.GAME.zero_sin_food_bans or {}) do
			G.GAME.banned_keys[key] = nil
		end
		G.GAME.zero_sin_food_bans = nil
	end,
	lust = function()
		for _, playing_card in ipairs(G.playing_cards) do
			if playing_card.ability.zero_desired then
				playing_card:remove_sticker('zero_desired')
			end
		end
		G.GAME.zero_desired_suit = nil
	end,
	envy = function()
		for _, joker in ipairs(G.jokers.cards) do
			joker.ability.zero_remembered = nil
		end
	end,
	pride = function()
		G.GAME.modifiers.zero_world_revolving = nil
		G.GAME.zero_best_before_hand = nil
	end,
}

local function zero_roll_sins()
	for _, sin in ipairs(G.GAME.zero_active_sins or {}) do
		if zero_sin_end[sin] then zero_sin_end[sin]() end
	end
	local pool = {}
	for _, sin in ipairs(zero_sin_order) do
		pool[#pool + 1] = sin
	end
	local active = {}
	for i = 1, G.GAME.round_resets.ante >= 5 and 2 or 1 do
		local sin, index = pseudorandom_element(pool, pseudoseed('zero_50000_shades_of_grey'))
		table.remove(pool, index)
		active[#active + 1] = sin
		if zero_sin_start[sin] then zero_sin_start[sin]() end
	end
	G.GAME.zero_active_sins = active
	G.GAME.zero_sin_ante = G.GAME.round_resets.ante

	local names = {}
	for _, sin in ipairs(active) do
		names[#names + 1] = localize('k_zero_sin_' .. sin)
	end
	G.E_MANAGER:add_event(Event({
		func = function()
			attention_text({
				text = table.concat(names, " & "),
				scale = 1.2,
				hold = 2.5,
				major = G.play,
				backdrop_colour = G.C.PATRON,
				align = 'cm',
				offset = { x = 0, y = -1 },
				silent = true
			})
			play_sound('tarot2', 0.6)
			return true
		end
	}))
end

SMODS.Challenge {
	key = "50000_shades_of_grey",
	unlocked = function(self)
		local completed = G.PROFILES[G.SETTINGS.profile].challenge_progress.completed
		for _, id in pairs(zero_sin_challenges) do
			if not completed[id] then return false end
		end
		return true
	end,
	rules = {
		custom = {
			{id = "zero_50000_shades_of_grey", value = true},
			{id = "zero_50000_shades_of_grey_double", value = true},
			{id = "zero_patron_unlock", value = true}
		}
	},
	calculate = function(self, context)
		if context.setting_blind and G.GAME.zero_sin_ante ~= G.GAME.round_resets.ante then
			zero_roll_sins()
		end
		if context.post_trigger and context.other_card and context.other_card.ability.set == 'Joker' then
			context.other_card.ability.zero_remembered = true
		end
		local ret
		for _, sin in ipairs(G.GAME.zero_active_sins or {}) do
			if not (sin == "envy" and context.post_trigger) then
				local challenge = SMODS.Challenges[zero_sin_challenges[sin]]
				local result = challenge.calculate and challenge:calculate(context)
				ret = ret or result
			end
		end
		if context.starting_shop then
			for _, joker in ipairs(G.jokers.cards) do
				joker.ability.zero_remembered = nil
			end
		end
		return ret
	end,
	button_colour = SMODS.Gradients.zero_patron
}

local zero_sin_shown_rules = {
	greed = { zero_inflation = true },
	gluttony = { zero_only_food = true },
}

local zero_challenge_description_tab = G.UIDEF.challenge_description_tab
function G.UIDEF.challenge_description_tab(args)
	local ret = zero_challenge_description_tab(args)
	local challenge = args and G.CHALLENGES and G.CHALLENGES[args._id]
	if args and args._tab == 'Rules' and challenge and challenge.id == "c_zero_50000_shades_of_grey"
		and G.GAME and G.GAME.challenge == challenge.id and G.GAME.zero_active_sins and #G.GAME.zero_active_sins > 0 then
		local rows = ret.nodes[1].nodes[1].nodes[2].nodes
		for _, sin in ipairs(G.GAME.zero_active_sins) do
			rows[#rows + 1] = { n = G.UIT.R, config = { align = "cl", padding = 0.03 }, nodes = {
				{ n = G.UIT.T, config = { text = localize('k_zero_sin_' .. sin), scale = 0.35, colour = G.C.PATRON, shadow = true } }
			} }
			for _, rule in ipairs(SMODS.Challenges[zero_sin_challenges[sin]].rules.custom) do
				local shown = zero_sin_shown_rules[sin]
				if rule.id ~= "zero_patron_unlock" and (not shown or shown[rule.id]) then
					rows[#rows + 1] = { n = G.UIT.R, config = { align = "cl" }, nodes = localize{ type = 'text', key = 'ch_c_' .. rule.id, vars = { rule.value } } }
				end
			end
		end
	end
	return ret
end
