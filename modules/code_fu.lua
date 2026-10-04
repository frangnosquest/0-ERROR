local function clamp(x, a, b)
	return math.max(a, math.min(b, x))
end

local function num(x)
	if type(x) == "table" then return to_number and to_number(x) or 0 end
	return x or 0
end

local SUITS = { "Spades", "Hearts", "Clubs", "Diamonds" }

local HAND_CONTAINS = {
	["High Card"] = { "High Card" },
	["Pair"] = { "Pair", "Two Pair", "Three of a Kind", "Full House", "Four of a Kind", "Five of a Kind", "Flush House", "Flush Five" },
	["Two Pair"] = { "Two Pair", "Full House", "Flush House" },
	["Three of a Kind"] = { "Three of a Kind", "Full House", "Four of a Kind", "Five of a Kind", "Flush House", "Flush Five" },
	["Four of a Kind"] = { "Four of a Kind", "Five of a Kind", "Flush Five" },
	["Straight"] = { "Straight", "Straight Flush" },
	["Flush"] = { "Flush", "Straight Flush", "Flush House", "Flush Five" },
}

local HAND_PRIOR = {
	["High Card"] = 0.1,
	["Pair"] = 0.45,
	["Two Pair"] = 0.2,
	["Three of a Kind"] = 0.15,
	["Four of a Kind"] = 0.03,
	["Straight"] = 0.1,
	["Flush"] = 0.15,
	["Full House"] = 0.04,
}

local FACE_JOKERS = { "j_scary_face", "j_smiley", "j_photograph", "j_sock_and_buskin", "j_business", "j_midas_mask", "j_reserved_parking", "j_faceless" }
local PROB_JOKERS = { "j_bloodstone", "j_lucky_cat", "j_space", "j_business", "j_8_ball", "j_gros_michel", "j_cavendish", "j_hallucination", "j_sixth_sense" }

local J = {
	j_joker = { 3, "mult" },
	j_greedy_joker = { 4, "mult", false, "suit", "Diamonds" },
	j_lusty_joker = { 4, "mult", false, "suit", "Hearts" },
	j_wrathful_joker = { 4, "mult", false, "suit", "Spades" },
	j_gluttenous_joker = { 4, "mult", false, "suit", "Clubs" },
	j_jolly = { 4, "mult", false, "hand", "Pair" },
	j_zany = { 4, "mult", false, "hand", "Three of a Kind" },
	j_mad = { 4, "mult", false, "hand", "Two Pair" },
	j_crazy = { 4, "mult", false, "hand", "Straight" },
	j_droll = { 4, "mult", false, "hand", "Flush" },
	j_sly = { 3, "chips", false, "hand", "Pair" },
	j_wily = { 3, "chips", false, "hand", "Three of a Kind" },
	j_clever = { 3, "chips", false, "hand", "Two Pair" },
	j_devious = { 3, "chips", false, "hand", "Straight" },
	j_crafty = { 3, "chips", false, "hand", "Flush" },
	j_half = { 4, "mult", false, "hand", "Pair" },
	j_stencil = { 4, "xmult" },
	j_four_fingers = { 4, "util" },
	j_mime = { 4, "retrig" },
	j_credit_card = { 2, "econ" },
	j_ceremonial = { 5, "mult", true },
	j_banner = { 4, "chips" },
	j_mystic_summit = { 4, "mult" },
	j_marble = { 3, "util" },
	j_loyalty_card = { 5, "xmult" },
	j_8_ball = { 3, "util", false, "ranks", { 8 } },
	j_misprint = { 4, "mult" },
	j_dusk = { 5, "retrig" },
	j_raised_fist = { 4, "mult" },
	j_chaos = { 3, "econ" },
	j_fibonacci = { 5, "mult", false, "ranks", { 14, 2, 3, 5, 8 } },
	j_steel_joker = { 5, "xmult", true, "enh", "m_steel" },
	j_scary_face = { 4, "chips", false, "face" },
	j_abstract = { 4, "mult" },
	j_delayed_grat = { 3, "econ" },
	j_hack = { 5, "retrig", false, "ranks", { 2, 3, 4, 5 } },
	j_pareidolia = { 3, "util" },
	j_gros_michel = { 5, "mult" },
	j_even_steven = { 5, "mult", false, "ranks", { 2, 4, 6, 8, 10 } },
	j_odd_todd = { 4, "chips", false, "ranks", { 14, 3, 5, 7, 9 } },
	j_scholar = { 4, "mult", false, "ranks", { 14 } },
	j_business = { 4, "econ", false, "face" },
	j_supernova = { 6, "mult" },
	j_ride_the_bus = { 5, "mult", true },
	j_space = { 5, "util" },
	j_egg = { 2, "econ" },
	j_burglar = { 4, "util" },
	j_blackboard = { 5, "xmult" },
	j_runner = { 5, "chips", true, "hand", "Straight" },
	j_ice_cream = { 4, "chips" },
	j_dna = { 5, "util" },
	j_splash = { 3, "util" },
	j_blue_joker = { 4, "chips" },
	j_sixth_sense = { 4, "util", false, "ranks", { 6 } },
	j_constellation = { 7, "xmult", true },
	j_hiker = { 5, "chips", true },
	j_faceless = { 3, "econ", false, "face" },
	j_green_joker = { 4, "mult", true },
	j_superposition = { 3, "util", false, "hand", "Straight" },
	j_todo_list = { 4, "econ" },
	j_cavendish = { 7, "xmult" },
	j_card_sharp = { 6, "xmult" },
	j_red_card = { 4, "mult", true },
	j_madness = { 6, "xmult", true },
	j_square = { 4, "chips", true, "hand", "Two Pair" },
	j_seance = { 3, "util", false, "hand", "Straight" },
	j_riff_raff = { 4, "util" },
	j_vampire = { 6, "xmult", true, "enhanced" },
	j_shortcut = { 4, "util" },
	j_hologram = { 6, "xmult", true },
	j_vagabond = { 5, "util" },
	j_baron = { 7, "xmult" },
	j_cloud_9 = { 5, "econ", false, "ranks", { 9 } },
	j_rocket = { 6, "econ" },
	j_obelisk = { 6, "xmult", true },
	j_midas_mask = { 5, "util", false, "face" },
	j_luchador = { 3, "util" },
	j_photograph = { 6, "xmult", false, "face" },
	j_gift = { 4, "econ" },
	j_turtle_bean = { 4, "util" },
	j_erosion = { 4, "mult" },
	j_reserved_parking = { 4, "econ", false, "face" },
	j_mail = { 4, "econ" },
	j_to_the_moon = { 4, "econ" },
	j_hallucination = { 3, "util" },
	j_fortune_teller = { 4, "mult", true },
	j_juggler = { 4, "util" },
	j_drunkard = { 4, "util" },
	j_stone = { 4, "chips" },
	j_golden = { 6, "econ" },
	j_lucky_cat = { 5, "xmult", true, "enh", "m_lucky" },
	j_baseball = { 5, "xmult" },
	j_bull = { 5, "chips" },
	j_diet_cola = { 3, "util" },
	j_trading = { 4, "econ" },
	j_flash = { 4, "mult", true },
	j_popcorn = { 4, "mult" },
	j_trousers = { 6, "mult", true, "hand", "Two Pair" },
	j_ancient = { 6, "xmult" },
	j_ramen = { 6, "xmult" },
	j_walkie_talkie = { 4, "mult", false, "ranks", { 10, 4 } },
	j_selzer = { 5, "retrig" },
	j_castle = { 5, "chips", true },
	j_smiley = { 5, "mult", false, "face" },
	j_campfire = { 6, "xmult", true },
	j_ticket = { 4, "econ", false, "enh", "m_gold" },
	j_mr_bones = { 4, "util" },
	j_acrobat = { 6, "xmult" },
	j_sock_and_buskin = { 6, "retrig", false, "face" },
	j_swashbuckler = { 4, "mult" },
	j_troubadour = { 4, "util" },
	j_certificate = { 5, "util" },
	j_smeared = { 4, "util" },
	j_throwback = { 5, "xmult", true },
	j_hanging_chad = { 5, "retrig" },
	j_rough_gem = { 5, "econ", false, "suit", "Diamonds" },
	j_bloodstone = { 6, "xmult", false, "suit", "Hearts" },
	j_arrowhead = { 5, "chips", false, "suit", "Spades" },
	j_onyx_agate = { 5, "mult", false, "suit", "Clubs" },
	j_glass = { 5, "xmult", true, "enh", "m_glass" },
	j_ring_master = { 2, "util" },
	j_flower_pot = { 6, "xmult" },
	j_blueprint = { 6, "copy" },
	j_wee = { 5, "chips", true, "ranks", { 2 } },
	j_merry_andy = { 4, "util" },
	j_oops = { 3, "util" },
	j_idol = { 7, "xmult" },
	j_seeing_double = { 5, "xmult", false, "suit", "Clubs" },
	j_matador = { 4, "econ" },
	j_hit_the_road = { 6, "xmult", true, "ranks", { 11 } },
	j_duo = { 7, "xmult", false, "hand", "Pair" },
	j_trio = { 7, "xmult", false, "hand", "Three of a Kind" },
	j_family = { 7, "xmult", false, "hand", "Four of a Kind" },
	j_order = { 7, "xmult", false, "hand", "Straight" },
	j_tribe = { 7, "xmult", false, "hand", "Flush" },
	j_stuntman = { 6, "chips" },
	j_invisible = { 4, "copy" },
	j_brainstorm = { 6, "copy" },
	j_satellite = { 4, "econ" },
	j_shoot_the_moon = { 4, "mult" },
	j_drivers_license = { 5, "xmult" },
	j_cartomancer = { 5, "util" },
	j_astronomer = { 5, "econ" },
	j_burnt = { 6, "util" },
	j_bootstraps = { 5, "mult" },
}

local function owned_count(S, list)
	local n = 0
	for _, k in ipairs(list) do
		if S.owned[k] then n = n + 1 end
	end
	return n
end

local function rank_ratio(S, ids)
	local n = 0
	for _, id in ipairs(ids) do n = n + (S.ranks[id] or 0) end
	return (n / math.max(1, S.deck_n)) / (#ids / 13)
end

local JB = {
	j_stencil = function(S) return 2 * (S.free_jokers - 1) end,
	j_abstract = function(S) return 0.6 * S.joker_count end,
	j_ceremonial = function(S) return S.joker_count == 0 and -6 or (S.joker_count == 1 and -3 or 0) end,
	j_blueprint = function(S) return S.joker_count == 0 and -4 or 0.5 * S.best_power - 1 end,
	j_brainstorm = function(S) return S.joker_count == 0 and -4 or 0.5 * S.best_power - 1 end,
	j_invisible = function(S) return S.joker_count == 0 and -3 or 0.3 * S.best_power end,
	j_mime = function(S) return (S.enh.m_steel or 0) / 3 + (S.enh.m_gold or 0) / 4 + (S.owned.j_baron and 3 or 0) + (S.owned.j_shoot_the_moon and 1 or 0) end,
	j_baron = function(S) return (rank_ratio(S, { 13 }) - 1) * 3 + (S.owned.j_mime and 2 or 0) end,
	j_shoot_the_moon = function(S) return (rank_ratio(S, { 12 }) - 1) * 3 + (S.owned.j_mime and 1 or 0) end,
	j_pareidolia = function(S) return 1.5 * owned_count(S, FACE_JOKERS) - 1 end,
	j_marble = function(S) return S.owned.j_stone and 3 or -1 end,
	j_stone = function(S) return (S.enh.m_stone or 0) / 2 + (S.owned.j_marble and 3 or 0) - 2 end,
	j_riff_raff = function(S) return S.free_jokers >= 3 and 2 or -3 end,
	j_hologram = function(S) return (S.owned.j_dna or S.owned.j_marble or S.owned.j_certificate) and 3 or 0 end,
	j_dna = function(S) return 2 * (1 - S.stage) end,
	j_drivers_license = function(S) return S.enhanced >= 16 and 4 or (S.enhanced - 10) / 2 end,
	j_oops = function(S) return 1.5 * owned_count(S, PROB_JOKERS) + (S.enh.m_lucky or 0) / 3 - 1 end,
	j_bootstraps = function(S) return clamp(S.money / 10, 0, 4) - 1 end,
	j_bull = function(S) return clamp(S.money / 10, 0, 4) - 1 end,
	j_to_the_moon = function(S) return S.money >= 20 and 2 or -2 end,
	j_erosion = function(S) return (52 - S.deck_n) / 5 end,
	j_blue_joker = function(S) return (S.deck_n - 52) / 10 end,
	j_mystic_summit = function(S) return S.discards <= 2 and 1 or -1 end,
	j_banner = function(S) return S.discards - 3 end,
	j_delayed_grat = function(S) return S.discards >= 4 and 1 or -1 end,
	j_merry_andy = function(S) return S.discards <= 2 and 2 or 0 end,
	j_acrobat = function(S) return S.hands >= 4 and 1 or -1 end,
	j_burnt = function(S) return S.fav_level / 3 end,
	j_constellation = function(S) return math.min(3, S.planets_used / 3) end,
	j_satellite = function(S) return math.min(2, S.planets_used / 5) end,
	j_astronomer = function(S) return math.min(2, S.planets_used / 5) end,
	j_fortune_teller = function(S) return math.min(2, S.tarots_used / 5) end,
	j_cartomancer = function(S) return math.min(2, S.tarots_used / 5) end,
	j_swashbuckler = function(S) return math.min(4, S.sell_total / 4) - 1 end,
	j_baseball = function(S) return 1.5 * S.uncommons - 1 end,
	j_ticket = function(S) return (S.enh.m_gold or 0) / 2 - 1 end,
	j_smeared = function(S) return S.hand_share("Flush") > 0.3 and 2 or 0 end,
	j_four_fingers = function(S) return math.max(S.hand_share("Flush"), S.hand_share("Straight")) > 0.3 and 2 or -1 end,
	j_shortcut = function(S) return S.hand_share("Straight") > 0.3 and 2 or -1 end,
	j_flower_pot = function(S) return S.min_suit_share > 0.15 and 1 or -2 end,
	j_blackboard = function(S) return ((S.suits.Spades + S.suits.Clubs) / math.max(1, S.deck_n) - 0.5) * 10 end,
	j_ride_the_bus = function(S) return (1 - S.face / math.max(1, S.deck_n) / (12 / 52)) * 2 end,
	j_mr_bones = function(S) return S.danger and 6 or 0 end,
	j_luchador = function(S) return S.boss and 3 or 0 end,
}

local function role_bonus(role, scaling, S)
	local st = S.stage
	local v = 0
	if role == "mult" then
		v = 2 * (1 - st) + (S.roles.mult == 0 and 2 or 0)
	elseif role == "chips" then
		v = 1.5 * (1 - st) - st + (S.roles.chips == 0 and 1 or 0)
	elseif role == "xmult" then
		v = 4 * st - (1 - st) + ((S.roles.xmult == 0 and st > 0.25) and 3 or 0)
	elseif role == "econ" then
		v = 4 * (1 - st) - 2 * st + 0.4 * math.min(S.free_jokers, 5) + (S.money < 10 and 1 or 0) - math.max(0, S.roles.econ - 1)
	elseif role == "retrig" then
		v = 1 + st
	end
	if scaling then
		v = v + 2 * (1 - st) - 2 * st
	end
	return v
end

local function fit(d, S)
	local kind, param = d[4], d[5]
	if kind == "suit" then
		return clamp(S.suits[param] / math.max(1, S.deck_n) * 4, 0.3, 1.8)
	elseif kind == "hand" then
		return clamp(0.4 + S.hand_share(param) * 2, 0.3, 1.8)
	elseif kind == "ranks" then
		return clamp(rank_ratio(S, param), 0.3, 1.8)
	elseif kind == "face" then
		return clamp(S.face / math.max(1, S.deck_n) / (12 / 52), 0.3, 1.8)
	elseif kind == "enh" then
		return clamp(0.3 + (S.enh[param] or 0) / 4, 0.3, 1.8)
	elseif kind == "enhanced" then
		return clamp(0.3 + S.enhanced / 6, 0.3, 1.8)
	end
	return 1
end

local function infer_role(card)
	local d = J[card.config.center.key]
	if d then return d[2] end
	local a = card.ability or {}
	if num(a.x_mult) > 1 or num(a.Xmult) > 1 then return "xmult" end
	if num(a.mult) > 0 or num(a.t_mult) > 0 then return "mult" end
	if num(a.t_chips) > 0 then return "chips" end
	if type(a.extra) == "table" then
		local found
		for k, v in pairs(a.extra) do
			if type(k) == "string" and type(v) == "number" then
				local lk = k:lower()
				if lk:find("xmult") or lk:find("x_mult") then return "xmult" end
				if not found and lk:find("mult") then found = "mult" end
				if not found and lk:find("chip") then found = "chips" end
				if not found and (lk:find("dollar") or lk:find("money")) then found = "econ" end
			end
		end
		return found
	end
end

local RARITY_POWER = { 3, 5, 7, 9 }

local function joker_power(card)
	local d = J[card.config.center.key]
	if d then return d[1] end
	return RARITY_POWER[card.config.center.rarity] or 5
end

local function snapshot(self_card)
	local S = {}
	S.ante = num(G.GAME.round_resets.ante)
	S.stage = clamp((S.ante - 1) / 7, 0, 1)
	S.money = num(G.GAME.dollars)
	S.hands = G.GAME.round_resets.hands or 4
	S.discards = G.GAME.round_resets.discards or 3
	S.free_jokers = G.jokers.config.card_limit - #G.jokers.cards
	S.free_cons = G.consumeables.config.card_limit - #G.consumeables.cards + ((self_card and self_card.area == G.consumeables) and 1 or 0)

	S.deck_n = #G.playing_cards
	S.suits = { Spades = 0, Hearts = 0, Clubs = 0, Diamonds = 0 }
	S.ranks, S.enh = {}, {}
	S.face, S.enhanced = 0, 0
	for _, c in ipairs(G.playing_cards) do
		for _, s in ipairs(SUITS) do
			if c:is_suit(s, true) then S.suits[s] = S.suits[s] + 1 end
		end
		local id = c:get_id()
		S.ranks[id] = (S.ranks[id] or 0) + 1
		if c:is_face() then S.face = S.face + 1 end
		local key = c.config.center.key
		if key ~= "c_base" then
			S.enh[key] = (S.enh[key] or 0) + 1
			S.enhanced = S.enhanced + 1
		end
	end
	S.min_suit_share = 1
	for _, s in ipairs(SUITS) do
		S.min_suit_share = math.min(S.min_suit_share, S.suits[s] / math.max(1, S.deck_n))
	end

	S.total_played = 0
	local fav, fav_played = nil, -1
	for name, h in pairs(G.GAME.hands) do
		S.total_played = S.total_played + h.played
		if h.played > fav_played or (h.played == fav_played and h.level > G.GAME.hands[fav].level) then
			fav, fav_played = name, h.played
		end
	end
	S.fav_level = fav and num(G.GAME.hands[fav].level) or 1
	S.hand_share = function(name)
		local n = 0
		for _, h in ipairs(HAND_CONTAINS[name] or { name }) do
			n = n + (G.GAME.hands[h] and G.GAME.hands[h].played or 0)
		end
		return (n + (HAND_PRIOR[name] or 0.02) * 3) / (S.total_played + 3)
	end
	S.exact_share = function(name)
		local played = G.GAME.hands[name] and G.GAME.hands[name].played or 0
		return (played + (HAND_PRIOR[name] or 0.02) * 3) / (S.total_played + 3)
	end

	S.owned, S.roles = {}, { mult = 0, chips = 0, xmult = 0, econ = 0 }
	S.joker_count, S.best_power, S.sell_total, S.uncommons = #G.jokers.cards, 0, 0, 0
	for _, j in ipairs(G.jokers.cards) do
		S.owned[j.config.center.key] = true
		local role = infer_role(j)
		if role and S.roles[role] then S.roles[role] = S.roles[role] + 1 end
		S.best_power = math.max(S.best_power, joker_power(j))
		S.sell_total = S.sell_total + num(j.sell_cost)
		if j.config.center.rarity == 2 then S.uncommons = S.uncommons + 1 end
	end

	local usage = G.GAME.consumeable_usage_total or {}
	S.planets_used = usage.planet or 0
	S.tarots_used = usage.tarot or 0

	local in_round = G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED or G.STATE == G.STATES.DRAW_TO_HAND
	S.boss = in_round and G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled
	S.danger = in_round and G.GAME.current_round.hands_left <= 1 and num(G.GAME.chips) < num(G.GAME.blind.chips)
	return S
end

local function suit_tarot(S, suit)
	local share = S.suits[suit] / math.max(1, S.deck_n)
	local suit_jokers = 0
	for k, d in pairs(J) do
		if S.owned[k] and d[4] == "suit" and d[5] == suit then suit_jokers = suit_jokers + 1 end
	end
	return 1.5 + S.hand_share("Flush") * 4 * share * 4 + suit_jokers * 1.5
end

local C = {
	c_fool = function(S) return 1 end,
	c_magician = function(S) return 2 + (S.owned.j_lucky_cat and 4 or 0) + (S.owned.j_oops and 1 or 0) end,
	c_high_priestess = function(S) return 2.5 + (S.owned.j_constellation and 2 or 0) end,
	c_empress = function(S) return 2.5 + (S.roles.mult == 0 and 1 or 0) end,
	c_emperor = function(S) return 2.5 + ((S.owned.j_fortune_teller or S.owned.j_cartomancer) and 1 or 0) end,
	c_heirophant = function(S) return 2 end,
	c_lovers = function(S) return 2 + S.hand_share("Flush") * 3 end,
	c_chariot = function(S) return 2 + (S.owned.j_steel_joker and 4 or 0) + ((S.owned.j_mime or S.owned.j_baron) and 2 or 0) end,
	c_justice = function(S) return 2.5 + (S.owned.j_glass and 4 or 0) end,
	c_hermit = function(S) return 2 + clamp(S.money, 0, 20) / 5 end,
	c_wheel_of_fortune = function(S) return 1.5 + math.min(2, S.joker_count * 0.4) + (S.owned.j_oops and 2 or 0) end,
	c_strength = function(S) return 2 + ((S.owned.j_hack or S.owned.j_wee or S.owned.j_baron or S.owned.j_fibonacci) and 1.5 or 0) end,
	c_hanged_man = function(S) return 2.5 + clamp((S.deck_n - 52) / 10, 0, 2) end,
	c_death = function(S) return 2 end,
	c_temperance = function(S) return 1.5 + math.min(4, S.sell_total / 5) end,
	c_devil = function(S) return 2 + (S.owned.j_ticket and 4 or 0) + ((S.owned.j_mime or S.owned.j_baron) and 1 or 0) end,
	c_tower = function(S) return 1 + (S.owned.j_stone and 4 or 0) end,
	c_star = function(S) return suit_tarot(S, "Diamonds") end,
	c_moon = function(S) return suit_tarot(S, "Clubs") end,
	c_sun = function(S) return suit_tarot(S, "Hearts") end,
	c_world = function(S) return suit_tarot(S, "Spades") end,
	c_judgement = function(S) return S.free_jokers > 0 and 3.5 or nil end,
	c_familiar = function(S) return 2 + rank_ratio(S, { 11, 12, 13 }) end,
	c_grim = function(S) return 2 + (S.owned.j_scholar and 1.5 or 0) end,
	c_incantation = function(S) return 2 + ((S.owned.j_hack or S.owned.j_even_steven or S.owned.j_fibonacci) and 1.5 or 0) end,
	c_talisman = function(S) return 3 + ((S.owned.j_mime or S.owned.j_baron) and 1 or 0) end,
	c_aura = function(S) return 3 + S.stage end,
	c_wraith = function(S) return S.free_jokers > 0 and (3 + (S.money < 5 and 3 or 0)) or nil end,
	c_sigil = function(S) return 2 + S.hand_share("Flush") * 3 end,
	c_ouija = function(S) return 1.5 + S.hand_share("Four of a Kind") * 4 end,
	c_ectoplasm = function(S) return S.joker_count > 0 and (3 + 3 * S.stage) or nil end,
	c_immolate = function(S) return 3 + (S.money < 10 and 1 or 0) end,
	c_ankh = function(S) return S.joker_count > 0 and (1 + S.best_power / 3) or nil end,
	c_deja_vu = function(S) return 3 end,
	c_hex = function(S) return S.joker_count > 0 and (S.joker_count <= 2 and 4 or 1) or nil end,
	c_trance = function(S) return 3 + (S.owned.j_constellation and 1 or 0) end,
	c_medium = function(S) return 3 + (S.owned.j_constellation and 2 or 0) end,
	c_cryptid = function(S) return 3 end,
	c_black_hole = function(S) return 2 + 4 * S.stage end,
}

local function available(center, S)
	if not center or center.unlocked == false then return false end
	if G.GAME.banned_keys and G.GAME.banned_keys[center.key] then return false end
	if center.yes_pool_flag and not G.GAME.pool_flags[center.yes_pool_flag] then return false end
	if center.no_pool_flag and G.GAME.pool_flags[center.no_pool_flag] then return false end
	if not SMODS.add_to_pool(center) then return false end
	if center.set == "Joker" and S.owned[center.key] and not SMODS.showman(center.key) then return false end
	if center.set == "Planet" and center.config.softlock and center.config.hand_type
	and G.GAME.hands[center.config.hand_type] and G.GAME.hands[center.config.hand_type].played == 0 then
		return false
	end
	return true
end

local function consider(list, key, value)
	if value then list[#list + 1] = { key = key, value = value } end
end

local function ranked_candidates(S)
	local list = {}
	if S.free_jokers > 0 then
		for key, d in pairs(J) do
			local center = G.P_CENTERS[key]
			if available(center, S) then
				local value = (d[1] + role_bonus(d[2], d[3], S)) * fit(d, S)
				if JB[key] then value = value + JB[key](S) end
				consider(list, key, value + 6)
			end
		end
	end
	if S.free_cons > 0 then
		for key, f in pairs(C) do
			local center = G.P_CENTERS[key]
			if available(center, S) then consider(list, key, f(S)) end
		end
		for _, center in ipairs(G.P_CENTER_POOLS.Planet) do
			local hand = center.config.hand_type
			if center.original_mod == nil and hand and G.GAME.hands[hand] and available(center, S) then
				consider(list, center.key, 2 + 6 * S.exact_share(hand) + num(G.GAME.hands[hand].level) * 0.3)
			end
		end
	end
	table.sort(list, function(a, b)
		if a.value ~= b.value then return a.value > b.value end
		return a.key < b.key
	end)
	return list
end

local function log_top(list, n)
	local lines = { "[Code Fu] top " .. n .. " candidates:" }
	for i = 1, math.min(n, #list) do
		local c = list[i]
		local center = G.P_CENTERS[c.key]
		local name = center and localize({ type = "name_text", set = center.set, key = c.key }) or c.key
		lines[#lines + 1] = string.format("  %d. %s (%s) = %.2f", i, name, c.key, c.value)
	end
	local text = table.concat(lines, "\n")
	if sendInfoMessage then sendInfoMessage(text, "CodeFu") else print(text) end
end

function zero_code_fu_pick(self_card)
	local list = ranked_candidates(snapshot(self_card))
	--log_top(list, 5)
	return list[1] and list[1].key
end

SMODS.Consumable {
	key = "code_fu",
	set = "Spectral",
	atlas = "zero_spectral",
	pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
	hidden = true,
	cost = 4,
	in_pool = function(self, args)
		return false
	end,
	can_use = function(self, card)
		local free_cons = G.consumeables.config.card_limit - #G.consumeables.cards + (card.area == G.consumeables and 1 or 0)
		return G.jokers.config.card_limit > #G.jokers.cards or free_cons > 0
	end,
	use = function(self, card, area, copier)
		local key = zero_code_fu_pick(card)
		if not key then return end
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				SMODS.add_card({ set = G.P_CENTERS[key].set, key = key, no_edition = true })
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		delay(0.6)
	end,
}
