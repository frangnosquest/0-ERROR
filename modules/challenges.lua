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