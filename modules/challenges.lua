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
			{id = "zero_no_cups", value = true},
			{id = "zero_no_elemental", value = true},
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