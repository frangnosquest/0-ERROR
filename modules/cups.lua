SMODS.Atlas {
  key = "zero_cups",
  px = 71,
  py = 95,
  path = "zero_cups.png"
}

SMODS.ConsumableType {
  key = "Cups",
  primary_colour = HEX("53468A"),
  secondary_colour = HEX("8A71E1"),
  loc_txt = {
    name = 'Cups', -- used on card type badges
 		collection = 'Cups Cards', -- label for the button to access the collection
 		undiscovered = { -- description for undiscovered cards in the collection
 			name = 'Undiscovered',
 			text = { '???' },
 		},
  },
  collection_rows = { 7, 7 },
  shop_rate = 0.0
}

SMODS.UndiscoveredSprite {
    key = "Cups",
    atlas = "zero_cups",
    pos = {x = 4, y = 2} 
}
  
SMODS.Booster({
  key = "cups_normal_1",
  kind = "Cups",
  atlas = "zero_booster",
  pos = { x = 4, y = 0 },
  config = { extra = 3, choose = 1 },
  cost = 4,
  draw_hand = true,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Cups", G.pack_cards, nil, nil, true, true, nil, "zero_cups")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Cups)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Cups, special_colour = G.C.CUPS, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
  end,
  group_key = "k_cups_pack",
})
SMODS.Booster({
  key = "cups_normal_2",
  kind = "Cups",
  atlas = "zero_booster",
  pos = { x = 5, y = 0 },
  config = { extra = 3, choose = 1 },
  cost = 4,
  draw_hand = true,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Cups", G.pack_cards, nil, nil, true, true, nil, "zero_cups")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Cups)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Cups, special_colour = G.C.CUPS, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 2} }
  end,
  group_key = "k_cups_pack",
})
SMODS.Booster({
  key = "cups_jumbo_1",
  kind = "Cups",
  atlas = "zero_booster",
  pos = { x = 6, y = 0 },
  config = { extra = 5, choose = 1 },
  cost = 6,
  draw_hand = true,
  weight = 0.48,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Cups", G.pack_cards, nil, nil, true, true, nil, "zero_cups")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Cups)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Cups, special_colour = G.C.CUPS, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 1, card.ability and card.ability.extra or 4} }
  end,
  group_key = "k_cups_pack",
})
SMODS.Booster({
  key = "cups_mega_1",
  kind = "Cups",
  atlas = "zero_booster",
  pos = { x = 7, y = 0 },
  config = { extra = 5, choose = 2 },
  cost = 8,
  draw_hand = true,
  weight = 0.24,
  unlocked = true,
  discovered = true,
  create_card = function(self, card)
    local n_card = create_card("Cups", G.pack_cards, nil, nil, true, true, nil, "zero_cups")
    return n_card
  end,
  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Cups)
    ease_background_colour({ new_colour = G.C.SECONDARY_SET.Cups, special_colour = G.C.CUPS, contrast = 2 })
  end,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.config and card.config.center.config.choose or 2, card.ability and card.ability.extra or 4} }
  end,
  group_key = "k_cups_pack",
})

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_ace',
	pos = { x = 0, y = 0 },
	config = {
		max_highlighted = 1,
		suit_conv = "zero_Brights",
	},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, localize(card.ability.suit_conv, 'suits_plural'), colours = {G.C.SUITS[card.ability.suit_conv] }, } }
    end,
	use = function(self, card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:change_suit(card.ability.consumeable.suit_conv);return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.0,
				func = (function()
					local card = create_card('Cups',G.consumeables, nil, nil, nil, nil, nil, 'cups_ace')
					card:add_to_deck()
					G.consumeables:emplace(card)
					G.GAME.consumeable_buffer = 0
				return true
			end)}))
		end
		delay(0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_two',
	pos = { x = 1, y = 0 },
	config = {
		generate = { "Prestige", "Planet"}
	},
	can_use = function(self, card)
		return (G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit) or (card.area == G.consumeables)
	end,
	use = function(self, card)
		local count = 1
        for i = 1, math.min(#card.ability.generate, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = card.ability.generate[count] })
                        card:juice_up(0.3, 0.5)
						count = count + 1
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_three',
	pos = { x = 2, y = 0 },
	config = {
		max_highlighted = 5,
		random_mod_conv = {"m_steel","m_gold","m_zero_sunsteel"},
	},
	loc_vars = function(self, info_queue, card)
		for _, v in pairs(card.ability.random_mod_conv) do
			info_queue[#info_queue + 1] = G.P_CENTERS[v]
		end
        return { vars = { card.ability.max_highlighted} }
    end,
	can_use = function(self, card)
		if G.hand and (G.hand.highlighted and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted > 0) then
			for _, v in pairs(G.hand.highlighted) do
				if not next(SMODS.get_enhancements(v)) then
					return false
				end
			end
			return true
		end
		return false
	end,
	use = function(self, card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability(pseudorandom_element(card.ability.random_mod_conv, "cups_two"));return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		delay(0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_four',
	pos = { x = 3, y = 0 },
	can_use = function(self, card)
		return G.hand and G.hand.highlighted and #G.hand.highlighted == 1
	end,
	use = function(self, card)
		local _target = G.hand.highlighted[1]
        for i = 1, #G.hand.cards do
            if G.hand.cards[i] == _target and (G.hand.cards[i-1] or G.hand.cards[i+1]) then
				local to_buff = {}
				for _, v in pairs({i-1,i+1}) do
					if G.hand.cards[v] then
						to_buff[#to_buff+1] = G.hand.cards[v]
					end
				end
				if _target.config.center.key ~= "c_base" or _target.seal or _target.edition then
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
					_target:flip();play_sound('card1');_target:juice_up(0.3, 0.3)
					for _, v in pairs(to_buff) do
						v:flip();play_sound('card1');v:juice_up(0.3, 0.3)
					end
					return true end }))
					delay(0.2)
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
					for _, v in pairs(to_buff) do
						if _target.config.center.key ~= "c_base" then
							v:set_ability(_target.config.center.key)
						end
						if _target.seal then
							v:set_seal(_target.seal,true)
						end
						if _target.edition then
							v:set_edition(_target.edition,true)
						end
					end
					_target:set_ability('c_base')
					_target:set_seal()
					_target:set_edition()
					return true end }))
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
					for _, v in pairs(to_buff) do
					v:flip();play_sound('tarot2', nil, 0.6);v:juice_up(0.3, 0.3)
					end
					_target:flip();play_sound('tarot2', nil, 0.6);_target:juice_up(0.3, 0.3)
					return true end }))
				end
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				return true end }))
				break
			end
        end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.6)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_five',
	pos = { x = 4, y = 0 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
    end,
	can_use = function(self, card)
		local valid = {}
		for k, v in ipairs(G.consumeables.cards) do
			if not (v.edition and v.edition.negative) then
				valid[#valid+1] = v
			end
		end
		if #valid > 0 then
			return true
		end
	end,
	use = function(self, card)
		local valid = {}
		for k, v in ipairs(G.consumeables.cards) do
			if not (v.edition and v.edition.negative) then
				valid[#valid+1] = v
			end
		end
		if #valid > 0 then
			pseudorandom_element(valid, "cups_two"):set_edition("e_negative")
		end
		card:juice_up(0.3, 0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_six',
	pos = { x = 0, y = 1 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = 'eternal', set = 'Other'}
	end,
	can_use = function(self, card)
        return G.jokers and G.jokers.highlighted and #G.jokers.highlighted == 1
    end,
	use = function(self, card)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
				play_sound('tarot1')
                G.jokers.highlighted[1].ability.eternal = true
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.jokers:unhighlight_all(); return true end }))
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_seven',
	pos = { x = 1, y = 1 },
	config = {
		max_highlighted = 2,
	},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted} }
    end,
	use = function(self, card)
		local _givenseal
		local given____
		for _, v in pairs(G.hand.highlighted) do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					play_sound('tarot1')
					_givenseal = SMODS.poll_seal({guaranteed = true, type_key = seal_type})
					while _givenseal == nil or _givenseal == "akyrs_debuff" do
						_givenseal = SMODS.poll_seal({guaranteed = true, type_key = seal_type})
					end
					v:set_seal(_givenseal)
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_eight',
	pos = { x = 2, y = 1 },
	config = { extra = {
		destroy = 4,
		copies = 1}
	},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroy, card.ability.extra.destroy == 1 and "" or "s", card.ability.extra.copies, card.ability.extra.copies == 1 and "y" or "ies"} }
    end,
	can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
	use = function(self, card, area, copier)
        local destroyed_cards = {}
        local temp_hand = {}

        for _, playing_card in ipairs(G.hand.cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )

        pseudoshuffle(temp_hand, 'immolate')
		local count = 1
        for i = 1, card.ability.extra.destroy do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] count = count + 1 end
		local to_copy = temp_hand[count]
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        SMODS.destroy_cards(destroyed_cards)
        delay(0.5)
		if to_copy then
			G.E_MANAGER:add_event(Event({
				func = function()
					local _first_dissolve = nil
					local new_cards = {}
					for i = 1, card.ability.extra.copies do
						G.playing_card = (G.playing_card and G.playing_card + 1) or 1
						local _card = copy_card(to_copy, nil, nil, G.playing_card)
						_card:add_to_deck()
						G.deck.config.card_limit = G.deck.config.card_limit + 1
						table.insert(G.playing_cards, _card)
						G.hand:emplace(_card)
						_card:start_materialize(nil, _first_dissolve)
						_first_dissolve = true
						new_cards[#new_cards + 1] = _card
					end
					SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
					return true
				end
			}))
		end
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_nine',
	pos = { x = 3, y = 1 },
	config = {
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.max_highlighted == 1 and "" or "s"} }
    end,
	use = function(self, card)
		local chosencard
		for i = 1, #G.hand.highlighted do
			if G.hand.highlighted[i].config.center and G.hand.highlighted[i].config.center.key ~= "c_base" then
				if not G.hand.highlighted[i].edition then
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.4,
						func = function()
						G.hand.highlighted[i]:set_edition("e_polychrome",true)
						card:juice_up(0.3, 0.5)
						return true
						end
					}))
				else
					if not G.hand.highlighted[i].seal then
						G.E_MANAGER:add_event(Event({
							func = function()
								play_sound('tarot1')
								card:juice_up(0.3, 0.5)
								return true
							end
						}))
						G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.1,
						func = function()
							G.hand.highlighted[i]:set_seal("Red", nil, true)
							return true
						end
						}))
						delay(0.5)			
					else
						G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
						play_sound('tarot1')
						G.hand.highlighted[i]:juice_up(0.3, 0.5)
						G.hand.highlighted[i].ability.perma_bonus = G.hand.highlighted[i].ability.perma_bonus or 0
						G.hand.highlighted[i].ability.perma_bonus = G.hand.highlighted[i].ability.perma_bonus + 50
						return true end }))
					end
				end
			else
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1');G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
				delay(0.2)
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability("m_steel");return true end }))
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', nil, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		delay(0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_ten',
	pos = { x = 4, y = 1 },
	config = { extra = {
		odds = 4,}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative', set = 'Edition', config = { extra = 1 } }
        return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal } }
    end,
	can_use = function(self, card)
        return true
    end,
	use = function(self, card)
		if SMODS.pseudorandom_probability(card, 'zero_cups_ten', 1, card.ability.extra.odds) then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
				play_sound('timpani')
				SMODS.add_card({ set = 'Joker', edition = 'e_negative' })
				card:juice_up(0.3, 0.5)
				return true
            end
			}))
			delay(0.6)
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.CUPS,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_page',
	pos = { x = 0, y = 2 },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_zero_gala
	end,
	can_use = function(self, card)
		if G.jokers then
			local glitches = {}
			local foundglitches = {}
			for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
				if v.zero_glitch then
					glitches[#glitches + 1] = v.key
				end
			end
			for _, v in pairs(G.jokers.cards) do
				if not v.edition then
					for _, w in pairs(glitches) do
						if v.config.center.key == w then
							foundglitches[#foundglitches + 1] = v
						end
					end
				end
			end
			return #foundglitches > 0 or (#G.jokers.cards < G.jokers.config.card_limit)
		end
    end,
	use = function(self, card)
		local glitches = {}
		local foundglitches = {}
		for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if v.zero_glitch and (v.key ~= "j_zero_missingno"
			or (v.key == "j_zero_missingno" and G.jokers and G.jokers.cards[6] and G.jokers.cards[6].config.center.key ~= "j_zero_missingno" and G.jokers.cards[6].config.center.key ~= "j_zero_q_triangle" and pseudorandom('cups_page') < 1 / 4))then
				glitches[#glitches + 1] = v.key
			end
		end
		for _, v in pairs(G.jokers.cards) do
			if not v.edition then
				for _, w in pairs(glitches) do
					if v.config.center.key == w or v.config.center.key == "j_zero_missingno" then
						foundglitches[#foundglitches + 1] = v
					end
				end
			end
		end
		if #foundglitches > 0 then
			pseudorandom_element(foundglitches, "cups_page"):set_edition("e_zero_gala", true)
		else
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
				play_sound('timpani')
				SMODS.add_card({ set = 'Joker', key = pseudorandom_element(glitches, "cups_page")})
				card:juice_up(0.3, 0.5)
				return true
            end
			}))
			delay(0.6)
		end
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_knight',
	pos = { x = 1, y = 2 },
	config = {
		max_highlighted = 1,
		mod_conv = "m_zero_sunsteel",
		boost = 0.1
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_zero_sunsteel
        return { vars = { card.ability.max_highlighted, 
		localize{
			type = 'name_text',
			set = 'Enhanced',
			key = card.ability.mod_conv
		},
		card.ability.max_highlighted == 1 and "" or "s", 
		card.ability.boost } }
    end,
	use = function(self, card)
		G.GAME.zero_sunsteel_pow = G.GAME.zero_sunsteel_pow or 0
		G.GAME.zero_sunsteel_pow = G.GAME.zero_sunsteel_pow + card.ability.boost
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability(card.ability.consumeable.mod_conv);return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		delay(0.5)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				card:juice_up(0.3, 0.5)
				if G.hand then
					for k, v in pairs(G.hand.cards) do
						if SMODS.has_enhancement(v, "m_zero_sunsteel") then
							v:juice_up(0.5)
						end
					end
				end
				play_sound('zero_sunsteelpow', 1, 0.4)
				return true
			end
		}))
		delay(0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_queen',
	pos = { x = 2, y = 2 },
	config = {
		max_highlighted = 1,
	},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.max_highlighted == 1 and "" or "s" } }
    end,
	use = function(self, card)
		local possible_suits = {}
		local to_find = {}
		for k, v in pairs(SMODS.Suit.obj_table) do
			if G.hand.highlighted[1]:is_suit(k) then
				to_find[#to_find + 1] = k
			else
				possible_suits[#possible_suits + 1] = k
			end
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
        return true end }))
		if #possible_suits == 0 then
			local to_destroy = {}
			for i=1, #G.hand.cards do
				if not SMODS.has_no_suit(G.hand.cards[i]) then
					to_destroy[#to_destroy + 1] = G.hand.cards[i]
				end
			end
			SMODS.destroy_cards(to_destroy)
		else
			local to_convert = {}
			for i=1, #G.hand.cards do
				convertable = true
				for k, v in ipairs(to_find) do
					if G.hand.cards[i]:is_suit(v) then
						to_convert[#to_convert + 1] = G.hand.cards[i]
						break
					end
				end
			end
			for i=1, #to_convert do
				local percent = 1.15 - (i-0.999)/(#to_convert-0.998)*0.3
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() to_convert[i]:flip();play_sound('card1', percent);to_convert[i]:juice_up(0.3, 0.3);return true end }))
			end
			delay(0.2)
			for i=1, #to_convert do
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() to_convert[i]:change_suit(pseudorandom_element(possible_suits,cups_queen));return true end }))
			end    
			for i=1, #to_convert do
				local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() to_convert[i]:flip();play_sound('tarot2', percent, 0.6);to_convert[i]:juice_up(0.3, 0.3);return true end }))
			end
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		end
		delay(0.5)
    end
}

SMODS.Consumable{
    set = 'Cups',
	atlas = 'zero_cups',
    key = 'cups_king',
	pos = { x = 3, y = 2 },
	config = {extra = { money = 1 }},
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.cups and ((G.GAME.consumeable_usage_total.cups + 1) * card.ability.extra.money) or 1 } }
    end,
	can_use = function(self, card)
        return true
    end,
	use = function(self, card)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars( G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.cups and (G.GAME.consumeable_usage_total.cups * card.ability.extra.money ) or 1, true)
                return true
            end
        }))
        delay(0.6)
    end
}