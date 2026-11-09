-- modified version of PTA's card use button
-- which is a modified version of aikoshen's wild scrabble card
local cardhighlighthook = Card.highlight
function Card:highlight(is_higlighted)
	local exists = self.children.use_button ~= nil
	local ret = cardhighlighthook(self, is_higlighted)

	if (self.config.center.zero_usable or self.config.center.zero_view_button) and self.area and self.area ~= G.pack_cards then
		if self.highlighted and self.area and self.area.config.type ~= 'shop' and (self.area == G.jokers or self.area == G.consumeables) then
			if self.children.use_button then
				self.children.use_button:remove()
				self.children.use_button = nil
			end
			self.children.use_button = UIBox {
				definition = G.UIDEF.zeroerror_joker_use_buttons(self),
				config = { align =
					((self.area == G.jokers) or (self.area == G.consumeables)) and "cr" or
					"bmi"
				, offset =
					((self.area == G.jokers) or (self.area == G.consumeables)) and { x = -0.5, y = 0 } or
					{ x = 0, y = 0.65 },
					parent = self }
			}
		elseif exists and self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end
	end

	return ret
end


function G.UIDEF.zeroerror_joker_use_buttons(card, use_button)
	local sell = {
		n = G.UIT.C,
		config = { align = "cr" },
		nodes = {
			{
				n = G.UIT.C,
				config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card' },
				nodes = {
					{ n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
					{
						n = G.UIT.C,
						config = { align = "tm" },
						nodes = {
							{
								n = G.UIT.R,
								config = { align = "cm", maxw = 1.25 },
								nodes = {
									{ n = G.UIT.T, config = { text = localize('b_sell'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
								}
							},
							{
								n = G.UIT.R,
								config = { align = "cm" },
								nodes = {
									{ n = G.UIT.T, config = { text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true } },
									{ n = G.UIT.T, config = { ref_table = card, ref_value = 'sell_cost_label', colour = G.C.WHITE, scale = 0.55, shadow = true } }
								}
							}
						}
					}
				}
			},
		}
	}
	local use = use_button and use_button(card) or {
		n = G.UIT.C,
		config = { align = "cr" },
		nodes = {

			{
				n = G.UIT.C,
				config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'use_card', func = 'can_use_consumeable' },
				nodes = {
					{ n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
					{ n = G.UIT.T, config = { text = localize('b_use'), colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true } }
				}
			}
		}
	}
	local rows = {
		{
			n = G.UIT.R,
			config = { align = 'cl' },
			nodes = {
				sell
			}
		},
	}
	if card.config.center.zero_usable then
		rows[#rows + 1] = {
			n = G.UIT.R,
			config = { align = 'cl' },
			nodes = {
				use
			}
		}
	end
	if card.config.center.key == "j_zero_perma_monster" then
		rows[#rows + 1] = {
			n = G.UIT.R,
			config = { align = 'cl' },
			nodes = {
				{
					n = G.UIT.C,
					config = { ref_table = card, align = "cm", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.BLUE, button = 'zero_perma_monster_view' },
					nodes = {
						{ n = G.UIT.B, config = { w = 0.1, h = 0.4 } },
						{ n = G.UIT.T, config = { text = localize('b_zero_absorbed'), colour = G.C.UI.TEXT_LIGHT, scale = 0.35, shadow = true } }
					}
				}
			}
		}
	end
	local view = card.config.center.zero_view_button
	if view then
		rows[#rows + 1] = {
			n = G.UIT.R,
			config = { align = 'cl' },
			nodes = {
				{
					n = G.UIT.C,
					config = { ref_table = card, align = "cm", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = view.colour or G.C.BLUE, button = view.button },
					nodes = {
						{ n = G.UIT.B, config = { w = 0.1, h = 0.4 } },
						{ n = G.UIT.T, config = { text = localize(view.label), colour = G.C.UI.TEXT_LIGHT, scale = 0.35, shadow = true } }
					}
				}
			}
		}
	end
	local t = {
		n = G.UIT.ROOT,
		config = { padding = 0, colour = G.C.CLEAR },
		nodes = {
			{
				n = G.UIT.C,
				config = { padding = 0.15, align = 'cl' },
				nodes = rows
			},
		}
	}
	return t
end

local zero_align_cards = CardArea.align_cards
function CardArea:align_cards()
	if self ~= G.hand then
		return zero_align_cards(self)
	end
	local all, visible, hidden = self.cards, {}, false
	for _, v in ipairs(all) do
		if v.zero_dragee_pending then
			hidden = true
		else
			visible[#visible + 1] = v
		end
	end
	if not hidden then
		return zero_align_cards(self)
	end
	self.cards = visible
	local ret = zero_align_cards(self)
	self.cards = all
	return ret
end

local zero_calculate_round_score = SMODS.calculate_round_score
SMODS.calculate_round_score = function(flames)
  local score = zero_calculate_round_score(flames)
  if G.GAME.modifiers.zero_hand_dollar_cap then
    score = math.min(score, math.max(G.GAME.dollars + (G.GAME.dollar_buffer or 0), 0))
  end
  if G.GAME.modifiers.zero_world_revolving and G.GAME.zero_best_before_hand and score <= G.GAME.zero_best_before_hand then
    score = 0
  end
  return score
end

function zero_inflation_factor()
  local wealth = math.max(G.GAME.dollars + (G.GAME.dollar_buffer or 0), 0)
  return 1.03 ^ (G.GAME.round or 0) * (1 + wealth / 200)
end

local zero_set_cost = Card.set_cost
function Card:set_cost()
  zero_set_cost(self)
  if G.GAME.modifiers.zero_inflation and self.cost > 0 then
    self.cost = math.max(1, math.floor(self.cost * zero_inflation_factor() + 0.5))
    self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
    self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
  end
end

local zero_calculate_reroll_cost = calculate_reroll_cost
function calculate_reroll_cost(skip_increment)
  zero_calculate_reroll_cost(skip_increment)
  if G.GAME.modifiers.zero_inflation and G.GAME.current_round.reroll_cost > 0 then
    G.GAME.current_round.reroll_cost = math.max(1, math.floor(G.GAME.current_round.reroll_cost * zero_inflation_factor() + 0.5))
  end
end

local zero_inflation_vanilla = {
  j_joker = { mult = 'add' },
  j_greedy_joker = { extra = { s_mult = 'add' } },
  j_lusty_joker = { extra = { s_mult = 'add' } },
  j_wrathful_joker = { extra = { s_mult = 'add' } },
  j_gluttenous_joker = { extra = { s_mult = 'add' } },
  j_jolly = { t_mult = 'add' },
  j_zany = { t_mult = 'add' },
  j_mad = { t_mult = 'add' },
  j_crazy = { t_mult = 'add' },
  j_droll = { t_mult = 'add' },
  j_sly = { t_chips = 'add' },
  j_wily = { t_chips = 'add' },
  j_clever = { t_chips = 'add' },
  j_devious = { t_chips = 'add' },
  j_crafty = { t_chips = 'add' },
  j_half = { extra = { mult = 'add' } },
  j_banner = { extra = 'add' },
  j_mystic_summit = { extra = { mult = 'add' } },
  j_loyalty_card = { extra = { Xmult = 'x' } },
  j_misprint = { extra = { max = 'add' } },
  j_fibonacci = { extra = 'add' },
  j_steel_joker = { extra = 'add' },
  j_scary_face = { extra = 'add' },
  j_abstract = { extra = 'add' },
  j_delayed_grat = { extra = 'add' },
  j_gros_michel = { extra = { mult = 'add' } },
  j_even_steven = { extra = 'add' },
  j_odd_todd = { extra = 'add' },
  j_scholar = { extra = { mult = 'add', chips = 'add' } },
  j_ride_the_bus = { extra = 'add' },
  j_egg = { extra = 'add' },
  j_blackboard = { extra = 'x' },
  j_runner = { extra = { chip_mod = 'add' } },
  j_ice_cream = { extra = { chips = 'add' } },
  j_blue_joker = { extra = 'add' },
  j_constellation = { extra = 'add' },
  j_hiker = { extra = 'add' },
  j_faceless = { extra = { dollars = 'add' } },
  j_green_joker = { extra = { hand_add = 'add' } },
  j_todo_list = { extra = { dollars = 'add' } },
  j_cavendish = { extra = { Xmult = 'x' } },
  j_card_sharp = { extra = { Xmult = 'x' } },
  j_red_card = { extra = 'add' },
  j_madness = { extra = 'add' },
  j_square = { extra = { chip_mod = 'add' } },
  j_vampire = { extra = 'add' },
  j_hologram = { extra = 'add' },
  j_baron = { extra = 'x' },
  j_cloud_9 = { extra = 'add' },
  j_rocket = { extra = { dollars = 'add', increase = 'add' } },
  j_obelisk = { extra = 'add' },
  j_photograph = { extra = 'x' },
  j_gift = { extra = 'add' },
  j_erosion = { extra = 'add' },
  j_reserved_parking = { extra = { dollars = 'add' } },
  j_mail = { extra = 'add' },
  j_fortune_teller = { extra = 'add' },
  j_stone = { extra = 'add' },
  j_golden = { extra = 'add' },
  j_lucky_cat = { extra = 'add' },
  j_baseball = { extra = 'x' },
  j_bull = { extra = 'add' },
  j_trading = { extra = 'add' },
  j_flash = { extra = 'add' },
  j_popcorn = { mult = 'add' },
  j_trousers = { extra = 'add' },
  j_ancient = { extra = 'x' },
  j_ramen = { x_mult = 'x' },
  j_walkie_talkie = { extra = { chips = 'add', mult = 'add' } },
  j_castle = { extra = { chip_mod = 'add' } },
  j_smiley = { extra = 'add' },
  j_campfire = { extra = 'add' },
  j_ticket = { extra = 'add' },
  j_acrobat = { extra = 'x' },
  j_throwback = { extra = 'add' },
  j_rough_gem = { extra = 'add' },
  j_bloodstone = { extra = { Xmult = 'x' } },
  j_arrowhead = { extra = 'add' },
  j_onyx_agate = { extra = 'add' },
  j_glass = { extra = 'add' },
  j_flower_pot = { extra = 'x' },
  j_wee = { extra = { chip_mod = 'add' } },
  j_idol = { extra = 'x' },
  j_seeing_double = { extra = 'x' },
  j_matador = { extra = 'add' },
  j_hit_the_road = { extra = 'add' },
  j_duo = { x_mult = 'x' },
  j_trio = { x_mult = 'x' },
  j_family = { x_mult = 'x' },
  j_order = { x_mult = 'x' },
  j_tribe = { x_mult = 'x' },
  j_stuntman = { extra = { chip_mod = 'add' } },
  j_satellite = { extra = 'add' },
  j_shoot_the_moon = { extra = 'add' },
  j_drivers_license = { extra = 'x' },
  j_bootstraps = { extra = { mult = 'add' } },
  j_caino = { extra = 'add' },
  j_triboulet = { extra = 'x' },
  j_yorick = { extra = { xmult = 'add' } },
}
local zero_inflation_payoff_only = { j_raised_fist = true, j_supernova = true }

local zero_inflation_skip_words = { 'odds', 'chance', 'denom', 'numer', 'round', 'size', 'count', 'every', 'remain',
  'discard', 'hand', 'req', 'limit', 'cap', 'min', 'max', 'slot', 'retrigger', 'repetition', 'level', 'threshold' }
local function zero_inflation_guess(key, value)
  if type(value) ~= 'number' then return end
  local k = key:lower()
  for _, word in ipairs(zero_inflation_skip_words) do
    if k:find(word) then return end
  end
  if not (k:find('mult') or k:find('chip') or k:find('dollar') or k:find('money') or k:find('sell')) then return end
  if k:find('mod') or k:find('gain') or k:find('inc') or k:find('per') or k:find('add') then
    return value > 0 and 'add' or nil
  end
  if k:find('^x') or k:find('_x') then
    return value > 1 and 'x' or nil
  end
  return value > 0 and 'add' or nil
end

local function zero_inflation_guess_table(config)
  local spec
  for k, v in pairs(config) do
    local kind = type(v) == 'table' and zero_inflation_guess_table(v) or zero_inflation_guess(k, v)
    if kind then
      spec = spec or {}
      spec[k] = kind
    end
  end
  return spec
end

local zero_inflation_specs = {}
local function zero_inflation_spec(center)
  if zero_inflation_specs[center.key] == nil then
    local spec
    if center.set == 'Tarot' then
      if not center.mod and center.config.max_highlighted then
        spec = { max_highlighted = 'count', consumeable = { max_highlighted = 'count' } }
      elseif center.key == 'c_hermit' or center.key == 'c_temperance' then
        spec = { extra = 'add', consumeable = { extra = 'add' } }
      end
    elseif center.set == 'Joker' then
      if center.mod then
        spec = center.config.extra == nil and nil or { extra = type(center.config.extra) == 'table' and zero_inflation_guess_table(center.config.extra) or nil }
        for k, v in pairs(center.config) do
          local kind = k ~= 'extra' and zero_inflation_guess(k, v)
          if kind then
            spec = spec or {}
            spec[k] = kind
            if k == 'Xmult' then spec.x_mult = kind end
          end
        end
        if spec and not next(spec) then spec = nil end
      else
        spec = zero_inflation_vanilla[center.key]
      end
    end
    zero_inflation_specs[center.key] = spec or false
  end
  return zero_inflation_specs[center.key] or nil
end

local function zero_inflate_number(value, kind, factor)
  if kind == 'count' then return math.max(value, math.floor(value * factor)) end
  local result = kind == 'x' and 1 + (value - 1) * factor or value * factor
  local step = (kind == 'add' and value == math.floor(value)) and 1 or 0.01
  return math.floor(result / step + 0.5) * step
end

local function zero_inflation_snapshot(ability, spec)
  local base = {}
  for k, kind in pairs(spec) do
    if type(kind) == 'table' then
      if type(ability[k]) == 'table' then base[k] = zero_inflation_snapshot(ability[k], kind) end
    elseif type(ability[k]) == 'number' then
      base[k] = ability[k]
    end
  end
  return base
end

local function zero_inflation_apply(ability, base, spec, factor)
  for k, kind in pairs(spec) do
    if type(kind) == 'table' then
      if type(ability[k]) == 'table' and base[k] then zero_inflation_apply(ability[k], base[k], kind, factor) end
    elseif base[k] then
      ability[k] = zero_inflate_number(base[k], kind, factor)
    end
  end
end

function zero_inflate_card(card, factor)
  local center = card.config.center
  local spec = zero_inflation_spec(center)
  if not (spec or zero_inflation_payoff_only[center.key]) then return end
  if spec and not card.ability.zero_inflation_base then
    if card.ability.consumeable then card.ability.consumeable = copy_table(card.ability.consumeable) end
    card.ability.zero_inflation_base = zero_inflation_snapshot(card.ability, spec)
  end
  if card.ability.zero_inflation ~= factor then
    card.ability.zero_inflation = factor
    if spec then zero_inflation_apply(card.ability, card.ability.zero_inflation_base, spec, factor) end
  end
end

local zero_inflation_add_keys = { 'chips', 'h_chips', 'mult', 'h_mult' }
local zero_inflation_x_keys = { 'x_chips', 'xchips', 'x_mult', 'Xmult', 'xmult' }
local zero_inflation_legacy_keys = { chip_mod = 'chips', mult_mod = 'mult', Xmult_mod = 'xmult' }

local zero_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context, ...)
  local eff, post = zero_calculate_joker(self, context, ...)
  local factor = self.ability.zero_inflation
  if type(eff) == 'table' and factor and zero_inflation_payoff_only[self.config.center.key] then
    for old, new in pairs(zero_inflation_legacy_keys) do
      if type(eff[old]) == 'number' then
        eff[new], eff[old], eff.message = eff[old], nil, nil
      end
    end
    for _, key in ipairs(zero_inflation_add_keys) do
      if type(eff[key]) == 'number' and eff[key] > 0 then eff[key] = eff[key] * factor end
    end
    for _, key in ipairs(zero_inflation_x_keys) do
      if type(eff[key]) == 'number' and eff[key] > 1 then eff[key] = 1 + (eff[key] - 1) * factor end
    end
  end
  return eff, post
end

local zero_generate_UIBox_ability_table = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table(...)
  local center = self.config.center
  if self.ability.zero_inflation_base and self.ability.consumeable and center.config ~= self.ability.consumeable then
    local config = center.config
    center.config = self.ability.consumeable
    local ok, ret = pcall(zero_generate_UIBox_ability_table, self, ...)
    center.config = config
    if not ok then error(ret) end
    return ret
  end
  return zero_generate_UIBox_ability_table(self, ...)
end

local function zero_update_score_to_beat(game)
  local show = G.GAME and G.GAME.modifiers and G.GAME.modifiers.zero_world_revolving
    and game.STATE == game.STATES.SELECTING_HAND
    and G.hand and G.hand.highlighted and #G.hand.highlighted > 0
  local text = show and localize({ type = "variable", key = "zero_score_to_beat", vars = { number_format(G.GAME.round_scores.hand.amt) } })
  local state = text and (text .. (G.boss_throw_hand and "_boss" or ""))
  if game.zero_score_to_beat_box and game.zero_score_to_beat_text ~= state then
    game.zero_score_to_beat_box:remove()
    game.zero_score_to_beat_box = nil
    game.zero_score_to_beat_text = nil
  end
  if text and not game.zero_score_to_beat_box then
    game.zero_score_to_beat_box = UIBox {
      definition = { n = G.UIT.ROOT, config = { align = 'cm', colour = G.C.CLEAR, padding = 0.2 }, nodes = {
        { n = G.UIT.R, config = { align = 'cm', maxw = 1 }, nodes = {
          { n = G.UIT.O, config = { object = DynaText({ scale = 0.7, string = text, maxw = 9, colours = { G.C.WHITE }, float = true, shadow = true, silent = true, pop_in = 0, pop_in_rate = 6 }) } },
        } },
      } },
      config = { align = 'cm', offset = { x = 0, y = G.boss_throw_hand and -4.6 or -3.1 }, major = G.play }
    }
    game.zero_score_to_beat_box.attention_text = true
    game.zero_score_to_beat_box.states.collide.can = false
    game.zero_score_to_beat_text = state
  end
end

local zero_game_update = Game.update
function Game:update(dt)
  zero_game_update(self, dt)
  if G.GAME and G.GAME.modifiers and G.GAME.modifiers.zero_inflation then
    for _, area in ipairs({ G.jokers, G.consumeables }) do
      if area and area.cards then
        for _, card in ipairs(area.cards) do
          card:set_cost()
        end
      end
    end
    local factor = zero_inflation_factor()
    for _, area in ipairs({ G.shop_jokers, G.pack_cards }) do
      if area and area.cards then
        for _, card in ipairs(area.cards) do
          zero_inflate_card(card, factor)
        end
      end
    end
    if G.hand and G.consumeables then
      local limit = math.max(G.GAME.starting_params.discard_limit or 5, G.GAME.starting_params.play_limit or 5, 5)
      for _, card in ipairs(G.consumeables.cards) do
        if card.ability.zero_inflation_base and card.ability.consumeable.max_highlighted then
          limit = math.max(limit, card.ability.consumeable.max_highlighted)
        end
      end
      G.hand.config.highlighted_limit = limit
    end
  end
  zero_update_score_to_beat(self)
end

-- pulled from Entropy. thanks ruby!
local e_round = end_round
function end_round()
  e_round()
  local remove_temp = {}
  for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
    for ind, card in pairs(v.cards) do
      if card.ability then
        if card.ability.zero_temporary then
          if card.area ~= G.hand and card.area ~= G.play and card.area ~= G.jokers and card.area ~= G.consumeables then card.states.visible = false end
          card:remove_from_deck()
          card:start_dissolve()
          if card.ability.zero_temporary then remove_temp[#remove_temp+1]=card end
        end
      end
    end
  end
  if #remove_temp > 0 then
    SMODS.calculate_context({remove_playing_cards = true, removed=remove_temp})
  end
end

function zero_error_use_joker (card, area, copier)
	stop_use()
	if card.debuff then return nil end
	local used_tarot = copier or card
	if card.ability.rental and G.GAME.cry_consumeable_rental_rate then
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			blocking = false,
			blockable = false,
			func = (function()
				ease_dollars(-G.GAME.cry_consumeable_rental_rate)
				return true
			end)
		}))
	end

	local obj = card.config.center
	if obj.use and type(obj.use) == 'function' then
		return obj:use(card, area, copier)
	end
end

-- patch for Brights' [Spades/Hearts/Clubs/Diamonds]ness
-- look here for Suit Yourself cards later
local alias__Card_is_suit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if suit == "Spades" and self.ability.set == "Enhanced" and next(SMODS.find_card('j_zero_skye')) then
		return true
	end
	if zero_has_any_regular_suit(self) then
		if suit == "Spades" or suit == "Hearts" or suit == "Clubs" or suit == "Diamonds" then
			return true
		end
		
		-- this specifically makes it do the thing for spectrums
		if suit == "not a suit" then return true end
	end
	if suit == "zero_Brights" and zero_is_secret_bright(self) then
		return true
	end
	return alias__Card_is_suit(self, suit, bypass_debuff, flush_calc)
end

local alias__SMODS_localize_perma_bonuses = SMODS.localize_perma_bonuses
function SMODS.localize_perma_bonuses(specific_vars, desc_nodes)
	local ret = alias__SMODS_localize_perma_bonuses(specific_vars, desc_nodes)
	
    if specific_vars and specific_vars.zero_brights then
        localize{type = 'other', key = 'zero_brights_blurb', nodes = desc_nodes, vars = {}}
    end
	
	return ret
end

--loads saved zone for key to my he4rt
local alias__Game_start_run = Game.start_run
function Game:start_run(args)
	local PREGAME = args and args.savetext and args.savetext.GAME or {}
	if G["Keytomyhe4rt_zone"] then
		G["Keytomyhe4rt_zone"]:remove()
		G["Keytomyhe4rt_zone"] = nil
	end
	if PREGAME.zero_Keytomyhe4rt_zone then
		G["Keytomyhe4rt_zone"] = CardArea(0, 0, G.CARD_W * 100, G.CARD_H,
			{ card_limit = 1e300, type = 'play', highlight_limit = 0 })
		local playing_cards_storage = G["Keytomyhe4rt_zone"]
		playing_cards_storage.states.visible = false
		playing_cards_storage.states.collide.can = false
		playing_cards_storage.states.focus.can = false
		playing_cards_storage.states.click.can = false
		G.GAME.zero_Keytomyhe4rt_zone = true
	end
	alias__Game_start_run(self, args)
end

--prevents l0ck and k3y cards from ever being destroyed
local alias__start_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	if dissolve_colours == "override" then
		alias__start_dissolve(self)
	elseif self.config.center and (self.config.center == G.P_CENTERS.m_zero_k3y or self.config.center == G.P_CENTERS.m_zero_l0ck) then
	else
		alias__start_dissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
	end
end

--prevents l0ck and k3y cards from passing the enhancement when copied
local alias__copy_card = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
	local ret = alias__copy_card(other, new_card, card_scale, playing_card, strip_edition)
	if not card_scale and new_card and new_card.config.center and (new_card.config.center == G.P_CENTERS.m_zero_k3y or new_card.config.center == G.P_CENTERS.m_zero_l0ck) then
		new_card:set_ability("c_base")
	end
	if not card_scale and ret.config.center and (ret.config.center == G.P_CENTERS.m_zero_k3y or ret.config.center == G.P_CENTERS.m_zero_l0ck) then
		ret:set_ability("c_base","override")
	end
	return ret
end

--prevents overwriting l0ck and k3y cards enhancement
local alias__set_ability = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
	if initial ~= "override" and self.config.center and (self.config.center == G.P_CENTERS.m_zero_k3y or self.config.center == G.P_CENTERS.m_zero_l0ck) then
	elseif initial == "override" then
		alias__set_ability(self, center)
	else
		alias__set_ability(self, center, initial, delay_sprites)
	end
end

--take a wild guess
local alias__set_edition = Card.set_edition
function Card:set_edition(center, initial, delay_sprites)
	if self.config.center and (self.config.center == G.P_CENTERS.m_zero_k3y or self.config.center == G.P_CENTERS.m_zero_l0ck) then
	else
		alias__set_edition(self, center, initial, delay_sprites)
	end
end

local alias__set_seal = Card.set_seal
function Card:set_seal(center, initial, delay_sprites)
	if self.config.center and (self.config.center == G.P_CENTERS.m_zero_k3y or self.config.center == G.P_CENTERS.m_zero_l0ck) then
	else
		alias__set_seal(self, center, initial, delay_sprites)
	end
end

--i absolutely loathe this but i don't think there's a better way to implement Dismantled Cube
local alias_G_FUNCS_draw_from_deck_to_hand = G.FUNCS.draw_from_deck_to_hand
G.FUNCS.draw_from_deck_to_hand = function(e)
	if next(SMODS.find_card('j_zero_dismantled_cube')) then
		if not (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
			G.hand.config.card_limit <= 0 and #G.hand.cards == 0 then 
			G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false 
			return true
		end
	
		local hand_space = e
		local cards_to_draw = {}
		if not hand_space then
			local limit = G.hand.config.card_limit - #G.hand.cards - (SMODS.cards_to_draw or 0)
			local unfixed = not G.hand.config.fixed_limit
			local n = 0
			while n < #G.deck.cards do
				local card = G.deck.cards[#G.deck.cards-n]
				local mod = unfixed and (card.ability.card_limit - card.ability.extra_slots_used) or 0
				if limit - 1 + mod < 0 then
				else    
					limit = limit - 1 + mod
					table.insert(cards_to_draw, card)
					if limit <= 0 then break end
				end
				n = n + 1
			end
			hand_space = #cards_to_draw
		end
		SMODS.cards_to_draw = (SMODS.cards_to_draw or 0) + hand_space
		if G.GAME.blind.name == 'The Serpent' and
			not G.GAME.blind.disabled and
			(G.GAME.current_round.hands_played > 0 or
			G.GAME.current_round.discards_used > 0) then
				hand_space = math.min(#G.deck.cards, 3)
		end
		local flags = SMODS.calculate_context({drawing_cards = true, amount = hand_space})
		hand_space = math.min(#G.deck.cards, flags.cards_to_draw or flags.modify or hand_space)
		delay(0.3)
		SMODS.drawn_cards = {}
		local suit_order = {}
		for i = #SMODS.Suit.obj_buffer, 1, -1 do
			table.insert(suit_order, SMODS.Suit.obj_buffer[i])
		end
		local suit_groups = {}
		for _, playing_card in ipairs(G.deck.cards) do
			local suit = playing_card.base.suit or "none"
			if not suit_groups[suit] then
			suit_groups[suit] = {}
			end
			table.insert(suit_groups[suit], playing_card)
		end
		for _, group in pairs(suit_groups) do
			zero_cube_shuffle(group)
		end
		local ordered = {}
		for _, suit in ipairs(suit_order) do
			if suit_groups[suit] then
			for _, c in ipairs(suit_groups[suit]) do
				table.insert(ordered, c)
			end
			end
		end
		if suit_groups["none"] then
			for _, c in ipairs(suit_groups["none"]) do
			table.insert(ordered, c)
			end
		end
		for i=1, hand_space do
			if G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK then 
				draw_card(G.deck,G.hand, i*100/hand_space,'up', true, ordered[i])
			else
				draw_card(G.deck,G.hand, i*100/hand_space,'up', true, ordered[i])
			end
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'immediate',
			func = function()                
				SMODS.cards_to_draw = math.max(SMODS.cards_to_draw - hand_space, 0)
				return true
			end
		}))
		G.E_MANAGER:add_event(Event({
			trigger = 'before',
			delay = 0.4,
			func = function()
				if #SMODS.drawn_cards > 0 then
					SMODS.calculate_context({first_hand_drawn = not G.GAME.current_round.any_hand_drawn and G.GAME.facing_blind,
											hand_drawn = G.GAME.facing_blind and SMODS.drawn_cards,
											other_drawn = not G.GAME.facing_blind and SMODS.drawn_cards})
					SMODS.drawn_cards = {}
					if G.GAME.facing_blind then G.GAME.current_round.any_hand_drawn = true end
				end
				return true
			end
		}))
	else
		return alias_G_FUNCS_draw_from_deck_to_hand(e)
	end
end

--debuff preventions, thank you unik!
local Card_set_debuff = Card.set_debuff
function Card:set_debuff(should_debuff)
    if self and ( next(SMODS.find_card("j_zero_lip_balm")) or SMODS.has_enhancement(self,'m_wild') )  then
        if self.debuff then
            self.debuff = false
            if self.area == G.jokers then self:add_to_deck(true) end
        end
        return
    else
        Card_set_debuff(self,should_debuff)
    end
end

local zero_blueprint_compat = G.FUNCS.blueprint_compat
G.FUNCS.blueprint_compat = function(e)
  local card = e.config.ref_table
  if card.ability.blueprint_compat == 'incompatible' and G.jokers then
    local other
    if card.ability.name == 'Brainstorm' then
      other = G.jokers.cards[1]
    else
      for i, joker in ipairs(G.jokers.cards) do
        if joker == card then other = G.jokers.cards[i + 1] end
      end
    end
    if other and other ~= card and other.config.center.key == 'j_zero_egeo' then
      if card.ability.blueprint_compat_check ~= 'zero_proud' then
        e.config.colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
        card.ability.blueprint_compat_ui = ' ' .. localize('k_zero_proud') .. ' '
        card.ability.blueprint_compat_check = 'zero_proud'
      end
      return
    end
  end
  return zero_blueprint_compat(e)
end

local zero_localize = localize
function localize(args, ...)
  if type(args) == 'table' and args.type == 'text' and type(args.key) == 'string' and args.key:find('^ch_c_zero_') then
    local parsed = G.localization.misc.v_text_parsed
    local target = parsed[args.key]
    if target and #target > 1 then
      local rows = {}
      for _, line in ipairs(target) do
        parsed[args.key] = { line }
        rows[#rows + 1] = { n = G.UIT.R, config = { align = "cl" }, nodes = zero_localize(args, ...) }
      end
      parsed[args.key] = target
      return { { n = G.UIT.C, config = { align = "cl" }, nodes = rows } }
    end
  end
  return zero_localize(args, ...)
end

local zero_create_card = SMODS.create_card
function SMODS.create_card(t)
  if t and not t.set and t.type then t.set = t.type end
  return zero_create_card(t)
end

local SMODS_debuff_card = SMODS.debuff_card
function SMODS.debuff_card(card, debuff, source)
    if card and ( next(SMODS.find_card("j_zero_lip_balm")) or SMODS.has_enhancement(card,'m_wild') ) then
        if card.debuff then
            card.debuff = false
            if card.area == G.jokers then card:add_to_deck(true) end
        end
        return
    else
        SMODS_debuff_card(card,debuff,source)
    end
end

--for Q ◣:
--adding a context to check if the player attempted to move jokers
local Node_stop_drag = Node.stop_drag
function Node:stop_drag()
	SMODS.calculate_context({ zero_moved = true })
	return Node_stop_drag(self)
end

--Time Walk prevention
alias_ease_ante = ease_ante
function ease_ante(mod)
	if not next(SMODS.find_card('j_zero_time_walk')) then
		return alias_ease_ante(mod)
	end
end

local function zero_food_snapshot(ability)
	local snap = {}
	for k, v in pairs(ability) do
		if type(v) == 'number' then
			snap[k] = v
		elseif k == 'extra' and type(v) == 'table' then
			snap.extra = {}
			for k2, v2 in pairs(v) do
				if type(v2) == 'number' then snap.extra[k2] = v2 end
			end
		end
	end
	return snap
end

local function zero_food_changed(snap, ability)
	for k, v in pairs(snap) do
		if k == 'extra' and type(v) == 'table' then
			if type(ability.extra) == 'table' then
				for k2, v2 in pairs(v) do
					if ability.extra[k2] ~= v2 then return true end
				end
			end
		elseif ability[k] ~= v then
			return true
		end
	end
	return false
end

local alias__Card_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context)
	local anathemas = G.jokers and self.ability.set == 'Joker' and self.config.center.pools and self.config.center.pools.Food
		and SMODS.find_card('j_zero_hidden_anathema')
	local snap = anathemas and next(anathemas) and zero_food_snapshot(self.ability)
	local ret, post = alias__Card_calculate_joker(self, context)
	if snap then
		if zero_food_changed(snap, self.ability) then
			for _, anathema in ipairs(anathemas) do
				anathema.ability.extra.xmult = anathema.ability.extra.xmult + anathema.ability.extra.xmult_gain
				SMODS.calculate_effect({ message = localize({ type = 'variable', key = 'a_xmult', vars = { anathema.ability.extra.xmult } }), colour = G.C.MULT }, anathema)
			end
		end
	end
	if context.joker_main and not context.blueprint and not self.debuff and self.ability.zero_ond then
		local scored = zero_ond_score(self)
		if scored then
			if not ret then return scored, post end
			local tail = ret
			while tail.extra do tail = tail.extra end
			tail.extra = scored
		end
	end
	if context.joker_main and not context.blueprint and not self.debuff and (self.ability.zero_spread or 0) > 0 then
		local spread = { mult = self.ability.zero_spread }
		if not ret then return spread, post end
		local tail = ret
		while tail.extra do tail = tail.extra end
		tail.extra = spread
	end
	return ret, post
end

local zero_nested_card_lists = { "copied_jokers", "stored_jokers" }

local function zero_take_nested_cards(card)
	local imm = card and card.ability and card.ability.immutable
	if type(imm) ~= "table" then return end
	local held
	for _, k in ipairs(zero_nested_card_lists) do
		if type(imm[k]) == "table" then
			held = held or {}
			held[k] = imm[k]
			imm[k] = {}
		end
	end
	return held
end

local function zero_hide_nested_card(card)
	card.T.x, card.T.y = -1000, -1000
	card.VT.x, card.VT.y = -1000, -1000
end

local alias__copy_card = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
	local held = zero_take_nested_cards(other)
	local ret = alias__copy_card(other, new_card, card_scale, playing_card, strip_edition)
	if held then
		for k, list in pairs(held) do
			other.ability.immutable[k] = list
			local copies = {}
			for _, c in ipairs(list) do
				if type(c) == "table" and c.is and c:is(Card) then
					local nc = copy_card(c)
					zero_hide_nested_card(nc)
					copies[#copies + 1] = nc
				end
			end
			ret.ability.immutable[k] = copies
		end
	end
	return ret
end

local alias__card_save = Card.save
function Card:save()
	local held = zero_take_nested_cards(self)
	local ret = alias__card_save(self)
	if held then
		local ability = {}
		for k, v in pairs(self.ability) do ability[k] = v end
		local imm = {}
		for k, v in pairs(self.ability.immutable) do imm[k] = v end
		ability.immutable = imm
		for k, list in pairs(held) do
			self.ability.immutable[k] = list
			local saved = {}
			for _, c in ipairs(list) do
				if type(c) == "table" and c.is and c:is(Card) then
					saved[#saved + 1] = c:save()
				end
			end
			imm[k] = { zero_saved_cards = saved }
		end
		ret.ability = ability
	end
	return ret
end

local alias__card_load = Card.load
function Card:load(cardTable, other_card)
	local ret = alias__card_load(self, cardTable, other_card)
	local imm = self.ability and self.ability.immutable
	if type(imm) == "table" then
		for _, k in ipairs(zero_nested_card_lists) do
			if type(imm[k]) == "table" and imm[k].zero_saved_cards then
				local cards = {}
				for _, saved in ipairs(imm[k].zero_saved_cards) do
					local c = Card(0, 0, G.CARD_W, G.CARD_H, G.P_CENTERS.j_joker, G.P_CENTERS.c_base)
					c:load(saved)
					zero_hide_nested_card(c)
					cards[#cards + 1] = c
				end
				imm[k] = cards
			end
		end
	end
	return ret
end
