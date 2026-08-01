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