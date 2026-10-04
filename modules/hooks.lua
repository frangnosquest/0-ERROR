-- modified version of PTA's card use button
-- which is a modified version of aikoshen's wild scrabble card
local cardhighlighthook = Card.highlight
function Card:highlight(is_higlighted)
	local exists = self.children.use_button ~= nil
	local ret = cardhighlighthook(self, is_higlighted)

	if self.config.center.zero_usable and self.area and self.area ~= G.pack_cards then
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
		{
			n = G.UIT.R,
			config = { align = 'cl' },
			nodes = {
				use
			}
		},
	}
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
	if self.zero_secret_bright and suit == "zero_Brights" then 
		for k, v in pairs(G.jokers.cards) do
			if v.config.center.key == "j_zero_found_a_star" and v.ability.extra.placed and v.ability.extra.placed == self.zero_secret_bright then
				return true
			end
		end
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

local alias__Card_calculate_joker = Card.calculate_joker
function Card:calculate_joker(context)
	local ret, post = alias__Card_calculate_joker(self, context)
	if context.joker_main and not context.blueprint and not self.debuff and self.ability.zero_ond then
		local scored = zero_ond_score(self)
		if scored then
			if not ret then return scored, post end
			local tail = ret
			while tail.extra do tail = tail.extra end
			tail.extra = scored
		end
	end
	return ret, post
end
