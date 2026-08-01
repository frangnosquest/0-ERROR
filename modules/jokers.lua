SMODS.Atlas {
  key = "zero_jokers",
  px = 71,
  py = 95,
  path = "zero_jokers.png"
}

SMODS.Atlas {
  key = "zero_jokers_2",
  px = 71,
  py = 95,
  path = "zero_jokers_2.png"
}

SMODS.Atlas {
  key = "zero_patrons",
  px = 71,
  py = 95,
  path = "zero_patrons.png"
}

SMODS.Joker {
  key = "mad",
  name = "Mutual Assured Destruction",
  config = {
  },
  pos = {x = 0, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
    if context.end_of_round and context.cardarea == G.jokers then
      if G.GAME.current_round.hands_left == 0 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = (function()
              local card = create_card('Prestige',G.consumeables, nil, nil, nil, nil, nil, 'mad')
              card:add_to_deck()
              G.consumeables:emplace(card)
              G.GAME.consumeable_buffer = 0
            return true
          end)}))
        return {
          message = localize('k_plus_prestige'),
          colour = G.C.SECONDARY_SET.Spectral,
          card = card
        }
      end
    end
    if context.forcetrigger then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = (function()
              local card = create_card('Prestige',G.consumeables, nil, nil, nil, nil, nil, 'mad')
              card:add_to_deck()
              G.consumeables:emplace(card)
              G.GAME.consumeable_buffer = 0
            return true
          end)}))
        return {
          message = localize('k_plus_prestige'),
          colour = G.C.SECONDARY_SET.Spectral,
          card = card
        }
      end
    end
  end
}

SMODS.Joker {
  key = "paraquiet",
  name = "Paraquiet",
  config = {
    extra = {
      odds = 2,
      my_mult = 0,
      mult_per = 1,
    }
  },
  pos = {x = 2, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  loc_vars = function(self, info_queue, center)
    local new_numerator, new_denominator = SMODS.get_probability_vars(center, 1, center.ability.extra.odds, 'paraquiet')
    return {vars = {
      new_numerator, new_denominator,
      center.ability.extra.mult_per,
      center.ability.extra.my_mult,
    }}
  end,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers then
      local returns = {}
      for _, other_card in ipairs(context.full_hand) do
        if other_card.base.id ~= 2 and SMODS.pseudorandom_probability(card, 'paraquiet_poison', 1, card.ability.extra.odds, 'paraquiet') then
          card.ability.extra.my_mult = card.ability.extra.my_mult + card.ability.extra.mult_per
          returns[#returns + 1] = {
            message = localize("k_poisoned_ex"),
            colour = G.C.PURPLE,
            func = function()
              other_card:juice_up(0.5, 0.5)
              assert(SMODS.modify_rank(other_card, -1))
            end
          }
        end
      end
      return SMODS.merge_effects(returns)
    end
    if context.forcetrigger or context.joker_main then
      if card.ability.extra.my_mult ~= 0 then
        return {
          mult = card.ability.extra.my_mult
        }
      end
    end
  end,
  pronouns = "it_its"
}

SMODS.Joker {
  key = "e_supercharge",
  name = "Energy Supercharge",
  config = {
    extra = {
      active = true,
    }
  },
  pos = {x = 4, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = false,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not card.ability.extra.active then
      card.ability.extra.active = true
      return {
        message = localize("k_charged_ex")
      }
    end
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false

    local target_area = G.hand
    local suits = {"S", "H", "C", "D"}

    for _, _suit in ipairs(suits) do
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.4,
        func = function() 
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          local cards = {}
          cards[1] = true
          local _rank = nil
          _rank = pseudorandom_element({'A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K'}, pseudoseed('energysupercharge'))
          local cen_pool = {}
          for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
            if v.key ~= 'm_stone' and not v.overrides_base_rank then 
              cen_pool[#cen_pool+1] = v
            end
          end
          local card = create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('energysupercharge'))}, target_area, nil, i ~= 1, {G.C.PURPLE})
          card.ability.zero_temporary = true
          playing_card_joker_effects(cards)
          return true end }))
    end
    delay(0.5)
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
  key = "awesome_face",
  name = "Awesome Face",
  config = {
    extra = {
      active = true,
    }
  },
  pos = {x = 6, y = 0},
  atlas = "zero_jokers",
  rarity = 1,
  cost = 1,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  demicoloncompat = false,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false
    for i = 1,8 do
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.8 / (i + 3),
        func = function() 
          play_sound('chips1', 0.8 + i * 0.1)
          card:juice_up(0.3, 0.5)

          G.GAME.chips = G.GAME.chips + G.GAME.blind.chips / 10
          return true end }))
    end

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.7,
      func = function() 
        card:start_dissolve()
        return true end }))

    -- snippet taken from Magic the Jokering
    if not next(SMODS.find_mod("NotJustYet")) then
      G.E_MANAGER:add_event(Event({
      func = (function(t)
        if G.GAME.chips >= G.GAME.blind.chips then 
        G.E_MANAGER:add_event(
          Event({
            trigger = "immediate",
            func = function()
              if G.STATE ~= G.STATES.SELECTING_HAND then
                return false
              end
              G.STATE = G.STATES.HAND_PLAYED
              G.STATE_COMPLETE = true
              end_round()
              return true
            end,
          }),
          "other"
        )
      end
      return true end)
      }))
    end
  end,
}

local srh = save_run
save_run = function(self)
  local perma_monster_jokers = {}
  for i, card in ipairs(G.jokers.cards) do
    if card.config.center.key == "j_zero_perma_monster" then
      -- print("saving wow", i)
      perma_monster_jokers[i] = {}

      for _, copied_card in ipairs(card.ability.immutable.copied_jokers) do
        -- print(copied_card.config.center.key)
        perma_monster_jokers[i][#perma_monster_jokers[i] + 1] = copied_card:save()
      end
    end
  end

  G.GAME.zero_perma_monster_jokers = perma_monster_jokers

  srh(self)
end
local strh = Game.start_run
Game.start_run = function(self, args)
  strh(self, args)

  if G.GAME.zero_perma_monster_jokers then
    -- print("reinit")
    for i, cards in pairs(G.GAME.zero_perma_monster_jokers) do
      -- print(i)
      G.jokers.cards[i].ability.immutable.copied_jokers = {}
      for _, copied_card in pairs(cards) do
        local card = Card(0, 0, 1, 1, G.P_CENTERS.j_joker, G.P_CENTERS.c_base)
        card.T.x = math.huge
        card.T.y = math.huge
        card.T.H = 4 -- WTF ??
        card.T.h = 4
        card.T.w = 4
        card:load(copied_card)
        G.jokers.cards[i].ability.immutable.copied_jokers[#G.jokers.cards[i].ability.immutable.copied_jokers + 1] = card

        -- print(card.config.center.key)
      end
    end

    G.GAME.zero_perma_monster_jokers = nil
  end
end

SMODS.Joker {
  key = "perma_monster",
  name = "Perma Monster",
  config = {
    extra = {
      active = true,
    },
    immutable = {
      copied_jokers = {}
    }
  },
  pos = {x = 3, y = 0},
  atlas = "zero_jokers",
  rarity = 3,
  cost = 10,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  demicoloncompat = false,
  zero_usable = true,
  zero_stay_in_area = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
    return { vars = { #center.ability.immutable.copied_jokers } }
  end,
  calculate = function(self, card, context)
    local returns = {}

    if not context.no_blueprint then

      for _, copied in ipairs(card.ability.immutable.copied_jokers) do

        -- based on code from Maximus (bootlegger)
        context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
        context.blueprint_card = context.blueprint_card or card
        local ret = copied:calculate_joker(context)
        context.blueprint = nil
        local eff_card = context.blueprint_card or card
        context.blueprint_card = nil
        if ret then
          ret.card = eff_card
          ret.colour = G.C.YELLOW
          returns[#returns + 1] = ret
        end
      end

    end
    
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
      card.ability.extra.active = true
    end

    return SMODS.merge_effects(returns)
  end,
  use = function(self, card, area, copier)
    local my_pos = 0
    -- print("asdf", my_pos)
    if G.jokers.cards[my_pos+1] and not card.getting_sliced and
      not SMODS.is_eternal(G.jokers.cards[my_pos+1], card) and not G.jokers.cards[my_pos+1].getting_sliced and
      not (G.jokers.cards[my_pos+1].config.center.key == "j_zero_perma_monster") then

      local sliced_card = G.jokers.cards[my_pos+1]
      -- print(sliced_card)
      sliced_card.getting_sliced = true
      G.GAME.joker_buffer = G.GAME.joker_buffer - 1
      G.E_MANAGER:add_event(Event({func = function()
        G.GAME.joker_buffer = 0

        local copied_card = copy_card(sliced_card)
        copied_card.T.x = math.huge
        copied_card.T.y = math.huge

        card.ability.immutable.copied_jokers[#card.ability.immutable.copied_jokers + 1] = copied_card
        
        card:juice_up(0.8, 0.8)
        sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
        play_sound('slice1', 0.96+math.random()*0.08)
      return true end }))
      
      card.ability.extra.active = false
    end
    -- delay(0.5)
    -- print("wow")
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
  key = "elite_inferno",
  name = "Elite Inferno",
  config = {
    extra = {
      active = true,
      triggering = false,
      times_mult = 7,
    },
  },
  pos = {x = 5, y = 0},
  atlas = "zero_jokers",
  rarity = 3,
  cost = 9,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
    return { vars = { 
      center.ability.extra.triggering and "active" or "inactive",
      center.ability.extra.times_mult
    } }
  end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.triggering then
      return {
        x_mult = card.ability.extra.times_mult
      }
    end
    
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
      card.ability.extra.active = true
    end
    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      card.ability.extra.triggering = false
    end
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false
    card.ability.extra.triggering = true
    delay(0.5)
    -- print("wow")
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
  key = "defense_removal",
  name = "Defense Removal",
  config = {
    extra = {
      active = true,
    }
  },
  pos = {x = 8, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = false,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not card.ability.extra.active and G.GAME.blind.boss then
      card.ability.extra.active = true
      return {
        message = localize("k_charged_ex")
      }
    end
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false
    G.E_MANAGER:add_event(Event({
      trigger = 'before',
      delay = 0.8,
      func = function() 
        card:juice_up(0.3, 0.5)

        G.GAME.blind.chips = math.floor(G.GAME.blind.chips / 4)
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        return true end }))

    -- snippet taken from Magic the Jokering
    if not next(SMODS.find_mod("NotJustYet")) then
      G.E_MANAGER:add_event(Event({
      func = (function(t)
        if G.GAME.chips >= G.GAME.blind.chips then 
        G.E_MANAGER:add_event(
          Event({
            trigger = "immediate",
            func = function()
              if G.STATE ~= G.STATES.SELECTING_HAND then
                return false
              end
              G.STATE = G.STATES.HAND_PLAYED
              G.STATE_COMPLETE = true
              end_round()
              return true
            end,
          }),
          "other"
        )
      end
      return true end)
      }))
    end
    delay(0.5)
    -- print("wow")
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
  key = "dream_book",
  name = "Dream Book",
  config = {
    extra = {
      active = true,
      selected = false,
    }
  },
  pos = {x = 7, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = false,
  zero_usable = true,
  -- keep_on_use = true,
  can_use = function(self, card)
    return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
  end,
  loc_vars = function(self, info_queue, center)
  end,
  calculate = function(self, card, context)
    if context.end_of_round and not card.ability.extra.active and G.GAME.blind.boss then
      card.ability.extra.active = true
      return {
        message = localize("k_charged_ex")
      }
    end
    if context.end_of_round and card.ability.extra.selected then
      card.ability.extra.selected = false
      SMODS.change_play_limit(-1)
      SMODS.change_discard_limit(-1)
    end
  end,
  use = function(self, card, area, copier)
    card.ability.extra.active = false
    card.ability.extra.selected = true
    SMODS.change_play_limit(1)
    SMODS.change_discard_limit(1)

    local draw_count = #G.hand.cards
    
    SMODS.draw_cards(draw_count)

    delay(0.5)
    -- print("wow")
    draw_card(G.play, G.jokers, nil, 'up', nil, card)
  end,
}

SMODS.Joker {
	key = "cock_king",
	name = "Cockatrice King",
	config = {
		extra = {
		active = true,
		changed = false,
		h_size = 3,
		mult = 4
		}
	},
	pos = {x = 1, y = 1},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	zero_usable = true,
	can_use = function(self, card)
		return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.h_size } }
    end,
	calculate = function(self, card, context)
		if context.end_of_round then
			if card.ability.extra.changed and not context.blueprint then
				card.ability.extra.changed = false
				G.hand:change_size(-card.ability.extra.h_size)
			end
			if not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
				card.ability.extra.active = true
				return {
					message = localize("k_charged_ex")
				}
			end
		elseif context.individual and context.cardarea == G.hand then
            return {
                mult = card.ability.extra.mult
            }
        end
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		card.ability.extra.active = false
		card.ability.extra.changed = true
		G.hand:change_size(card.ability.extra.h_size)
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.changed then
			card.ability.extra.changed = false
			G.hand:change_size(-card.ability.extra.h_size)
		end
	end
}

SMODS.Joker {
	key = "poison_heal",
	name = "Poison Heal",
	config = {
		extra = {
		active = true,
		xchips = 1,
		xchips_mod = 3
		},
	},
	pos = {x = 2, y = 1},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	zero_usable = true,
	can_use = function(self, card)
		return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active and G.GAME.current_round.hands_left > 1
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips_mod, card.ability.extra.xchips } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
		return {
			xchips = card.ability.extra.xchips
		}
		end
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
			card.ability.extra.active = true
		end
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		card.ability.extra.active = false
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
		ease_hands_played(-1)
		card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_mod
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end,
}

SMODS.Joker {
	key = "stat_wipeout",
	name = "Stat Wipeout",
	config = { extra = {disables = 0, to_clear = 3 } },
	pos = {x = 4, y = 1},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	zero_usable = true,
	can_use = function(self, card)
		if G.hand and G.hand.highlighted and #G.hand.highlighted == math.floor(card.ability.extra.to_clear) then
			for k, v in pairs(G.hand.highlighted) do
				if v.ability.set ~= "Enhanced" then
					return false
				end
			end
			return true
		end
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.disables, card.ability.extra.disables == 1 and "" or "s", card.ability.extra.to_clear} }
	end,
	calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss and card.ability.extra.disables > 0 then
            card.ability.extra.disables = card.ability.extra.disables - 1
			G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.blind:disable()
                            play_sound('timpani')
                            delay(0.4)
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                    return true
                end
            }))
            return nil, true
        end
    end,
	use = function(self, card, area, copier)
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
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability('c_base');return true end }))
        end    
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
		card.ability.extra.disables = card.ability.extra.disables + 1
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end,
}

SMODS.Joker {
	key = "holy_symbol",
	name = "Holy Symbol",
	config = {
		extra = { active = false, xchips = 1.5, rounds = 3 }
	},
	pos = {x = 3, y = 1},
	atlas = "zero_jokers",
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	zero_usable = true,
	can_use = function(self, card)
		return true
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips, card.ability.extra.rounds, card.ability.extra.active and "A" or "Not a" } }
    end,
	calculate = function(self, card, context)
        if context.other_joker and card.ability.extra.active then
            return {
                xchips = card.ability.extra.xchips
            }
        end
		if context.end_of_round and not context.individual and not context.repetition and card.ability.extra.active and not context.blueprint then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds == 1 then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
			if card.ability.extra.rounds == 0 then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = localize('k_consumed_ex')
				}
			else
				return {
					message = card.ability.extra.rounds .. "!"
				}
			end
		end
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		card.ability.extra.active = true
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end
}

SMODS.Joker {
	key = "brilliance",
	name = "Brilliance",
	config = {
		extra = {
			xmult = 1.5,
			dollars = 3,
		}
	},
	pos = {x = 9, y = 4},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_gold
		info_queue[#info_queue+1] = G.P_CENTERS.m_steel
		return { vars = {
			card.ability.extra.xmult,
			card.ability.extra.dollars
		}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.end_of_round then
			local ret = {}
			local function appendextra(tbl, _ret)
				if not tbl.extra then tbl.extra = _ret else
				appendextra(tbl.extra, _ret) end
			end
			if SMODS.has_enhancement(context.other_card,"m_gold") then
				appendextra(ret, {
					xmult = card.ability.extra.xmult,
				})
			end
			if SMODS.has_enhancement(context.other_card,"m_steel") then
				appendextra(ret, {
					dollars = card.ability.extra.dollars,
				})
			end
			if ret.extra then return ret.extra end
		end
	end,
	in_pool = function(self)
		for k,v in ipairs(G.playing_cards) do
			if SMODS.has_enhancement(v,"m_gold") or SMODS.has_enhancement(v,"m_steel") then
				return true
			end
		end
	end,
}

SMODS.Joker {
	key = "dragonsthorn",
	name = "Dragonsthorn",
	config = {
		extra = {
			xmult_mod = 0.05,
		}
	},
	pos = {x = 8, y = 4},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_zero_sunsteel
		local count = 0
		if G.deck then
			for k,v in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(v, "m_zero_sunsteel") then
					count = count + 1
				end
			end
		end
		return { vars = {
			card.ability.extra.xmult_mod + (G.GAME.zero_sunsteel_pow or 0),
			1 + ((card.ability.extra.xmult_mod + (G.GAME.zero_sunsteel_pow or 0)) * count)
		}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.end_of_round and SMODS.has_enhancement(context.other_card, "m_zero_sunsteel") then
			local count = 0
			for k,v in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(v, "m_zero_sunsteel") then
					count = count + 1
				end
			end
			if count > 1 then -- idk
				return { xmult = 1 + ((card.ability.extra.xmult_mod + (G.GAME.zero_sunsteel_pow or 0)) * count) }
			end
		end
	end,
	enhancement_gate = "m_zero_sunsteel",
	pronouns = "she_her"
}

SMODS.Joker {
  key = "dismantled_cube",
  pos = {x = 1, y = 0},
  atlas = "zero_jokers",
  rarity = 2,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
}

SMODS.Joker {
	key = "venture_card",
	name = "Venture Card",
	config = {
		extra = {
		}
	},
	pos = {x = 5, y = 4},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_zero_suit_yourself
    end,
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            local sy_card = SMODS.create_card { set = "Base", enhancement = "m_zero_suit_yourself", area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            sy_card.playing_card = G.playing_card
            table.insert(G.playing_cards, sy_card)
			sy_card.states.visible = false

            G.E_MANAGER:add_event(Event({
                func = function()
                    G.play:emplace(sy_card)
					sy_card.states.visible = true
                    sy_card:start_materialize({ G.C.SUITS.Spades, G.C.SUITS.Hearts, G.C.SUITS.Clubs, G.C.SUITS.Diamonds })
                    return true
                end
            }))
            return {
                message = localize('k_plus_suit_yourself'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function()
                    G.E_MANAGER:add_event(Event({
						trigger = "after",
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
							draw_card(G.play, G.deck, 100, 'up', nil, sy_card)
							SMODS.calculate_context({ playing_card_added = true, cards = { sy_card } })
                            return true
                        end
                    }))
                end
            }
        end
    end,
	pronouns = "any_all"
}

SMODS.Joker {
	key = "alpine_lily",
	name = "Alpine Lily",
	config = {
		extra = {
			odds = {
				new_effect = 3,
				lose_effect = 3,
				change_effect = 5,
				gain_value = 12,
				lose_value = 8,
				nothing = 1,
				plus_mutation = 2,
				minus_mutation = 1,
			},
			min_new_value = 1,
			max_new_value = 10,
			min_gain_value = 1,
			max_gain_value = 15,
			min_lose_value = 1,
			max_lose_value = 10,
			mutations_per_round = 1,
			mutations = {
				{ effect = "mult", value = 4 },
			}
		}
	},
	pos = {x = 0, y = 1},
	atlas = "zero_jokers",
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	
	blueprint_compat = true,
	
	-- Alright buckle up because this is where it gets weird
	
	mutation_effects = {
		mult = {
			calculate = function(self, card, value)
				return {
					mult = value * 1
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { value * 1 } }
			end,
		},
		chips = {
			calculate = function(self, card, value)
				return {
					chips = value * 5
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { value * 5 } }
			end,
		},
		xmult = {
			calculate = function(self, card, value)
				return {
					xmult = 1 + (value * 0.025)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { 1 + (value * 0.025) } }
			end,
		},
		xchips = {
			calculate = function(self, card, value)
				return {
					xchips = 1 + (value * 0.025)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { 1 + (value * 0.025) } }
			end,
		},
		dollars = {
			calculate = function(self, card, value)
				return {
					dollars = math.floor(value * 0.4)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { math.floor(value * 0.4) } }
			end,
		},
	},	
	--moved list_mutation_effects and create_mutation to funcs.lua for broader use
    loc_vars = function(self, info_queue, card)
        local main_end = {
		}
		for _, mutation in ipairs(card.ability.extra.mutations) do
			local mutation_effect = self.mutation_effects[mutation.effect]
			local vars = {}
			if type(mutation_effect.loc_vars) == "function" then
				vars = mutation_effect:loc_vars(card, mutation.value).vars
			end
			
			local desc_node = {}
			localize {type = 'descriptions',
				key = "j_zero_alpine_lily_" .. mutation.effect,
				set = 'Joker',
				nodes = desc_node,
				scale = 1,
				text_colour = G.C.UI.TEXT_DARK,
				vars = vars
			} 
			desc_node = desc_from_rows(desc_node,true)
			--desc node should contains the text nodes now
			
			desc_node.config.minh = 0
			desc_node.config.padding = 0
			desc_node.config.r = 0
			
			--print(inspect(desc_node.config))
			
			main_end[#main_end+1] = desc_node
		end
		return {vars = {
			card.ability.extra.mutations_per_round,
			card.ability.extra.mutations_per_round == 1 and "" or "s",
		}, main_end = main_end}
    end,
	
	calculate = function(self, card, context)
		local function append_extra(_ret, append)
		if _ret.extra then return append_extra(_ret.extra, append) end
		_ret.extra = append
		return _ret
		end
		
		if context.joker_main then
		local ret = {}
		for _,mutation in ipairs(card.ability.extra.mutations) do
			local mutation_effect = self.mutation_effects[mutation.effect]
			if type(mutation_effect.calculate) == "function" then
			append_extra(ret, mutation_effect:calculate(card, mutation.value))
			end
		end
		if ret.extra then return ret.extra end
		end
		
		if not context.blueprint and ((context.end_of_round and not context.game_over and context.cardarea == G.jokers) or context.forcetrigger) then
		if not card.ability.extra.mutations or #card.ability.extra.mutations == 0 then
			card.ability.extra.mutations = {{ effect = "mult", value = 4 }}
		end
		local ret = {}
		local repeats = card.ability.extra.mutations_per_round
		for iii = 1, repeats do
			local odds_list = {
			"new_effect",
			"lose_effect",
			"change_effect",
			"gain_value",
			"lose_value",
			"nothing",
			"plus_mutation",
			"minus_mutation",
			}
			local max_odds = 0
			local _lost = 1
			local _lostmut = 1
			for k,v in ipairs(odds_list) do max_odds = max_odds + card.ability.extra.odds[v] end
			local roll = pseudorandom("zero_alpine_lily_eor", 1, max_odds)
		
			local function pick_unmarked_for_removal(tag)
			local candidates = {}
			for i = 1, #card.ability.extra.mutations do
				local m = card.ability.extra.mutations[i]
				if m and not m._scheduled_for_removal then
				candidates[#candidates + 1] = m
				end
			end
			if #candidates == 0 then return nil end
			local idx = pseudorandom(tag, 1, #candidates)
			local target = candidates[idx]
			target._scheduled_for_removal = true
			return target
			end
		
			for k,v in ipairs(odds_list) do
			if roll <= card.ability.extra.odds[v] then
				if v == "new_effect" or (#card.ability.extra.mutations == _lost and v == "lose_effect") then
				if _lost > 1 then
					_lost = _lost - 1
				end
				append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
					func = function()
						zero_create_mutation(self, card)
					end,
					message = localize("k_new_effect_ex")
					},
				})
				elseif v == "lose_effect" then
				_lost = _lost + 1
				do
					local target = pick_unmarked_for_removal("zero_alpine_lily_lose_effect")
					append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
						func = function()
						if not target then return end
						for i = 1, #card.ability.extra.mutations do
							if card.ability.extra.mutations[i] == target then
							table.remove(card.ability.extra.mutations, i)
							target._scheduled_for_removal = nil
							return
							end
						end
						target._scheduled_for_removal = nil
						end,
						message = localize("k_lose_effect_ex")
					},
					})
				end
				elseif v == "change_effect" then
				do
					local count = #card.ability.extra.mutations
					local idx = 1
					if count > 0 then
					idx = pseudorandom("zero_alpine_lily_change_effect", 1, count)
					end
					local target = card.ability.extra.mutations[idx]
					local new_effect = pseudorandom_element(zero_list_mutation_effects(self), "zero_alpine_lily_change_mutation")
					append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
						func = function()
						if not target then return end
						target.effect = new_effect
						end,
						message = localize("k_change_effect_ex")
					},
					})
				end
				elseif v == "gain_value" then
				do
					local count = #card.ability.extra.mutations
					local idx = 1
					if count > 0 then
					idx = pseudorandom("zero_alpine_lily_gain_value_effect", 1, count)
					end
					local target = card.ability.extra.mutations[idx]
					local delta = pseudorandom("zero_alpine_lily_gain_value", card.ability.extra.min_gain_value, card.ability.extra.max_gain_value)
					append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
						func = function()
						if not target then return end
						target.value = target.value + delta
						end,
						message = localize("k_gain_value_ex")
					},
					})
				end
				elseif v == "lose_value" then
				do
					local count = #card.ability.extra.mutations
					local idx = 1
					if count > 0 then
					idx = pseudorandom("zero_alpine_lily_lose_value_effect", 1, count)
					end
					local target = card.ability.extra.mutations[idx]
					local delta = pseudorandom("zero_alpine_lily_lose_value", card.ability.extra.min_lose_value, card.ability.extra.max_lose_value)
					append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
						func = function()
						if not target then return end
						target.value = math.max(0, target.value - delta)
						end,
						message = localize("k_lose_value_ex")
					},
					})
				end
				elseif v == "nothing" then
				append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
					message = localize("k_nothing_ex")
					},
				})
				elseif v == "plus_mutation" or (card.ability.extra.mutations_per_round <= _lostmut and v == "minus_mutation") then
				if _lostmut > 1 then
					_lostmut = _lost - 1
				end
				append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
					func = function()
						card.ability.extra.mutations_per_round = card.ability.extra.mutations_per_round + 1
					end,
					message = localize("k_plus_mutation_ex")
					},
				})
				elseif v == "minus_mutation" then
				_lostmut = _lostmut + 1
				append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
					func = function()
						card.ability.extra.mutations_per_round = card.ability.extra.mutations_per_round - 1
					end,
					message = localize("k_minus_mutation_ex")
					},
				})
				end
		
				break
			else
				roll = roll - card.ability.extra.odds[v]
			end
			end
		end
		if ret.extra then return ret.extra end
		end
	end
}

SMODS.Joker {
    key = "despondent_joker",
	atlas = "zero_jokers",
    pos = { x = 0, y = 7 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
	unlocked = true,
	discovered = true,
    config = { extra = { mult = 5, suit = 'zero_Brights'}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.suit, 'suits_singular'), colours = {G.C.SUITS[card.ability.extra.suit] } } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit(card.ability.extra.suit) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
	in_pool = function(self, args)
		 return zero_brights_in_deck()
	end
}

SMODS.Joker {
    key = "star_sapphire",
	atlas = "zero_jokers",
    pos = { x = 1, y = 7 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
	unlocked = true,
	discovered = true,
    config = { extra = { money = 1, xmult = 1.5, mult = 7, chips = 50, suit = 'zero_Brights'}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_singular'), card.ability.extra.money, card.ability.extra.xmult, card.ability.extra.chips, card.ability.extra.mult, colours = {G.C.SUITS[card.ability.extra.suit] }, } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:is_suit(card.ability.extra.suit) then
			local allrets = {
				dollars = card.ability.extra.money,
				xmult = card.ability.extra.xmult,
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult
			}
			local keys = {}
			for k in pairs(allrets) do
				table.insert(keys, k)
			end
			local randomret = pseudorandom_element(keys)
            return {
                [randomret] = allrets[randomret]
            }
        end
    end,
	in_pool = function(self, args)
		 return zero_brights_in_deck()
	end,
}

SMODS.Joker {
    key = "konpeito",
	atlas = "zero_jokers",
    pos = { x = 2, y = 7 },
    rarity = 2,
    blueprint_compat = false,
	eternal_compat = false,
    cost = 5,
	pools = { Food = true },
	unlocked = true,
	discovered = true,
    config = { extra = { suit = 'zero_Brights'}, },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit] }, } }
    end,
    calculate = function(self, card, context)
        if context.before and #context.scoring_hand == 5 and not context.blueprint then
			for i = 1, #context.scoring_hand do
				SMODS.change_base(context.scoring_hand[i], card.ability.extra.suit, nil, true)
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() context.scoring_hand[i]:flip(); play_sound('card1', 1); context.scoring_hand[i]:juice_up(0.3, 0.3) return true end }))
			end
			delay(0.2)
			for i = 1, #context.scoring_hand do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() context.scoring_hand[i]:set_sprites(context.scoring_hand[i].config.center, context.scoring_hand[i].config.card)  return true end }))
			end
			for i = 1, #context.scoring_hand do
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() context.scoring_hand[i]:flip(); play_sound('card1', 1); context.scoring_hand[i]:juice_up(0.3, 0.3) return true end }))
			end
			SMODS.destroy_cards(card, nil, nil, true)
            return {
				message = localize('k_eaten_ex'),
            }
		end
    end,
}

SMODS.Joker {
    key = "mirror_shard",
	atlas = "zero_jokers",
    pos = { x = 5, y = 5 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
    config = { extra = { suit = 'zero_Brights'}, },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { localize(card.ability.extra.suit, 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit] }, } }
    end,
    calculate = function(self, card, context)
		if context.repetition and (context.cardarea == G.play or context.cardarea == G.hand) then
			local returns = {}
			for i = 1, #context.cardarea.cards do
				if context.other_card == context.cardarea.cards[i] then
					if context.cardarea.cards[i-1] and SMODS.has_enhancement(context.cardarea.cards[i-1], 'm_glass') and not context.cardarea.cards[i-1].debuff then
						returns[#returns+1] = {
							repetitions = 1,
							message = localize('k_again_ex'),
							message_card  = context.cardarea.cards[i-1]
						}
					end
					if context.cardarea.cards[i+1] and SMODS.has_enhancement(context.cardarea.cards[i+1], 'm_glass') and not context.cardarea.cards[i+1].debuff  then
						returns[#returns+1] = {
							repetitions = 1,
							message = localize('k_again_ex'),
							message_card  = context.cardarea.cards[i+1]
						}
					end
				end
			end
            if #returns > 0 then
                return SMODS.merge_effects(returns)
            end
        end
    end,
	pronouns = "mirror"
}

SMODS.Joker {
    key = "queen_sigma",
	atlas = "zero_jokers",
    pos = { x = 2, y = 6 },
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
	unlocked = true,
	discovered = true,
    config = { extra = { total = 150, discovered = 1}, },
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
		local vanilla_count = 0
		local discover_vanilla_count = 0
		for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if not v.original_mod then
				vanilla_count = vanilla_count + 1
				if v.discovered == true then
					discover_vanilla_count = discover_vanilla_count + 1
				end
			end
		end
		card.ability.extra.total = vanilla_count
		card.ability.extra.discovered = discover_vanilla_count
        return { vars = { card.ability.extra.total, card.ability.extra.discovered * G.GAME.probabilities.normal } }
    end,
	set_ability = function(self, card, initial, delay_sprites)
		local vanilla_count = 0
		local discover_vanilla_count = 0
		for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if not v.original_mod then
				vanilla_count = vanilla_count + 1
				if v.discovered == true then
					discover_vanilla_count = discover_vanilla_count + 1
				end
			end
		end
		card.ability.extra.total = vanilla_count
		card.ability.extra.discovered = discover_vanilla_count
    end,
    calculate = function(self, card, context)
		if context.before and context.cardarea == G.jokers then
			local vanilla_count = 0
			local discover_vanilla_count = 0
			for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
				if not v.original_mod then
					vanilla_count = vanilla_count + 1
					if v.discovered == true then
						discover_vanilla_count = discover_vanilla_count + 1
					end
				end
			end
			card.ability.extra.total = vanilla_count
			card.ability.extra.discovered = discover_vanilla_count
		end
        if ((context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 or context.forcetrigger) and (context.other_card:is_suit("Clubs") or #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit)) and pseudorandom('queen_sigma') < card.ability.extra.discovered * G.GAME.probabilities.normal / card.ability.extra.total then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				local _negative = false
				if context.other_card:is_suit("Clubs") then
					_negative = true
				end
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
					local _Tarot = create_card('Tarot', G.consumeables, nil, nil, nil, true)
					if _negative == true then
						_Tarot:set_edition("e_negative", true)
					end
					_Tarot:add_to_deck()
					G.consumeables:emplace(_Tarot)
					G.GAME.consumeable_buffer = 0
				return true end }))
			return {
                message = localize('k_plus_tarot'),
            }
        end
    end,
	pronouns = "she_her"
}

SMODS.Joker {
    key = "he_has_a_gun",
	atlas = "zero_jokers",
    pos = { x = 8, y = 1 },
	soul_pos = { x = 9, y = 1 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
	unlocked = true,
	discovered = true,
    config = { extra = { limit = 0, odds = 2, money = 3}, },
    loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
		if context.hand_drawn then
		local count = 0
			for _, v in pairs(G.hand.cards) do
				if v.base.value == "7" then
					count = count + 1
					if not context.blueprint then
						v.ability.forced_selection = true
						G.hand:add_to_highlighted(v)
					end
				end
			end
			if count ~= card.ability.extra.limit then
				SMODS.change_play_limit(-card.ability.extra.limit + count)
				SMODS.change_discard_limit(-card.ability.extra.limit + count)
				card.ability.extra.limit = count
			end
		end
		if context.individual and context.cardarea == G.play and context.other_card.base.value == "7" and pseudorandom('he_has_a_gun') < G.GAME.probabilities.normal / card.ability.extra.odds then
			return {
				dollars = card.ability.extra.money
			}
		end
    end,
	pronouns = "he_him"
}

SMODS.Joker {
    key = "lockout",
	atlas = "zero_jokers",
    pos = { x = 4, y = 4 },
    rarity = 1,
    blueprint_compat = false,
    cost = 4,
	unlocked = true,
	discovered = true,
	config = { extra = { uses = 3, current_uses = 3, used = false}, },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.current_uses, card.ability.extra.uses } }
    end,
    calculate = function(self, card, context)
		if context.blueprint then return end
		if context.hand_drawn or context.forcetrigger then
			if (card.ability.extra.current_uses > 0 and G.FUNCS.get_poker_hand_info(G.hand.cards) == "High Card") or context.forcetrigger then
				if card.ability.extra.used == false then
					SMODS.calculate_effect({
						message = localize('k_impossible_ex')
					}, card)	
				end
				for _, v in pairs(G.hand.cards) do
					draw_card(G.hand, G.deck, nil, nil, nil, v)
					G.deck:shuffle()
				end
				card.ability.extra.current_uses = card.ability.extra.current_uses - 1
				card.ability.extra.used = true
			elseif card.ability.extra.used == true then
				card.ability.extra.used = false
				return {
					message = card.ability.extra.current_uses .. "/" .. card.ability.extra.uses
				}
			end
		end
		if context.end_of_round and context.main_eval then
			card.ability.extra.current_uses = card.ability.extra.uses
		end
    end
}

SMODS.Joker {
    key = "female_symbol", --this code is 25% functional stuff and 75% bells and whistles
	atlas = "zero_jokers",
    pos = { x = 4, y = 6 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
	config = { extra = { money = 1, xmult = 0.2, mult = 2, chips = 10, xchips = 0.2, retriggers = 1}, },
	loc_vars = function(self, info_queue, card)
		local randomjoker = G.P_CENTER_POOLS["Joker"][math.random(1, #G.P_CENTER_POOLS["Joker"])]
		if not randomjoker.generate_ui then
			info_queue[#info_queue+1] = randomjoker.key and randomjoker or nil
		else
			info_queue[#info_queue+1] = {key = "jhsuhfuiashiunonenonenone", set = "Other"}
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 then
			local random_sound_effs = {
				"button",
				"cancel",
				"card1",
				"card3",
				"cardFan2",
				"cardSlide1",
				"cardSlide2",
				"chips1",
				"chips2",
				"coin1",
				"coin2",
				"coin3",
				"coin4",
				"coin5",
				"coin6",
				"coin7",
				"crumple1",
				"crumple2",
				"crumple3",
				"crumple4",
				"crumple5",
				"crumpleLong1",
				"crumpleLong2",
				"crumpleLong2",
				"foil1",
				"foil2",
				"generic1",
				"glass1",
				"glass2",
				"glass3",
				"glass4",
				"glass5",
				"glass6",
				"gold_seal",
				"gong",
				"highlight1",
				"highlight2",
				"holo1",
				"magic_crumple",
				"magic_crumple2",
				"magic_crumple3",
				"multhit1",
				"multhit2",
				"negative",
				"other1",
				"paper1",
				"polychrome1",
				"slice1",
				"tarot1",
				"tarot2",
				"timpani",
				"whoosh",
				"whoosh1",
				"whoosh2",
				"zero_galasfx"
			}
			local bonuses = {
				["perma_p_dollars"] = card.ability.extra.money,
				["perma_x_mult"] = card.ability.extra.xmult,
				["perma_bonus"] = card.ability.extra.chips,
				["perma_mult"] = card.ability.extra.mult,
				["perma_x_chips"] = card.ability.extra.xchips,
				["perma_h_x_mult"] = card.ability.extra.xmult,
				["perma_h_chips"] = card.ability.extra.chips,
				["perma_h_mult"] = card.ability.extra.mult,
				["perma_h_x_chips"] = card.ability.extra.xchips,
				["perma_h_dollars"] = card.ability.extra.money,
				["perma_repetitions"] = card.ability.extra.retriggers
			}
			local keys = {}
			for k in pairs(bonuses) do
				table.insert(keys, k)
			end
			local randombonus = pseudorandom_element(keys)
			context.other_card.ability[randombonus] = context.other_card.ability[randombonus] or 1
			context.other_card.ability[randombonus] = context.other_card.ability[randombonus] + bonuses[randombonus]
			local punctuations = {".", ",", ";", ":", "!", "?", "-", "_", "(", ")", "[", "]", "{", "}", "@", "#", "$", "%", "&", "*", "\"", "\'"}
			return {
				message = localize('k_upgrade_ex'):sub(1, -2) .. punctuations[math.random(1, #punctuations)],
				sound = pseudorandom_element(random_sound_effs)
			}
		end
    end,
	zero_glitch = true,
	pronouns = "she_her"
}

SMODS.Joker {
    key = "key_he4rt",
    atlas = "zero_jokers",
    pos = { x = 9, y = 0 },
    rarity = 2,
    blueprint_compat = false,
    cost = 4,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS['m_zero_l0ck']
        info_queue[#info_queue+1] = G.P_CENTERS['m_zero_k3y']
    end,
    add_to_deck = function(self, card, from_debuff)
        for _, v in pairs(G.playing_cards) do
            if v.config.center and (v.config.center == G.P_CENTERS.m_zero_k3y or v.config.center == G.P_CENTERS.m_zero_l0ck) then
                return
            end
        end
        local l0ck_card = create_card("Base", G.play, nil, nil, nil, nil, nil, "zero_l0ck")
        l0ck_card:set_ability(G.P_CENTERS.m_zero_l0ck)
        G.play:emplace(l0ck_card)
        table.insert(G.playing_cards, l0ck_card)
        
        local k3y_card = create_card("Base", G.play, nil, nil, nil, nil, nil, "zero_k3y")
        k3y_card:set_ability(G.P_CENTERS.m_zero_k3y)
        G.play:emplace(k3y_card)
        table.insert(G.playing_cards, k3y_card)
        for _, v in pairs(G.play.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
                draw_card(G.play, G.deck, nil, nil, nil, v)
                G.deck:shuffle()
            return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.5, blocking = false, func = function()
            G.deck:shuffle()
        return true end }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, v in pairs(G.jokers.cards) do
            if v.config.center and v.config.center.key == "j_zero_key_he4rt" and v ~= card then
                return
            end
        end
        for _, v in pairs(G.playing_cards) do
            if v.config.center and (v.config.center == G.P_CENTERS.m_zero_l0ck or v.config.center == G.P_CENTERS.m_zero_k3y) then
                v:start_dissolve("override")
            end
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local found_l0ck = false
            local found_k3y = false
            for _, v in pairs(G.playing_cards) do
                if v.config.center and v.config.center == G.P_CENTERS.m_zero_l0ck then
                    found_l0ck = true
                elseif v.config.center and v.config.center == G.P_CENTERS.m_zero_k3y then
                    found_k3y = true
                end
            end
            if found_l0ck == false then
                local l0ck_card = create_card("Base", G.deck, nil, nil, nil, nil, nil, "zero_l0ck")
                l0ck_card:set_ability(G.P_CENTERS.m_zero_l0ck)
                G.deck:emplace(l0ck_card)
                table.insert(G.playing_cards, l0ck_card)
            end
            if found_k3y == false then
                local k3y_card = create_card("Base", G.deck, nil, nil, nil, nil, nil, "zero_k3y")
                k3y_card:set_ability(G.P_CENTERS.m_zero_k3y)
                G.deck:emplace(k3y_card)
                table.insert(G.playing_cards, k3y_card)
            end
        end
    end
}

SMODS.Joker {
    key = "hater",
	atlas = "zero_jokers",
    pos = { x = 0, y = 4 },
    rarity = 1,
    blueprint_compat = true,
	demicoloncompat = true,
    cost = 4,
	unlocked = true,
	discovered = true,
	config = { extra = { chips = 0, max = 50 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.max } }
    end,
    calculate = function(self, card, context)
		if context.before or context.forcetrigger and not context.blueprint then
			local _upgrade = 0
			for _, v in pairs(G.jokers.cards) do
				_upgrade = _upgrade + v.sell_cost
			end
			if _upgrade ~= 0 then
				card.ability.extra.chips = card.ability.extra.chips + math.min(_upgrade, card.ability.extra.max)
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS,
				}
			end
		end
		if (context.joker_main or context.forcetrigger) and card.ability.extra.chips ~= 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
	pronouns = "he_they"
}

SMODS.Joker {
    key = "valdi",
	atlas = "zero_jokers",
    pos = { x = 0, y = 6 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		local cd_dur = G.GAME.PrestigeCooldowns and G.GAME.PrestigeCooldowns["j_zero_valdi"] or 1
		local cur_cd = G.GAME.Prestiges["j_zero_valdi"]
		local main_end
		if card.area and card.area == G.jokers then
			local other_joker
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card and G.jokers.cards[i - 1] then other_joker = G.jokers.cards[i - 1] end
			end
			local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
			main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
							nodes = {
								{ n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
							}
						}
					}
				}
			}
		end
		local ret
		if cur_cd ~= nil then
			info_queue[#info_queue+1] = { key = "valdi_effect", set="Other" }
			ret = {
				key = self.key.."_cd",
				vars = {
				G.GAME.Valdi_power or 0,
				(G.GAME.Valdi_power == 1) and "" or "s",
				cur_cd,
				(cur_cd == 1) and "" or "s"
				},
			}
		else
			info_queue[#info_queue+1] = { key = "cooldown_explainer", set="Other", specific_vars = {"any Prestige", cd_dur } }
			ret = {vars = { 
			G.GAME.Valdi_power or 0,
			(G.GAME.Valdi_power == 1) and "" or "s",
			cd_dur, 
			},}
		end
		if main_end then
			ret["main_end"] = main_end
		end
		return ret
    end,
    calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Prestige" then
            G.GAME.Valdi_power = G.GAME.Valdi_power or 0
			local works = cooldown_keyword(card, "j_zero_valdi")
			if works then
				G.GAME.Valdi_power = G.GAME.Valdi_power + 1
				return {
					message = localize('k_upgrade_ex')
				}
			end
        end
		if card.area and card.area == G.jokers and G.GAME.Valdi_power and G.GAME.Valdi_power > 0 then
            local other_joker
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card and G.jokers.cards[i - 1] then other_joker = G.jokers.cards[i - 1] end
            end
			local effects = {}
			for i = 1, G.GAME.Valdi_power do
				effects[#effects+1] = SMODS.blueprint_effect(card, other_joker, context)
			end
			if #effects > 0 then
				return SMODS.merge_effects(effects)
			end
		end
    end
}

SMODS.Joker {
    key = "4_h",
	atlas = "zero_jokers",
    pos = { x = 5, y = 6 },
    rarity = 1,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
	config = { choice = 1, rank = 9, extra = {
	{mult = 10},
	{chips = 50},
	{xmult = 1.5},
	{dollars = 1},
	{swap = true, message = "localizeswap"},
	{balance = true}
	}},
	loc_vars = function(self, info_queue, card)
		for k, v in pairs(card.ability.extra[card.ability.choice]) do
			return { vars = { card.ability.rank, v } }
		end
    end,
	set_ability = function(self, card, initial, delay_sprites)
        card.ability.choice = pseudorandom("4_h", 1, #card.ability.extra)
    end,
    calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play and context.other_card:get_id() == card.ability.rank) or context.forcetrigger then
            local ret = {}
			local val
			for k, v in pairs(card.ability.extra[card.ability.choice]) do
				if v == "localizeswap" then
					val = localize('k_swap_ex')
				else
					val = v
				end
				ret[k] = val
			end
			card.ability.choice = pseudorandom("4_h", 1, #card.ability.extra)
			return ret
        end
    end,
	zero_glitch = true
}

SMODS.Joker {
    key = "prestige_tree",
	atlas = "zero_jokers",
    pos = { x = 1, y = 6 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
	unlocked = true,
	discovered = true,
	config = { extra = { odds = 3, chips = 5, mult = 1 }},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal, card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			local rets = {}
			rets[1] = {
                chips = card.ability.extra.chips
            }
			rets[2] = {
                mult = card.ability.extra.mult
            }
            return SMODS.merge_effects(rets)
        end
		if ((context.using_consumeable and context.consumeable.ability.set == "Prestige") or context.forcetrigger) and pseudorandom('prestige_tree') < G.GAME.probabilities.normal / card.ability.extra.odds and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
			trigger = 'before',
			delay = 0.0,
			func = (function()
				local card = create_card('Prestige',G.consumeables, nil, nil, nil, nil, nil, 'prestige_tree')
				card:add_to_deck()
				G.consumeables:emplace(card)
				G.GAME.consumeable_buffer = 0
				return true
			end)}))
			if G.GAME.probabilities.normal >= card.ability.extra.odds then
				card.ability.extra.odds = card.ability.extra.odds * 2
			end
			return {
			message = localize('k_plus_prestige'),
			colour = G.C.SECONDARY_SET.Spectral,
			card = card
			}
		end
    end
}

SMODS.Joker {
	key = "ankimo", --Alpine Lily but with different mutation conditions
	config = {
		extra = {
			odds = {
				new_effect = 3,
				lose_effect = 3,
				change_effect = 5,
				gain_value = 12,
				lose_value = 8,
				nothing = 1,
				plus_mutation = 2,
				minus_mutation = 1,
			},
			min_new_value = 1,
			max_new_value = 10,
			min_gain_value = 1,
			max_gain_value = 15,
			min_lose_value = 1,
			max_lose_value = 10,
			mutations_per_round = 1,
			mutations = {
				{ effect = "mult", value = 4 },
			}
		}
	},
	pos = {x = 7, y = 4},
	atlas = "zero_jokers",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	eternal_compat = true,
	perishable_compat = true,
	demicoloncompat = true,
	
	blueprint_compat = true,
	
	mutation_effects = {
		mult = {
			calculate = function(self, card, value)
				return {
					mult = value * 1
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { value * 1 } }
			end,
		},
		chips = {
			calculate = function(self, card, value)
				return {
					chips = value * 5
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { value * 5 } }
			end,
		},
		xmult = {
			calculate = function(self, card, value)
				return {
					xmult = 1 + (value * 0.025)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { 1 + (value * 0.025) } }
			end,
		},
		xchips = {
			calculate = function(self, card, value)
				return {
					xchips = 1 + (value * 0.025)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { 1 + (value * 0.025) } }
			end,
		},
		dollars = {
			calculate = function(self, card, value)
				return {
					dollars = math.floor(value * 0.4)
				}
			end,
			loc_vars = function(self, card, value)
				return { vars = { math.floor(value * 0.4) } }
			end,
		},
	},	
    loc_vars = function(self, info_queue, card)
        local main_end = {
		}
		for _, mutation in ipairs(card.ability.extra.mutations) do
			local mutation_effect = self.mutation_effects[mutation.effect]
			local vars = {}
			if type(mutation_effect.loc_vars) == "function" then
				vars = mutation_effect:loc_vars(card, mutation.value).vars
			end
			
			local desc_node = {}
			localize {type = 'descriptions',
				key = "j_zero_alpine_lily_" .. mutation.effect,
				set = 'Joker',
				nodes = desc_node,
				scale = 1,
				text_colour = G.C.UI.TEXT_DARK,
				vars = vars
			} 
			desc_node = desc_from_rows(desc_node,true)
			desc_node.config.minh = 0
			desc_node.config.padding = 0
			desc_node.config.r = 0
			main_end[#main_end+1] = desc_node
		end
		local validhands = {}
		local maxlevel = -math.huge
		local besthands
		for k, v in pairs(G.GAME.hands) do
			if v.level > maxlevel then
				maxlevel = v.level
				validhands = {k}
			elseif v.level == maxlevel then
				validhands[#validhands+1] = k
			end
		end
		if maxlevel <= 1 then
			besthands = localize("k_ankimo_nil")
		elseif #validhands == 1 then
			besthands = validhands[1] .. localize("k_ankimo_one")
		elseif #validhands == 2 then
			besthands = validhands[1] .. localize("k_ankimo_two_1") .. validhands[2] .. localize("k_ankimo_two_2")
		else
			besthands = localize("k_ankimo_multiple")
		end
		return {vars = {
			card.ability.extra.mutations_per_round,
			card.ability.extra.mutations_per_round == 1 and "" or "s",
			besthands
		}, main_end = main_end}
    end,
	
	calculate = function(self, card, context)
		local function append_extra(_ret, append)
			if _ret.extra then return append_extra(_ret.extra, append) end
			_ret.extra = append
			return _ret
		end
		
		if context.joker_main then
			local ret = {}
			for _,mutation in ipairs(card.ability.extra.mutations) do
			local mutation_effect = self.mutation_effects[mutation.effect]
			if type(mutation_effect.calculate) == "function" then
				append_extra(ret, mutation_effect:calculate(card, mutation.value))
			end
			end
			if ret.extra then return ret.extra end
		end
		
		if not context.blueprint and ((context.individual and context.cardarea == G.play) or context.forcetrigger) then
			if not card.ability.extra.mutations or #card.ability.extra.mutations == 0 then
			card.ability.extra.mutations = {{ effect = "mult", value = 4 }}
			end
			if not context.forcetrigger then
			if G.GAME.hands[context.scoring_name].level <= 1 then return end
			for k, v in pairs(G.GAME.hands) do
				if v.level > G.GAME.hands[context.scoring_name].level then return end
			end
			end
			local ret = {}
			local repeats = card.ability.extra.mutations_per_round
			for iii = 1, repeats do
			local odds_list = {
				"new_effect",
				"lose_effect",
				"change_effect",
				"gain_value",
				"lose_value",
				"nothing",
				"plus_mutation",
				"minus_mutation",
			}
			local max_odds = 0
			local _lost = 1
			local _lostmut = 1
			for k,v in ipairs(odds_list) do max_odds = max_odds + card.ability.extra.odds[v] end
			local roll = pseudorandom("zero_alpine_lily_eor", 1, max_odds)
		
			local function pick_unmarked_for_removal(tag)
				local candidates = {}
				for i = 1, #card.ability.extra.mutations do
				local m = card.ability.extra.mutations[i]
				if m and not m._scheduled_for_removal then
					candidates[#candidates + 1] = m
				end
				end
				if #candidates == 0 then return nil end
				local idx = pseudorandom(tag, 1, #candidates)
				local target = candidates[idx]
				target._scheduled_for_removal = true
				return target
			end
		
			for k,v in ipairs(odds_list) do
				if roll <= card.ability.extra.odds[v] then
				if v == "new_effect" or (#card.ability.extra.mutations == _lost and v == "lose_effect") then
					if _lost > 1 then
					_lost = _lost - 1
					end
					append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
						func = function()
						zero_create_mutation(self, card)
						end,
						message = localize("k_new_effect_ex")
					},
					})
				elseif v == "lose_effect" then
					_lost = _lost + 1
					do
					local target = pick_unmarked_for_removal("zero_alpine_lily_lose_effect")
					append_extra(ret, {
						message = localize("k_mutated_ex"),
						extra = {
						func = function()
							if not target then return end
							for i = 1, #card.ability.extra.mutations do
							if card.ability.extra.mutations[i] == target then
								table.remove(card.ability.extra.mutations, i)
								target._scheduled_for_removal = nil
								return
							end
							end
							target._scheduled_for_removal = nil
						end,
						message = localize("k_lose_effect_ex")
						},
					})
					end
				elseif v == "change_effect" then
					do
					local count = #card.ability.extra.mutations
					local idx = 1
					if count > 0 then
						idx = pseudorandom("zero_alpine_lily_change_effect", 1, count)
					end
					local target = card.ability.extra.mutations[idx]
					local new_effect = pseudorandom_element(zero_list_mutation_effects(self), "zero_alpine_lily_change_mutation")
					append_extra(ret, {
						message = localize("k_mutated_ex"),
						extra = {
						func = function()
							if not target then return end
							target.effect = new_effect
						end,
						message = localize("k_change_effect_ex")
						},
					})
					end
				elseif v == "gain_value" then
					do
					local count = #card.ability.extra.mutations
					local idx = 1
					if count > 0 then
						idx = pseudorandom("zero_alpine_lily_gain_value_effect", 1, count)
					end
					local target = card.ability.extra.mutations[idx]
					local delta = pseudorandom("zero_alpine_lily_gain_value", card.ability.extra.min_gain_value, card.ability.extra.max_gain_value)
					append_extra(ret, {
						message = localize("k_mutated_ex"),
						extra = {
						func = function()
							if not target then return end
							target.value = target.value + delta
						end,
						message = localize("k_gain_value_ex")
						},
					})
					end
				elseif v == "lose_value" then
					do
					local count = #card.ability.extra.mutations
					local idx = 1
					if count > 0 then
						idx = pseudorandom("zero_alpine_lily_lose_value_effect", 1, count)
					end
					local target = card.ability.extra.mutations[idx]
					local delta = pseudorandom("zero_alpine_lily_lose_value", card.ability.extra.min_lose_value, card.ability.extra.max_lose_value)
					append_extra(ret, {
						message = localize("k_mutated_ex"),
						extra = {
						func = function()
							if not target then return end
							target.value = math.max(0, target.value - delta)
						end,
						message = localize("k_lose_value_ex")
						},
					})
					end
				elseif v == "nothing" then
					append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
						message = localize("k_nothing_ex")
					},
					})
				elseif v == "plus_mutation" or (card.ability.extra.mutations_per_round <= _lostmut and v == "minus_mutation") then
					if _lostmut > 1 then
					_lostmut = _lost - 1
					end
					append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
						func = function()
						card.ability.extra.mutations_per_round = card.ability.extra.mutations_per_round + 1
						end,
						message = localize("k_plus_mutation_ex")
					},
					})
				elseif v == "minus_mutation" then
					_lostmut = _lostmut + 1
					append_extra(ret, {
					message = localize("k_mutated_ex"),
					extra = {
						func = function()
						card.ability.extra.mutations_per_round = card.ability.extra.mutations_per_round - 1
						end,
						message = localize("k_minus_mutation_ex")
					},
					})
				end
		
				break
				else
				roll = roll - card.ability.extra.odds[v]
				end
			end
			end
			if ret.extra then return ret.extra end
		end
	end,
	pronouns = "he_him"
}

SMODS.Joker {
    key = "receipt",
	atlas = "zero_jokers",
    pos = { x = 0, y = 3 },
    rarity = 2,
    blueprint_compat = true,
    cost = 4,
	unlocked = true,
	discovered = true,
	config = { extra = { sell_value = 2 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.sell_value} }
    end,
    calculate = function(self, card, context)
		if context.buying_card and not context.buying_self then
			if context.card.set_cost then
                context.card.ability.extra_value = (context.card.ability.extra_value or 0) +
                    card.ability.extra.sell_value
                context.card:set_cost()
            end
			return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
    end
}

SMODS.Joker {
    key = "playjoke",
	atlas = "zero_jokers",
    pos = { x = 2, y = 4 },
	pixel_size = { w = 63, h = 59},
	display_size = { w = 63 * 1.1, h = 59 * 1.1},
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
	unlocked = true,
	discovered = true,
	zero_usable = true,
	zero_stay_in_area = true,
	config = { extra = { modes ={ "chips", "mult", "xmult", "dollars", "swap", "enhance", "consumable" },
	values = { 20, 4, 1.25, 1, true, nil, 4 }, mode = 1
	} },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.values[card.ability.extra.mode], G.GAME.probabilities.normal },
			key = 'j_zero_playjoke_' .. card.ability.extra.modes[card.ability.extra.mode] , set = 'Joker'}
    end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		if card.ability.extra.mode == #card.ability.extra.modes then
			card.ability.extra.mode = 1
		else
			card.ability.extra.mode = card.ability.extra.mode + 1
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = (function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end)}))
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end,
    calculate = function(self, card, context)
		if context.joker_main then
			if card.ability.extra.mode <= 5 then
				local ret = {
					[card.ability.extra.modes[card.ability.extra.mode]] = card.ability.extra.values[card.ability.extra.mode]
				}
				if card.ability.extra.mode == 5 then
					ret["message"] = localize('k_swap_ex')
				end
				return ret
			elseif card.ability.extra.mode == 6 then
				local randomcard = pseudorandom_element( G.play.cards, "playjoke" )
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() randomcard:flip(); play_sound('card1', 1); randomcard:juice_up(0.3, 0.3) return true end }))
				delay(0.2)
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() randomcard:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})]);return true end }))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() randomcard:flip(); play_sound('card1', 1); randomcard:juice_up(0.3, 0.3) return true end }))
				return {
					message = localize('k_enhanced_ex'),
				}
			elseif card.ability.extra.mode == 7 then
				if pseudorandom('playjoke') < G.GAME.probabilities.normal / card.ability.extra.values[card.ability.extra.mode] and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
						local card = create_card('Consumeables', G.consumeables, nil, nil, nil, nil, nil, 'playjoke')
						card:add_to_deck()
						G.consumeables:emplace(card)
						G.GAME.consumeable_buffer = 0
						return true
					end)}))
					return {
					message = "+1",
					}
				end
			end
        end
    end
}

SMODS.Joker {
    key = "lipu_suno",
	atlas = "zero_jokers",
    pos = { x = 5, y = 7 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
	unlocked = true,
	discovered = true,
	config = { extra = { odds = 2, suit = 'zero_Brights' }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = { set = 'Other', key = 'zero_lipu_suno_info', specific_vars = { card.ability.extra.odds, G.GAME.probabilities.normal, localize(card.ability.extra.suit, 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit] }} }
		return { vars = { zero_compose_toki_pona(card.ability.extra.odds), zero_compose_toki_pona(G.GAME.probabilities.normal), colours = {G.C.SUITS[card.ability.extra.suit] } } }
    end,
    calculate = function(self, card, context)
		if context.before then
			local converted = false
			for i=1, #G.play.cards do
				if G.play.cards[i]:is_suit(card.ability.extra.suit) and SMODS.get_enhancements(G.play.cards[i]) ~= {} and pseudorandom('lipu_suno') < G.GAME.probabilities.normal / card.ability.extra.odds then
					converted = true
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.play.cards[i]:flip();play_sound('card1');G.play.cards[i]:juice_up(0.3, 0.3);return true end }))
					delay(0.2)
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.play.cards[i]:set_ability(G.P_CENTERS[SMODS.poll_enhancement({guaranteed = true})]);return true end }))
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.play.cards[i]:flip();play_sound('tarot2', nil, 0.6);G.play.cards[i]:juice_up(0.3, 0.3);return true end }))
					delay(0.5)
				end
			end
			if converted == true then
				return {
                    message = localize("k_swap_ex")
                }
			end
        end
    end,
	in_pool = function(self, args)
		 return zero_brights_in_deck()
	end
}

SMODS.Joker {
    key = "downx2",
	atlas = "zero_jokers",
    pos = { x = 1, y = 4 },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
	unlocked = true,
	discovered = true,
	config = { extra = { odds = 2 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal } }
    end,
    calculate = function(self, card, context)
		if context.starting_shop and pseudorandom('downx2') < G.GAME.probabilities.normal / card.ability.extra.odds then
			for  k, v in ipairs({G.shop_jokers, G.shop_vouchers, G.shop_booster}) do
				for i, _card in ipairs(v.cards) do
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function()
					_card.cost = math.ceil(_card.cost/2)
					_card:juice_up()
					return true end }))
				end
			end
			return {
                message = localize("k_discount_ex")
            }
        end
    end
}

SMODS.Joker {
    key = "sacred_pyre",
	atlas = "zero_jokers",
    pos = { x = 0, y = 2 },
    rarity = 3,
    blueprint_compat = true,
	eternal_compat = false,
    cost = 8,
	unlocked = true,
	discovered = true,
	config = { extra = { boost = 0.05, unused = true } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_zero_sunsteel
		local _key = "j_zero_sacred_pyre"
		if not card.ability.extra.unused then
			_key = "j_zero_sacred_pyre_resurrected"
		end
        return { vars = { card.ability.extra.boost * (( not card.ability.extra.unused and 0.5) or 1) }, key = _key, set = 'Joker',}
    end,
	set_ability = function(self, card, initial, delay_sprites)
		if G.GAME.zero_sacred_pyre_revived == true then
			card.ability.extra.unused = nil
			card.children.center:set_sprite_pos({x=1, y=2})
		end
	end,
	set_sprites = function(self, card, front)
		if card.ability and card.ability.extra and not card.ability.extra.unused then
			card.children.center:set_sprite_pos({x=1, y=2})
		end
	end,
    calculate = function(self, card, context)
		if (context.end_of_round and context.main_eval) or context.forcetrigger	then
			if context.game_over then
				if not context.blueprint then
					G.GAME.zero_sacred_pyre_revived = true
					G.E_MANAGER:add_event(Event({
						func = function()
							G.hand_text_area.blind_chips:juice_up()
							G.hand_text_area.game_chips:juice_up()
							play_sound('tarot1')
							card:start_dissolve()
							return true
						end
					}))
					return {
						message = localize('k_saved_ex'),
						saved = 'ph_zero_sacred_pyre',
						colour = G.C.RED
					}
				end
			else
				G.GAME.zero_sunsteel_pow = G.GAME.zero_sunsteel_pow or 0
				G.GAME.zero_sunsteel_pow = G.GAME.zero_sunsteel_pow + card.ability.extra.boost * (( not card.ability.extra.unused and 0.5) or 1)
				local sunsteel_card = SMODS.add_card { set = "Base", enhancement = "m_zero_sunsteel", area = G.deck }
                return {
                    message = localize('k_plus_sunsteel_pow'),
					sound = "zero_sunsteelpow",
					volume = 0.4,
					pitch = 1.0,
                    colour = G.ARGS.LOC_COLOURS.diamonds,
                    func = function()
						if G.hand then
							for k, v in pairs(G.hand.cards) do
								if SMODS.has_enhancement(v, "m_zero_sunsteel") then
									v:juice_up(0.5)
								end
							end
						end
                        SMODS.calculate_context({ playing_card_added = true, cards = { sunsteel_card } })
                    end
                }
			end
        end
    end
}

SMODS.Joker {
    key = "viscount",
	atlas = "zero_jokers",
    pos = { x = 9, y = 5 },
    rarity = 2,
    blueprint_compat = true,
    cost = 5,
	unlocked = true,
	discovered = true,
	config = { extra = { xmult = 2.5 }},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
		if context.other_consumeable and context.other_consumeable.ability.set == 'Cups' then
            return {
                xmult = card.ability.extra.xmult,
				message_card = context.other_consumeable
            }
        end
    end,
	pronouns = "he_him"
}

SMODS.Joker {
    key = "violet_apostrophe_s_vessel", --why not
	atlas = "zero_jokers",
    pos = { x = 8, y = 5 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
	config = { extra = { multiply = 2, cups = 2}},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.multiply,
		card.ability.extra.cups,
		card.ability.extra.cups == 1 and "" or "s"} }
    end,
    calculate = function(self, card, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.multiply
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                
                local chips_UI = G.hand_text_area.blind_chips
                G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                G.HUD_blind:recalculate() 
                chips_UI:juice_up()
                if not silent then play_sound('chips2') end
            return true end }))
			for i = 1, math.min(card.ability.extra.cups, G.consumeables.config.card_limit - #G.consumeables.cards) do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						if G.consumeables.config.card_limit > #G.consumeables.cards then
							play_sound('timpani')
							SMODS.add_card({ set = 'Cups', key_append = "zero_violet_apostrophe_s_vessel" })
							card:juice_up(0.3, 0.5)
						end
						return true
					end
				}))
				SMODS.calculate_effect(
					{ message = localize('k_plus_cups'), colour = G.C.PURPLE },
					context.blueprint_card or card
				)
			end
			return nil, true
		end
	end,
	pronouns = "he_him"
}

SMODS.Joker {
    key = "qrcode",
	atlas = "zero_jokers",
    pos = { x = 1, y = 3 },
	pixel_size = { w = 35, h = 35},
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
	unlocked = true,
	discovered = true,
	config = { extra = { chips = 40 }},
	loc_vars = function(self, info_queue, card)
		local count = 0
		if G.jokers then
			for k, v in ipairs(G.jokers.cards) do
				if v.config.center.mod and v.config.center.mod.id == "zeroError" then
					count = count + 1
				end
			end
		else
			count = 1
		end
		return { vars = { card.ability.extra.chips, card.ability.extra.chips * count } }
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			local count = 0
            for k, v in ipairs(G.jokers.cards) do
				if v.config.center.mod and v.config.center.mod.id == "zeroError" then
				count = count + 1
				end
			end
			if count > 0 then
				return {
					chips = card.ability.extra.chips * count
				}
			end
        end
    end
}

SMODS.Joker {
    key = "cups_prince",
	atlas = "zero_jokers",
    pos = { x = 7, y = 5 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
	unlocked = true,
	discovered = true,
    calculate = function(self, card, context)
		if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local _rank
			for k, v in ipairs(context.full_hand) do
				if not _rank then
					if v:is_face() then
						_rank = v:get_id()
					else
						return
					end
				elseif (not v:is_face()) or v:get_id() ~= _rank then
					return
				end
			end
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = (function()
					SMODS.add_card {
						set = 'Cups',
						key_append = 'zero_cups_prince'
					}
					G.GAME.consumeable_buffer = 0
					return true
				end)
			}))
			return {
				message = localize('k_plus_cups'),
			}
        end
    end,
	pronouns = "he_him"
}

SMODS.Joker {
    key = "dotdotdotdotdotdot",
	atlas = "zero_jokers",
    pos = { x = 7, y = 7 },
    rarity = 2,
    blueprint_compat = true,
	eternal_compat = false,
    cost = 4,
	unlocked = true,
	discovered = true,
	config = { extra = { xmult = 4 }},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
    end,
	--update = function(self, card)
    --    ease_background_colour{new_colour = G.C.BLACK, special_colour = G.C.WHITE, contrast = 2}
    --end,
    calculate = function(self, card, context)
		if context.joker_main then
            for _, v in ipairs(context.full_hand) do
				if v:is_suit("Hearts") or v:is_suit("Diamonds") then
					SMODS.destroy_cards(card, nil, nil, true)
					return {
						message = localize('dhsgherrorjfjdfoi'),
					}
				end
			end
			for _, v in ipairs(G.hand.cards) do
				if v:is_suit("Hearts") or v:is_suit("Diamonds") then
					SMODS.destroy_cards(card, nil, nil, true)
					return {
						message = localize('dhsgherrorjfjdfoi'),
					}
				end
			end
			return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
	zero_glitch = true
}

SMODS.Joker {
    key = "damocles",
	atlas = "zero_jokers",
    pos = { x = 9, y = 7 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
	unlocked = true,
	discovered = true,
	config = { extra = { active = false, cards = 2 }},
	loc_vars = function(self, info_queue, card)
		local key = "j_zero_damocles"
		if card.ability.extra.active == true then
			key = "j_zero_damocles_active"
		end
		return { vars = { card.ability.extra.cards},
		key = key, set = 'Joker' }
    end,
	zero_usable = true,
	can_use = function(self, card)
		return not card.ability.extra.active
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = true
		card.ability.eternal = true
		SMODS.calculate_effect({
			message = localize('k_plus_blessing_ex'),
			colour = G.C.BLUE
		}, card)
		delay(1)
		ease_hands_played(-G.GAME.current_round.hands_left + 1)
		SMODS.calculate_effect({
			message = localize('k_plus_curse_ex'),
			colour = G.C.RED
		}, card)
		delay(0.4)
		draw_card(G.play, G.consumeables, nil, 'up', nil, card)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
		change_shop_size(card.ability.extra.cards)
		if G.shop_jokers and G.shop_jokers.cards then
			G.shop_jokers.cards[#G.shop_jokers.cards].cost = 0
			G.shop_jokers.cards[#G.shop_jokers.cards-1].cost = 0
		end
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1e6
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.active == true then
			G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1e6
			change_shop_size(-card.ability.extra.cards)
		end
	end,
    calculate = function(self, card, context)
		if ( context.starting_shop or context.reroll_shop ) and card.ability.extra.active == true then
			local to_discount = card.ability.extra.cards
			local i = 0
			while to_discount > 0 and i < #G.shop_jokers.cards do
				local idx = #G.shop_jokers.cards - i
				if G.shop_jokers.cards[idx].cost > 0 then
				G.shop_jokers.cards[idx].cost = 0
				to_discount = to_discount - 1
				end
			i = i + 1
			end
		end
    end
}

SMODS.Joker {
    key = "crux",
	atlas = "zero_jokers",
    pos = { x = 4, y = 7 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
    calculate = function(self, card, context)
		if context.ending_shop and G.consumeables.cards[1] then
            local to_transform = pseudorandom_element(G.consumeables.cards, 'crux')
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					play_sound('tarot1')
					card:juice_up(0.3, 0.5)
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					to_transform:flip()
					play_sound('card1')
					to_transform:juice_up(0.3, 0.3)
					return true
				end
			}))
			delay(0.2)
			local _handname, _played, _order = 'High Card', -1, 100
			for k, v in pairs(G.GAME.hands) do
				if v.played > _played or (v.played == _played and _order > v.order) then
					_played = v.played
					_handname = k
				end
			end
			local planettocreate
			for k, v in pairs(G.P_CENTER_POOLS.Planet) do
				if v.config.hand_type == _handname then
					planettocreate = v.key
				end
			end
			local planet
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					planet = create_card('Planet', nil, nil, nil, nil, false, planettocreate)
					copy_card( planet, to_transform )
					planet:remove()
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					to_transform:flip()
					play_sound('tarot2', nil, 0.6)
					to_transform:juice_up(0.3, 0.3)
					return true
				end
			}))
			return {
				message = localize('k_transformed_ex'),
			}
        end
    end
}

SMODS.Joker {
    key = "h_poke",
	atlas = "zero_jokers",
    pos = { x = 8, y = 7 },
	pixel_size = { w = 71, h = 95},
	display_size = { w = 71 * 1.2, h = 95 * 1.2 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
	config = { extra = { consumable = {} }},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.consumable[2]]
	end,
	set_ability = function(self, card, initial, delay_sprites)
		if G.jokers then
			local randomcons = pseudorandom_element(G.P_CENTER_POOLS.Consumeables, pseudoseed('h_poke'))
			card.ability.extra.consumable = {randomcons.set, randomcons.key}
		end
	end,
    calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
				SMODS.add_card({ key = card.ability.extra.consumable[2] })
				G.GAME.consumeable_buffer = 0
                return true
                end
            }))
			local random_sound_effs = {
				"button",
				"cancel",
				"card1",
				"card3",
				"cardFan2",
				"cardSlide1",
				"cardSlide2",
				"chips1",
				"chips2",
				"coin1",
				"coin2",
				"coin3",
				"coin4",
				"coin5",
				"coin6",
				"coin7",
				"crumple1",
				"crumple2",
				"crumple3",
				"crumple4",
				"crumple5",
				"crumpleLong1",
				"crumpleLong2",
				"crumpleLong2",
				"foil1",
				"foil2",
				"generic1",
				"glass1",
				"glass2",
				"glass3",
				"glass4",
				"glass5",
				"glass6",
				"gold_seal",
				"gong",
				"highlight1",
				"highlight2",
				"holo1",
				"magic_crumple",
				"magic_crumple2",
				"magic_crumple3",
				"multhit1",
				"multhit2",
				"negative",
				"other1",
				"paper1",
				"polychrome1",
				"slice1",
				"tarot1",
				"tarot2",
				"timpani",
				"whoosh",
				"whoosh1",
				"whoosh2",
				"zero_galasfx"
			}
			return { message = localize('kkshafjkh'), colour = G.C.SECONDARY_SET[card.ability.extra.consumable[1]], sound = pseudorandom_element(random_sound_effs) }
		end
    end,
	zero_glitch = true,
}

SMODS.Joker {
    key = "strange_seeds",
	atlas = "zero_jokers",
    pos = { x = 0, y = 8 },
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
	unlocked = true,
	discovered = true,
	config = { extra = { bloom_rounds = 0, total_rounds = 6 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.total_rounds, card.ability.extra.bloom_rounds } }
	end,
    calculate = function(self, card, context)
		if (context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint) or context.forcetrigger then
            card.ability.extra.bloom_rounds = card.ability.extra.bloom_rounds + 1
			if card.ability.extra.bloom_rounds >= card.ability.extra.total_rounds - 1 then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            if card.ability.extra.bloom_rounds >= card.ability.extra.total_rounds then
				local plants = {}
				for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
					if v.zero_plant and (not next(SMODS.find_card(v.key, true)) or next(SMODS.find_card(j_ring_master))) then
						plants[#plants + 1] = v.key
					end
				end
				G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
				local magic_plant = SMODS.add_card({ set = 'Joker', key = pseudorandom_element(plants, "strange_seeds")})
				if card.edition then
				magic_plant:set_edition(card.edition,true)
				end
				card:juice_up(0.3, 0.5)
				return true
				end}))
				SMODS.destroy_cards(card, nil, nil, true)
            end
            return {
                message = (card.ability.extra.bloom_rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.bloom_rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_bloom_ex'),
                colour = G.C.GREEN
            }
        end
    end
}

SMODS.Joker {
    key = "fabled_rose_of_isola",
	atlas = "zero_jokers",
    pos = { x = 1, y = 8 },
    rarity = 2,
    blueprint_compat = false,
    cost = 100,
	unlocked = true,
	discovered = true,
	config = { extra = { price = 5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.price } }
	end,
    calculate = function(self, card, context)
		if (context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint) or context.forcetrigger then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.GREEN
            }
        end
    end,
	in_pool = function(self)
		return false
	end,
	zero_plant = true
}

SMODS.Joker {
    key = "magic_tree_of_fragrance",
	atlas = "zero_jokers",
    pos = { x = 2, y = 8 },
    rarity = 2,
    blueprint_compat = true,
    cost = 5,
	unlocked = true,
	discovered = true,
	config = { extra = { odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal } }
	end,
    calculate = function(self, card, context)
		if context.reroll_shop and pseudorandom('magic_tree_of_fragrance') < G.GAME.probabilities.normal / card.ability.extra.odds then
            G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
				local rare = SMODS.add_card({ set = 'Joker', rarity = 3, area = G.shop_jokers})
				create_shop_card_ui(rare,rare.ability.set,G.shop_jokers)
				card:juice_up(0.3, 0.5)
				return true
			end}))
			return {
                message = localize('k_plus_shop_ex'),
                colour = G.C.GREEN
            }
        end
    end,
	in_pool = function(self)
		return false
	end,
	zero_plant = true
}

SMODS.Joker {
    key = "golden_berries_of_wealth",
	atlas = "zero_jokers",
    pos = { x = 3, y = 8 },
    rarity = 2,
    blueprint_compat = true,
    cost = 5,
	unlocked = true,
	discovered = true,
	config = { extra = { xvalue = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xvalue } }
	end,
    calculate = function(self, card, context)
		if context.forcetrigger or context.joker_main then
            local target = pseudorandom_element(G.jokers.cards, "golden_berries_of_wealth")
			if target.set_cost then
				target.ability.extra_value = target.sell_cost * card.ability.extra.xvalue - math.floor(target.config.center.cost / 2)
				target:set_cost()
			end
			return {
                message = "X" .. card.ability.extra.xvalue .. " " .. localize('k_sell_value'),
                colour = G.C.GREEN,
				message_card = target,
				card = card
            }
		end
    end,
	in_pool = function(self)
		return false
	end,
	zero_plant = true
}

SMODS.Joker {
    key = "rose_of_joy",
	atlas = "zero_jokers",
    pos = { x = 4, y = 8 },
    rarity = 2,
    blueprint_compat = true,
    cost = 5,
	unlocked = true,
	discovered = true,
    calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == 'Joker' and context.card ~= card and G.shop_jokers then
			for i = 1,2 do
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
					local shop_card = SMODS.add_card({set = pseudorandom_element({'Joker','Consumeables'},"rose_of_joy"), area = G.shop_jokers})
					create_shop_card_ui(shop_card,shop_card.ability.set,G.shop_jokers)
					card:juice_up(0.3, 0.5)
					return true
				end}))
			end
			return {
                message = localize('k_plus_shop_ex'),
                colour = G.C.GREEN
            }
		end
    end,
	in_pool = function(self)
		return false
	end,
	zero_plant = true
}

SMODS.Joker {
    key = "fruit_of_life",
	atlas = "zero_jokers",
    pos = { x = 5, y = 8 },
    rarity = 2,
    blueprint_compat = false,
    cost = 8,
	pools = { Food = true },
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		info_queue[#info_queue + 1] = G.P_CENTERS.j_zero_strange_seeds
		return { key = "j_zero_fruit_of_life" .. ((card.edition and card.edition.key and card.edition.key == "e_negative" and "_negative") or ""), set = 'Joker' }
	end,
    calculate = function(self, card, context)
		if context.selling_self then
			local negaseeds
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
				negaseeds = SMODS.add_card({set = 'Joker', area = G.jokers, key = "j_zero_strange_seeds", edition = "e_negative"})
				return true
			end}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
				negaseeds.ability.extra.total_rounds = 2
				if card.edition and card.edition.key and card.edition.key == "e_negative" then
					G.jokers.config.card_limit = G.jokers.config.card_limit + 1
				end
				return true
			end}))
		end
    end,
	in_pool = function(self)
		return false
	end,
	zero_plant = true
}

SMODS.Joker {
    key = "flower_of_knowledge",
	atlas = "zero_jokers",
    pos = { x = 6, y = 8 },
    rarity = 2,
    blueprint_compat = false,
    cost = 5,
	unlocked = true,
	discovered = true,
    add_to_deck = function(self, card, from_debuff)
		G.GAME.interest_cap = G.GAME.interest_cap + 1e10
	end,
	calculate = function(self, card, context)
        if G.GAME.interest_cap < 1e10 then
			G.GAME.interest_cap = G.GAME.interest_cap + 1e10
		end
    end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.interest_cap = G.GAME.interest_cap - 1e10
	end,
	in_pool = function(self)
		return false
	end,
	zero_plant = true
}

SMODS.Joker {
    key = "croque_madame",
	atlas = "zero_jokers",
    pos = { x = 6, y = 1 },
    rarity = 1,
    blueprint_compat = false,
	eternal_compat = false,
    cost = 3,
	pools = { Food = true },
	unlocked = true,
	discovered = true,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
			for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
			if other_joker and other_joker.config.center.cost then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					dollars = (card.sell_cost + other_joker.sell_cost) * 2,
				}
			end
		end
    end,
	pronouns = "she_her"
}

SMODS.Joker {
	key = "lip_balm",
	pos = { x = 7, y = 1 },
	atlas = "zero_jokers",
	rarity = 1,
	cost = 4,
	pools = { Food = true },
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	config = { extra = { rounds = 6 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rounds } }
	end,
	calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.extra.rounds = card.ability.extra.rounds - 1
			if card.ability.extra.rounds == 0 then
				SMODS.destroy_cards(card, nil, nil, true)
			end
			return {
                message = "" .. card.ability.extra.rounds,
            }
		end
    end,
}

SMODS.Joker {
	key = "red_sketch",
	pos = { x = 2, y = 9 },
	atlas = "zero_jokers",
	rarity = 3,
	cost = 12,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local main_end
		if card.area and card.area == G.jokers then
			local other_joker
			if G.jokers.cards[#G.jokers.cards] ~= card then
				other_joker = G.jokers.cards[#G.jokers.cards]
			end
			local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
			main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
							nodes = {
								{ n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
							}
						}
					}
				}
			}
		end
		return {main_end = main_end}
	end,
	calculate = function(self, card, context)
		if card.area and card.area == G.jokers and G.jokers.cards[#G.jokers.cards] ~= card then
            local other_joker = G.jokers.cards[#G.jokers.cards]
			local effects = {}
			for k,v in ipairs(G.consumeables.cards) do
				local singleret = SMODS.blueprint_effect(v, other_joker, context)
				if singleret then
					singleret.message_card = v
					effects[#effects+1] = singleret
				end
			end
			if #effects > 0 then
				return SMODS.merge_effects(effects)
			end
		end
		if context.end_of_round and context.main_eval and not context.blueprint then
			SMODS.destroy_cards(G.consumeables.cards)
		end
    end,
}

local srh = save_run
save_run = function(self)
  local q_triangle_jokers = {}
  for i, card in ipairs(G.jokers.cards) do
    if card.config.center.key == "j_zero_q_triangle" then
      q_triangle_jokers[i] = {}
      for _, stored_card in ipairs(card.ability.immutable.stored_jokers) do
        q_triangle_jokers[i][#q_triangle_jokers[i] + 1] = stored_card:save()
      end
    end
  end

  G.GAME.zero_q_triangle_jokers = q_triangle_jokers

  srh(self)
end

local strh = Game.start_run
Game.start_run = function(self, args)
  strh(self, args)

  if G.GAME.zero_q_triangle_jokers then
    for i, cards in pairs(G.GAME.zero_q_triangle_jokers) do
      G.jokers.cards[i].ability.immutable.stored_jokers = {}
      for _, stored_card in pairs(cards) do
        local card = Card(0, 0, 1, 1, G.P_CENTERS.j_joker, G.P_CENTERS.c_base)
        card.T.x = math.huge
        card.T.y = math.huge
        card.T.H = 4
        card.T.h = 4
        card.T.w = 4
        card:load(stored_card)
        G.jokers.cards[i].ability.immutable.stored_jokers[#G.jokers.cards[i].ability.immutable.stored_jokers + 1] = card
      end
    end
    G.GAME.zero_q_triangle_jokers = nil
  end
end

SMODS.Joker {
    key = "q_triangle",
	atlas = "zero_jokers",
    pos = { x = 6, y = 7 },
    rarity = 3,
    blueprint_compat = true,
    cost = 8,
	unlocked = true,
	discovered = true,
	zero_usable = true,
	zero_stay_in_area = true,
	config = {
		immutable = {
			stored_jokers = {}
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = 'zero_q_triangle_storage', set = 'Other', specific_vars = {#card.ability.immutable.stored_jokers} }
    end,
	can_use = function(self, card)
		if #card.ability.immutable.stored_jokers > 0 and ((#G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit) or (card.ability.immutable.stored_jokers[#card.ability.immutable.stored_jokers].edition and card.ability.immutable.stored_jokers[#card.ability.immutable.stored_jokers].edition.key == "e_negative")) then
			return true
		end
	end,
	use = function(self, card, area, copier)
		G.GAME.joker_buffer = G.GAME.joker_buffer + 1
		G.E_MANAGER:add_event(Event({func = function()
			G.GAME.joker_buffer = 0
			local returned_card = SMODS.add_card({ set = 'Joker'})
			copy_card(card.ability.immutable.stored_jokers[#card.ability.immutable.stored_jokers], returned_card)
			card.ability.immutable.stored_jokers[#card.ability.immutable.stored_jokers] = nil
		return true end }))
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end,
    calculate = function(self, card, context)
		if context.zero_moved or context.card_added then
			local found = false
			for k,v in ipairs(G.jokers.cards) do
				if found == true then
					if v.config.center.key ~= "j_zero_q_triangle" then
						G.GAME.joker_buffer = G.GAME.joker_buffer - 1
						G.E_MANAGER:add_event(Event({func = function()
							G.GAME.joker_buffer = 0
		
							local copied_card = copy_card(v)
							copied_card.T.x = math.huge
							copied_card.T.y = math.huge

							card.ability.immutable.stored_jokers[#card.ability.immutable.stored_jokers + 1] = copied_card
        
							card:juice_up(0.8, 0.8)
							v:remove()
						return true end }))
					end
				elseif v == card then
					found = true
				end
			end
        end
    end,
	zero_glitch = true,
	pronouns = "empty"
}

SMODS.Joker {
    key = "sharps_bin",
	atlas = "zero_jokers",
    pos = { x = 6, y = 4 },
    rarity = 2,
    blueprint_compat = true,
	perishable_compat = false,
    cost = 6,
	unlocked = true,
	discovered = true,
	config = {
		extra = { xmult = 1, xmult_mod = 0.5}
	},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            local glass = 0
            for _, removed_card in ipairs(context.removed) do
                if SMODS.has_enhancement(removed_card, "m_glass") then glass = glass + 1 end
            end
            if glass > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + glass * card.ability.extra.xmult_mod
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
        end
		if context.playing_card_added and context.cards then
			local glass = 0
			for _, v in pairs(context.cards) do
				if SMODS.has_enhancement(v, "m_glass") then glass = glass + 1 end
			end
			if glass > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + glass * card.ability.extra.xmult_mod
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
		end
		if context.setting_ability and (G.P_CENTERS[context.new].key == "m_glass" or G.P_CENTERS[context.old].key == "m_glass") then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
		end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    enhancement_gate = "m_glass",
}

SMODS.Joker {
    key = "3trainerpoke",
	atlas = "zero_jokers",
    pos = { x = 6, y = 6 },
    rarity = 3,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		local main_end
		if card.area and card.area == G.jokers then
			local other_joker
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
			end
			local compatible = other_joker and other_joker ~= card and zero_value_compatible( other_joker.ability, other_joker.config.center.config )
			main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
							nodes = {
								{ n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
							}
						}
					}
				}
			}
		end
		return {main_end = main_end}
	end,
    calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
			end
			if other_joker and other_joker.ability and other_joker.config.center.config and zero_value_compatible( other_joker.ability, other_joker.config.center.config ) then
				local multiply = 1 + ((pseudorandom("3trainerpoke") * 0.8) - 0.4)
				other_joker.ability = zero_value_multiplier(other_joker.ability, other_joker.config.center.config, multiply)
				return {
					message = localize('yghdsuvjdijf'),
					card = card
				}
			end
		end
    end,
	zero_glitch = true
}

--this joker works in a bit of a wonky way due to Balatro's limitations
--when it comes to moving cards around in the middle of scoring
SMODS.Joker {
	key = "portrait_dragee",
	pos = {x = 8, y = 6},
	atlas = "zero_jokers",
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_zero_sunsteel
	end,
	calculate = function(self, card, context)
		G.dragee_sunsteels = G.dragee_sunsteels or {}
		if context.before and #G.dragee_sunsteels == 0 and not context.blueprint then
			for k, v in pairs(G.deck.cards) do
				if SMODS.has_enhancement(v, "m_zero_sunsteel") then
					G.dragee_sunsteels[#G.dragee_sunsteels + 1] = v
				end
			end
		end
		if context.individual and context.cardarea == G.play and not context.end_of_round and (SMODS.has_enhancement(context.other_card, "m_zero_sunsteel") or context.other_card:is_suit("Hearts")) and #G.dragee_sunsteels > 0 then
			local randomdraw = pseudorandom_element(G.dragee_sunsteels, "portrait_dragee")
			for i, v in ipairs(G.dragee_sunsteels) do if v == randomdraw then table.remove(G.dragee_sunsteels, i) break end end
			return {
				message = localize('k_draw_ex'),
				colour = G.ARGS.LOC_COLOURS.diamonds,
				func = function()
					draw_card(G.deck, G.hand, nil, "up", nil, randomdraw)
					local val = randomdraw.ability.extra.xmult + (G.GAME.zero_sunsteel_pow or 0)
					val = val + (randomdraw.ability.extra.xmult_mod + (G.GAME.zero_sunsteel_pow or 0)) * (G.zero_dragee_count or 0)
					for k,v in ipairs(G.hand.cards) do
						if v ~= randomdraw and SMODS.has_enhancement(v, "m_zero_sunsteel") then
						val = val + randomdraw.ability.extra.xmult_mod + (G.GAME.zero_sunsteel_pow or 0)
						end
					end
					G.zero_dragee_count = (G.zero_dragee_count or 0) + 1
					SMODS.calculate_effect({
						xmult = val
					}, randomdraw)
				end
			}
		end
		if context.after and not context.blueprint then
			G.dragee_sunsteels = {}
			G.zero_dragee_count = 0
		end
	end,
	enhancement_gate = "m_zero_sunsteel",
	pronouns = "she_her"
}

SMODS.Joker {
	key = "portrait_lunchalot",
	pos = {x = 9, y = 6},
	atlas = "zero_jokers",
	rarity = 3,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = false,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and (SMODS.get_enhancements(context.other_card)["m_steel"] == true or SMODS.get_enhancements(context.other_card)["m_gold"] == true) then
            return {
                message = localize('k_again_ex'),
                repetitions = 2,
                card = card
            }
        elseif context.repetition and context.cardarea == G.hand and (SMODS.get_enhancements(context.other_card)["m_steel"] == true or SMODS.get_enhancements(context.other_card)["m_gold"] == true) then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
	end,
	in_pool = function(self)
		for k,v in ipairs(G.playing_cards) do
			if SMODS.has_enhancement(v,"m_gold") or SMODS.has_enhancement(v,"m_steel") then
				return true
			end
		end
	end,
	pronouns = "he_him"
}

SMODS.Joker {
	key = "found_a_star",
	pos = {x = 5, y = 9},
	atlas = "zero_jokers",
	rarity = 1,
	cost = 1,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	config = {
		extra = { placed = nil, suit = 'zero_Brights' }
	},
	loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_singular'), localize(card.ability.extra.suit, 'suits_plural'), colours = {G.C.SUITS[card.ability.extra.suit] } } }
    end,
	calculate = function(self, card, context)
		if context.blueprint then return end
		local exists = false
		for k, v in pairs(G.playing_cards) do
			if v.zero_secret_bright and card.ability.extra.placed and card.ability.extra.placed == v.zero_secret_bright then
				exists = true
				break
			end
		end
		if exists == false then
			card.ability.extra.placed = nil
		end
		if not card.ability.extra.placed then
			local nonbrights = {}
			local randomcard
			for k, v in pairs(G.playing_cards) do
				if v:is_suit(card.ability.extra.suit) == false then
					nonbrights[#nonbrights + 1] = v
				end
			end
			if #nonbrights > 0 then
			local link = string.format( "%04d%04d%04d%04d", math.random(0, 9999), math.random(0, 9999), math.random(0, 9999), math.random(0, 9999) )
				randomcard = pseudorandom_element(nonbrights, "found_a_star")
				randomcard.zero_secret_bright = link
				card.ability.extra.placed = link
				--print(randomcard.config)
			end
		end
		if context.individual and context.cardarea == G.play and context.other_card.zero_secret_bright and card.ability.extra.placed and card.ability.extra.placed == context.other_card.zero_secret_bright then
            card.ability.extra.placed = nil
			local found = context.other_card
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() found:flip();play_sound('card1');found:juice_up(0.3, 0.3);return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() found:change_suit(card.ability.extra.suit);return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() found:flip();play_sound('tarot2', nil, 0.6);found:juice_up(0.3, 0.3);found.zero_secret_bright = nil;return true end }))
			return {
                message = localize('k_stage_clear_upper'),
				sound = "zero_hoshisaga_chirin",
				colour = G.C.SECONDARY_SET.Enhanced
            }
        end
	end
}

SMODS.Joker {
	key = "obsessive_elementation",
	pos = {x = 1, y = 0},
	atlas = "zero_jokers_2",
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = false,
	config = {
		extra = { odds = 5 },
		immutable = {
			conversion = {Hearts = "c_zero_fire",
				Spades = "c_zero_earth",
				Clubs = "c_zero_water",
				Diamonds = "c_zero_air",
				zero_Brights = "c_zero_cosmos"}
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {set = "Other", key = 'zero_base_elements_reminder'}
		return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_no_suit(context.other_card) == false and card.ability.immutable.conversion[context.other_card.base.suit] and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and pseudorandom('obsessive_elementation') < G.GAME.probabilities.normal / card.ability.extra.odds then
			local _suit = context.other_card.base.suit
			return {
				message = localize('k_plus_elemental'),
				colour = G.C.SECONDARY_SET.Elemental,
				card = card,
				message_card = card,
				func = function()
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = function()
							if G.consumeables.config.card_limit > #G.consumeables.cards then
								play_sound('timpani')
								SMODS.add_card({ set = 'Elemental', key = card.ability.immutable.conversion[_suit] })
								card:juice_up(0.3, 0.5)
								G.GAME.consumeable_buffer = 0
							end
							return true
						end
					}))
				end
			}
		end
	end,
	pronouns = "he_him"
}

SMODS.Joker {
    key = "e",
	atlas = "zero_jokers",
    pos = { x = 0, y = 5 },
	soul_pos = { x = 1, y = 5 },
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
	unlocked = true,
	discovered = true,
	config = { extra = { frames = 0, soul_sprite = 1, suit = "", xmult = 1, xmult_mod = 0.05 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
    end,
	update = function(self, card)
		card.ability.extra.frames = math.ceil(card.ability.extra.frames) + 1
		if card.ability.extra.frames % 40 == 0 then
			card.ability.extra.frames = 0
			card.ability.extra.soul_sprite = math.ceil(card.ability.extra.soul_sprite) + 1
			if card.ability.extra.soul_sprite > 3 or card.ability.extra.soul_sprite < 1 then
				card.ability.extra.soul_sprite = 1
			end
			card.children.floating_sprite:set_sprite_pos({x= card.ability.extra.soul_sprite, y=5})
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		local non_suitless = {}
		for k, v in pairs(G.playing_cards) do
			if SMODS.has_no_suit(v) == false and (not v.ability or not v.ability.name or v.ability.name  ~= "Suit Yourself Card") then
				non_suitless[#non_suitless + 1] = v
			end
		end
		if #non_suitless > 0 then
			card.ability.extra.suit = pseudorandom_element(non_suitless, "e").base.suit
		end
	end,
	calculate = function(self, card, context)
		if (context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) and not context.blueprint) or context.forcetrigger then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }, card = card, message_card = card }
		end
		if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
		if context.end_of_round and context.main_eval and not context.blueprint then
			local non_suitless = {}
			for k, v in pairs(G.playing_cards) do
				if SMODS.has_no_suit(v) == false and (not v.ability or not v.ability.name or v.ability.name ~= "Suit Yourself Card") then
					non_suitless[#non_suitless + 1] = v
				end
			end
			if #non_suitless > 0 then
				card.ability.extra.suit = pseudorandom_element(non_suitless, "e").base.suit
			end
		end
	end,
	pronouns = "it_they_thon"
}

SMODS.Joker {
	key = "time_walk",
	pos = {x = 0, y = 0},
	atlas = "zero_jokers_2",
	rarity = 3,
	cost = 8,
	no_pool_flag = 'zero_time_walked',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	eternal_compat = false,
	config = { extra = { money = 0, currentmoney = 0, target = 30 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.target, card.ability.extra.money } }
    end,
	add_to_deck = function(self, card, from_debuff)
		card.ability.extra.currentmoney = G.GAME.dollars
		G.GAME.pool_flags.zero_time_walked = true
	end,
	update = function(self, card)
		if card.area == G.jokers and card.ability.extra.currentmoney ~= G.GAME.dollars then
			if card.ability.extra.currentmoney < G.GAME.dollars then
				card.ability.extra.money = card.ability.extra.money + G.GAME.dollars - card.ability.extra.currentmoney
				if card.ability.extra.money >= card.ability.extra.target then
					card.ability.extra.money = 0
					SMODS.destroy_cards(card, nil, nil, true)
				end
			end
			card.ability.extra.currentmoney = G.GAME.dollars
		end
	end
}

SMODS.Joker {
	key = "dazzles",
	pos = {x = 2, y = 0},
	atlas = "zero_jokers_2",
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = false,
	config = {
		extra = { mult = 4, times = 3, count = 0},
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.times, card.ability.extra.times == 1 and " is" or "s are" } }
    end,
	calculate = function(self, card, context)
        if (context.individual and context.cardarea == G.play) or context.forcetrigger then
			card.ability.extra.count = card.ability.extra.count + 1
			if card.ability.extra.count >= card.ability.extra.times then
				card.ability.extra.count = 0
				card.ability.extra.times = pseudorandom_element( {1,2,3,6}, "dazzles" )
				return {
					mult = card.ability.extra.mult
				}
			end
		end
	end,
	pronouns = "they_them" -- :)
}

SMODS.Joker {
	key = "rewards_card",
	pos = {x = 4, y = 0},
	atlas = "zero_jokers_2",
	rarity = 3,
	cost = 8,
	unlocked = false,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = false,
	config = {
		extra = { id = "" },
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] ={key = 'gold_sticker', set = 'Other'}
		local gold_sticker_count = 0
		for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if get_joker_win_sticker(v, true) >= 8 then
				gold_sticker_count = gold_sticker_count + 1
			end
		end
		return { vars = { gold_sticker_count } }
    end,
	set_ability = function(self, card, initial, delay_sprites)
		if card.ability.extra.id == "" then
			card.ability.extra.id = string.format( "%04d%04d%04d%04d", math.random(0, 9999), math.random(0, 9999), math.random(0, 9999), math.random(0, 9999) )
		end
	end,
	calculate = function(self, card, context)
        if context.initial_scoring_step then
			local validtargets = {}
			for _, w in pairs({G.jokers.cards,context.scoring_hand}) do
				for _, v in pairs(w) do
					if v.config.center.key ~= "j_zero_rewards_card" then
						v["rewards_retrigger_" .. card.ability.extra.id] = 0
						validtargets[#validtargets + 1] = v
					end
				end
			end
			local gold_sticker_count = 0
			for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
				if get_joker_win_sticker(v, true) >= 8 then
					gold_sticker_count = gold_sticker_count + 1
				end
			end
			for i = 1, gold_sticker_count do
				local target = pseudorandom_element(validtargets, pseudoseed('rewards_card'))
				target["rewards_retrigger_" .. card.ability.extra.id] = target["rewards_retrigger_" .. card.ability.extra.id] + 1
			end
		end
		if ((context.repetition and context.cardarea == G.play) or (context.retrigger_joker_check and not context.retrigger_joker)) and context.other_card and context.other_card["rewards_retrigger_" .. card.ability.extra.id] and context.other_card["rewards_retrigger_" .. card.ability.extra.id] > 0 then
			return {
				message = localize("k_again_ex"),
				repetitions = context.other_card["rewards_retrigger_" .. card.ability.extra.id],
				card = card
			}
		end
	end,
	in_pool = function(self)
		for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if get_joker_win_sticker(v, true) >= 8 then
				return true
			end
		end
		return false
	end,
	check_for_unlock = function(self, args)
        for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if get_joker_win_sticker(v, true) >= 8 then
				return true
			end
		end
		return false
    end
}

SMODS.Joker {
	key = "paragon_rod",
	pos = {x = 5, y = 0},
	atlas = "zero_jokers_2",
	rarity = 2,
	cost = 3,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = false,
	demicoloncompat = false,
	zero_usable = true,
	config = { extra = { active = false } },
	calculate = function(self, card, context)
        if context.after and not context.blueprint then
			local weaker_crafted_joker = zero_craft(G.play.cards, nil, -5)
			if weaker_crafted_joker then
				G.E_MANAGER:add_event(Event({
				trigger = 'before',
				func = (function()
					SMODS.add_card {
						set = 'Joker',
						key = weaker_crafted_joker
					}
				return true end)}))
				SMODS.destroy_cards(G.play.cards)
				SMODS.destroy_cards(card)
			end
		end
	end,
	can_use = function(self, card)
		return true
	end,
	use = function(self, card, area, copier)
		card.ability.extra.active = not card.ability.extra.active
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = (function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
			return true end)}))
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
		local eval = function(card) return card.ability.extra.active end
		juice_card_until(card, eval, true)
	end,
}

SMODS.Joker {
	key = "mana_tank",
	pos = {x = 6, y = 0},
	atlas = "zero_jokers_2",
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	zero_usable = true,
	config = { extra = { active = true } },
	can_use = function(self, card)
		return card.ability.extra.active
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint and G.GAME.blind.boss then
			card.ability.extra.active = true
			return {
				message = localize("k_charged_ex")
			}
		end
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.4,
		func = (function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end)}))
		for k, v in pairs(G.jokers.cards) do
			if v.config.center.use and ((not v.ability.extra.active and v.ability.extra.active ~= nil) or v.ability.extra.disables) then
				if not v.ability.extra.active and v.ability.extra.active ~= nil then
					v.ability.extra.active = true
				elseif v.ability.extra.disables then
					v.ability.extra.disables = v.ability.extra.disables + 1
				end
				SMODS.calculate_effect({ message = localize("k_charged_ex") },
                v)
			end
		end
		card.ability.extra.active = false
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end,
	in_pool = function(self)
		for k, v in pairs(G.jokers.cards) do
			if v.config.center.use then
				return true
			end
		end
		return false
	end,
}

SMODS.Joker {
	key = "smoke_bomb", --code referenced from cryptid, entropy and baltswarehouse
	pos = {x = 7, y = 0},
	atlas = "zero_jokers_2",
	rarity = 3,
	cost = 6,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	zero_usable = true,
	config = { extra = { active = true, used = false } },
	can_use = function(self, card)
		return card.ability.extra.active and G.STATE == G.STATES.SELECTING_HAND
	end,
	calculate = function(self, card, context)
		if context.blueprint then return end
		if context.end_of_round and context.main_eval and not context.repetition and G.GAME.blind.boss then
			card.ability.extra.active = true
			return {
				message = localize("k_charged_ex")
			}
		end
		if context.game_over and card.ability.extra.used then
			card.ability.extra.used = false
			return {
				saved = 'ph_zero_retreat'
			}
		end
	end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0.4,
		func = (function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
		return true end)}))
		card.ability.extra.active = false
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
		for i, v in pairs(G.GAME.round_resets.blind_states) do
            if v == "Current" then v = "Upcoming" end
        end
        G.E_MANAGER:add_event(Event({
			trigger = "immediate",
			func = function()
                G.STATE = 7
				G.STATE_COMPLETE = false
                G.GAME.ZERO_ESCAPING = true
                break_timer = 0
                G.FUNCS.draw_from_hand_to_deck()
				return true
			end,
		}))
        if G.blind_select then        
            G.blind_select:remove()
            G.blind_prompt_box:remove()
        end
	end
}

local uibox_ref = create_UIBox_blind_select
function create_UIBox_blind_select()
    if G.GAME.ZERO_ESCAPING then
        G.E_MANAGER:add_event(Event({
			trigger = "after",
            blocking = false,
            delay = 3,
			func = function()
                G.STATE = 7
                G.FUNCS.draw_from_hand_to_deck()
				return true
			end,
		}))
		G.GAME.ZERO_ESCAPING = nil
		G.E_MANAGER:add_event(Event({
        trigger = 'after',
		blocking = false,
        delay = 3,
		func = function()
			if G.GAME.ZERO_ESCAPING then
				return false
			else
				if G.blind_select then
					G.blind_select:remove()
					G.blind_prompt_box:remove()
					G.blind_select = nil
				end
				G:save_settings()
				G.FILE_HANDLER.force = true
				G.STATE_COMPLETE = false
			
				G.FUNCS.draw_from_hand_to_discard()
				G.FUNCS.draw_from_discard_to_deck()
			
				if G.GAME.round_resets.temp_handsize then
					G.hand:change_size(-G.GAME.round_resets.temp_handsize); G.GAME.round_resets.temp_handsize = nil
				end
				if G.GAME.round_resets.temp_reroll_cost then
					G.GAME.round_resets.temp_reroll_cost = nil; calculate_reroll_cost(true)
				end
			
				reset_idol_card()
				reset_mail_rank()
				reset_ancient_card()
				reset_castle_card()
				for _, mod in ipairs(SMODS.mod_list) do
					if mod.reset_game_globals and type(mod.reset_game_globals) == 'function' then
						mod.reset_game_globals(false)
					end
				end
				for k, v in ipairs(G.playing_cards) do
					v.ability.discarded = nil
					v.ability.forced_selection = nil
				end
			
				stop_use()
				G.deck:hard_set_T()
				G.GAME.blind:defeat()
			
				G.STATE = G.STATES.SHOP
				G.STATE_COMPLETE = false
			
				if card then
					card.ability.extra.done = true
				end
			
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
						G.GAME.current_round.jokers_purchased = 0
						G.GAME.current_round.discards_left = math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards)
						G.GAME.current_round.hands_left = (math.max(1, G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands))
						G.GAME.shop_free = nil
						G.GAME.shop_d6ed = nil
						ease_chips(0)
						G.deck:shuffle('cashout' .. G.GAME.round_resets.ante)
						return true
					end
				}))
				reset_blinds()
				return true
			end
        end}))
    end
    return uibox_ref()
end

SMODS.Joker {
	key = "elemental_fuel",
	pos = {x = 8, y = 0},
	atlas = "zero_jokers_2",
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	demicoloncompat = false,
	zero_usable = true,
	config = { extra = { active = true } },
	can_use = function(self, card)
		return G.STATE == G.STATES.SELECTING_HAND and card.ability.extra.active
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint and G.GAME.blind.boss then
			card.ability.extra.active = true
			return {
				message = localize("k_charged_ex")
			}
		end
	end,
	use = function(self, card, area, copier)
		G.hand:unhighlight_all()
		local to_spread = {}
		for i = 1, #G.hand.cards do
			if G.hand.cards[i].config.center.key ~= "c_base" then
				to_spread[#to_spread+1] = G.hand.cards[i]
			end
		end
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		for i = 1, #G.hand.cards do
            local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('card1', percent)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
					for _, v in pairs(to_spread) do
						if v == G.hand.cards[i] then
							if G.hand.cards[i+1] then
								G.hand.cards[i+1]:set_ability(G.hand.cards[i].config.center.key)
							end
							if G.hand.cards[i-1] then
								G.hand.cards[i-1]:set_ability(G.hand.cards[i].config.center.key)
							end
							break
						end
					end
                    return true
                end
            }))
        end
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
		card.ability.extra.active = false
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end,
}

SMODS.Joker {
	key = "watering_can",
	pos = {x = 9, y = 0},
	atlas = "zero_jokers_2",
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	demicoloncompat = false,
	zero_usable = true,
	config = { extra = { active = true } },
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint and G.GAME.blind.boss then
			card.ability.extra.active = true
			return {
				message = localize("k_charged_ex")
			}
		end
	end,
	can_use = function(self, card)
		return card.ability.extra.active
	end,
	use = function(self, card, area, copier)
		for i = 1, G.jokers.config.card_limit - #G.jokers.cards - (card.edition == "e_negative" and 0 or 1) do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
				play_sound('timpani')
				SMODS.add_card({ set = 'Consumeables', area = G.jokers })
				card:juice_up(0.3, 0.5)
				return true
			end
			}))
		end
		for i = 1, G.consumeables.config.card_limit - #G.consumeables.cards - G.GAME.consumeable_buffer do
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
				play_sound('timpani')
				SMODS.add_card({ set = 'Consumeables', area = G.consumeables })
				card:juice_up(0.3, 0.5)
				return true
			end
			}))
		end
		card.ability.extra.active = false
		delay(0.5)
		draw_card(G.play, G.jokers, nil, 'up', nil, card)
	end,
}

SMODS.Joker {
    key = "consortium",
    blueprint_compat = true,
    rarity = 1,
    cost = 7,
    pos = { x = 3, y = 0 },
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	demicoloncompat = true,
	atlas = "zero_jokers_2",
    config = { extra = { creates = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.creates } }
    end,
    calculate = function(self, card, context)
        if (context.setting_blind or context.forcetrigger) and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
						local owned_mods = {}
						local valid_jokers = {}
						local stopped
						for _, v in pairs(G.jokers.cards) do
							if v ~= card and v.config.center.mod and v.config.center.mod.id then
								stopped = false
								for _, w in pairs(owned_mods) do
									if w == v.config.center.mod.id then
										stopped = true
										break
									end
								end
								if not stopped then
									owned_mods[#owned_mods + 1] = v.config.center.mod.id
								end
							end
						end
						for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
							if (v.rarity == 1 or v.rarity == "Common") and v.mod and v.mod.id then
								stopped = false
								for _, w in pairs(owned_mods) do
									if w == v.mod.id then
										stopped = true
										break
									end
								end
								if not stopped then
									valid_jokers[#valid_jokers + 1] = v.key
								end
							end
						end
						if #valid_jokers > 0 then
							SMODS.add_card {
								set = 'Joker',
								key = pseudorandom_element(valid_jokers, pseudoseed('zero_consortium'))
							}
						else
							SMODS.add_card {
								set = 'Joker',
								rarity = 'Common',
								key_append = 'zero_consortium'
							}
						end
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
    end,
}

SMODS.Joker {
    key = "fucking_nothing",
    unlocked = true,
	discovered = true,
    blueprint_compat = false,
	atlas = "zero_jokers_2",
    rarity = 2,
    cost = 3,
    pos = { x = 2, y = 1 },
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = 0
            }
        end
    end
}

SMODS.Joker {
	key = "kill_this_man",
	pos = {x = 6, y = 9},
	atlas = "zero_jokers",
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = false,
	demicoloncompat = true,
	config = { extra = { payout = {-1,0,1,2}, killed = 10 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.payout[1], card.ability.extra.payout[4], card.ability.extra.killed } }
    end,
	calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
            return {
                dollars = pseudorandom_element(card.ability.extra.payout, pseudoseed('kill_this_man'))
            }
        end
		if context.joker_type_destroyed and context.card == card and not context.blueprint then
			return {
                dollars = card.ability.extra.killed
            }
		end
	end
}

SMODS.Joker {
    key = "wall",
    pos = {x = 5, y = 1},
    atlas = "zero_jokers_2",
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    config = { extra = { slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    add_to_deck = function(self, card, from_debuff)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
        if not from_debuff and G.GAME and G.GAME.round_resets and G.GAME.round_resets.blind_states then
            if not G.GAME.round_resets.blind_choices.Extra_Boss then
                G.GAME.round_resets.blind_choices.Extra_Boss = 'bl_wall'
                G.GAME.last_extra_blind = G.GAME.round_resets.blind_choices.Extra_Boss
            end
            local current_state = G.GAME.round_resets.blind_states.Extra_Boss
            if not current_state or current_state == 'Hide' then
                G.GAME.round_resets.blind_states.Extra_Boss = 'Upcoming'
                if G.GAME.blind_on_deck == 'Boss' then
                    G.GAME.blind_on_deck = 'Extra_Boss'
                    G.GAME.round_resets.blind_states.Boss = 'Upcoming'
                    G.GAME.round_resets.blind_states.Extra_Boss = 'Current'
                end
            end
            if G.blind_select then        
                G.blind_select:remove()
                G.blind_prompt_box:remove()
                G.STATE_COMPLETE = false
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
		if not from_debuff and G.GAME and G.GAME.round_resets and G.GAME.round_resets.blind_states then
            local count = 0
            if G.jokers and G.jokers.cards then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].config.center.key == "j_zero_wall" then
                        count = count + 1
                    end
                end
            end
            if count <= 0 then
                local current_state = G.GAME.round_resets.blind_states.Extra_Boss
                if current_state and current_state ~= 'Hide' and current_state ~= 'Defeated' then
                    if G.GAME.blind_on_deck == 'Extra_Boss' then
                        G.GAME.blind_on_deck = 'Boss'
                        G.GAME.round_resets.blind_states.Extra_Boss = 'Upcoming'
                        G.GAME.round_resets.blind_states.Boss = 'Current'
                    end
                    G.GAME.round_resets.blind_states.Extra_Boss = 'Hide'
                end
                if G.blind_select then        
                    G.blind_select:remove()
                    G.blind_prompt_box:remove()
                    G.STATE_COMPLETE = false
                end
            end
        end
    end,
	calculate = function(self, card, context)
		if ((context.before and G.GAME.blind.config.blind.key == "bl_wall") or context.forcetrigger) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				func = (function()
					SMODS.add_card {
						set = 'Cups',
						key_append = 'zero_wall'
					}
					G.GAME.consumeable_buffer = 0
					return true
				end)
			}))
			return {
				message = localize('k_plus_cups'),
			}
        end
    end,
}

SMODS.Joker {
    key = "witness",
	atlas = "zero_jokers",
    pos = { x = 3, y = 4 },
    rarity = 1,
    blueprint_compat = true,
	demicoloncompat = true,
    cost = 4,
	unlocked = true,
	discovered = true,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
            return {
                chips = zero_needlesslycomplexrandomchips(pseudorandom("witness"))
            }
        end
    end
}

SMODS.Joker {
    key = "miriam",
	atlas = "zero_jokers",
    pos = { x = 3, y = 9 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
	unlocked = true,
	discovered = true,
    config = { extra = { mult = 0, mult_mod = 6} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set = "Other", key = 'zero_miriam_lola'}
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
		if context.pre_discard and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
		end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
		if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
			card.ability.extra.mult = 0
		end
    end,
	add_to_deck = function(self, card, from_debuff)
		if next(SMODS.find_card('j_zero_lola')) and not next(SMODS.find_card('j_zero_miriam')) then
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if next(SMODS.find_card('j_zero_lola')) and not next(SMODS.find_card('j_zero_miriam')) then
			G.jokers.config.card_limit = G.jokers.config.card_limit - 1
		end
	end
}

SMODS.Joker {
    key = "lola",
	atlas = "zero_jokers",
    pos = { x = 4, y = 9 },
    rarity = 1,
    blueprint_compat = true,
    cost = 4,
	unlocked = true,
	discovered = true,
    config = { extra = { chips = 0, chips_mod = 10} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set = "Other", key = 'zero_miriam_lola'}
		return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
		end
		if context.discard and card.ability.extra.chips ~= 0 and not context.blueprint then
			card.ability.extra.chips = 0
			return {
                message = localize('k_reset')
            }
		end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
	add_to_deck = function(self, card, from_debuff)
		if next(SMODS.find_card('j_zero_miriam')) and not next(SMODS.find_card('j_zero_lola')) then
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if next(SMODS.find_card('j_zero_miriam')) and not next(SMODS.find_card('j_zero_lola')) then
			G.jokers.config.card_limit = G.jokers.config.card_limit - 1
		end
	end
}

SMODS.Joker {
    key = "yixi",
	atlas = "zero_jokers_2",
    pos = { x = 0, y = 1 },
    rarity = 2,
    blueprint_compat = true,
    cost = 7,
	unlocked = true,
	discovered = true,
    config = { extra = { xmult = 1, xmult_mod = 0.5} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set = "Other", key = 'zero_yixi_mai'}
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
		end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
		if context.end_of_round and not context.individual and not context.repetition and not next(SMODS.find_card('j_zero_mai')) and not context.blueprint then
			card.ability.extra.xmult = 1
			return {
                message = localize('k_reset')
            }
		end
    end
}

SMODS.Joker {
    key = "mai",
	atlas = "zero_jokers_2",
    pos = { x = 1, y = 1 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
    config = { extra = { xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set = "Other", key = 'zero_yixi_mai'}
		return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker {
    key = "dandelion",
	atlas = "zero_jokers_2",
    pos = { x = 8, y = 1 },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
	unlocked = true,
	discovered = true,
	config = { extra = { suit = "Clubs" } },
    calculate = function(self, card, context)
        if G.GAME.current_round.hands_played == 0 then
			if context.retrigger_joker_check and not context.retrigger_joker and context.other_card then
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == context.other_card and ((G.jokers.cards[i - 1] and G.jokers.cards[i - 1] == card) or (G.jokers.cards[i + 1] and G.jokers.cards[i + 1] == card)) then
						return {
							message = localize("k_again_ex"),
							repetitions = 1,
							card = card
						}
					end
				end
			end
			if context.after then
				local randomcard = pseudorandom_element( G.play.cards, "dandelion" )
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() randomcard:flip(); play_sound('card1', 1); randomcard:juice_up(0.3, 0.3); card:juice_up(0.3, 0.3) return true end }))
				delay(0.2)
				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() SMODS.change_base(randomcard, card.ability.extra.suit, tostring(pseudorandom("dandelion", 1, 10)));return true end }))
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() randomcard:flip(); play_sound('card1', 1); randomcard:juice_up(0.3, 0.3); card:juice_up(0.3, 0.3) return true end }))
				delay(3)
			end
		end
    end
}

--spectrum-requiring jokers
if next(SMODS.find_mod('SpectrumFramework')) then
	SMODS.Joker {
		key = "majesty_colors",
		atlas = "zero_jokers",
		pos = { x = 0, y = 9 },
		rarity = 2,
		blueprint_compat = true,
		demicoloncompat = true,
		cost = 5,
		unlocked = true,
		discovered = true,
		config = { extra = { odds = 2 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.odds, G.GAME.probabilities.normal } }
		end,
		calculate = function(self, card, context)
			if ((context.before and next(context.poker_hands["spectrum_Spectrum"])) or context.forcetrigger) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and pseudorandom('majesty_colors') < G.GAME.probabilities.normal / card.ability.extra.odds then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = (function()
						SMODS.add_card({ set = 'Consumeables', area = G.consumeables, key_append = 'majesty_colors' })
						G.GAME.consumeable_buffer = 0
						return true
					end)
				}))
				return {
					message = localize('k_plus_consumeable'),
				}
			end
		end,
		in_pool = function()
			return SPECF.spectrum_played()
		end
	}
	
	SMODS.Joker {
		key = "group_photo",
		atlas = "zero_jokers_2",
		pos = { x = 7, y = 1 },
		rarity = 2,
		blueprint_compat = true,
		demicoloncompat = false,
		cost = 7,
		pixel_size = { h = 95 / 1.2 },
		unlocked = true,
		discovered = true,
		config = { extra = { xmult = 2 } },
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.xmult } }
		end,
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play and not context.end_of_round and context.other_card:is_face() and next(context.poker_hands["spectrum_Spectrum"]) then
				return {
					xmult = card.ability.extra.xmult
				}
			end
		end,
		in_pool = function()
			return SPECF.spectrum_played()
		end
	}
end

--keep legendary and patron jokers last
SMODS.Joker {
    key = "missingno",
	atlas = "zero_jokers",
    pos = { x = 2, y = 2 },
	soul_pos = { x = 2, y = 3 },
    rarity = 4,
    blueprint_compat = false,
    cost = 20,
	unlocked = true,
	discovered = true,
	config = { extra = { copies = 128 } },
	add_to_deck = function(self, card, from_debuff)
		local to_duplicate = G.jokers.cards[6]
		if to_duplicate and to_duplicate ~= card and to_duplicate.config.center.key ~= "j_zero_missingno" and to_duplicate.config.center.key ~= "j_zero_q_triangle" then
			for i = 1,card.ability.extra.copies do
				SMODS.add_card({ set = 'Joker', key = to_duplicate.config.center.key})
			end
		end
	end,
	in_pool = function(self)
		if G.jokers and G.jokers.cards[6] and G.jokers.cards[6].config.center.key ~= "j_zero_missingno" and G.jokers.cards[6].config.center.key ~= "j_zero_q_triangle" then
			return true
		end
		return false
	end,
	zero_glitch = true,
	pronouns = "empty"
}

SMODS.Joker {
    key = "vonllery",
	atlas = "zero_jokers",
    pos = { x = 5, y = 2 },
	soul_pos = { x = 5, y = 3 },
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_zero_air
    end,
	add_to_deck = function(self, card, from_debuff)
		for _, v in pairs(G.playing_cards) do
			if v:is_suit("Diamonds") and not (v.edition and v.edition.negative) then
				v:set_edition({negative = true})
				v.zhorie = true
			end
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if not next(SMODS.find_card('j_zero_vonllery')) then
			for _, v in pairs(G.playing_cards) do
				if v.edition and v.edition.negative and v.zhorie then
					v:set_edition({base = true})
					v.zhorie = nil
				end
			end
		end
	end,
	calculate = function(self, card, context)
        if context.beat_boss and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Elemental',
                                key = 'c_zero_air'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_elemental'), colour = G.C.SECONDARY_SET.Elemental },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
		end
		if context.blueprint then return end
		if context.playing_card_added and context.cards then
			for _, v in pairs(context.cards) do
				if v:is_suit("Diamonds") and not (card.edition and card.edition.negative) then
					v:set_edition({negative = true})
					v.zhorie = true
				end
			end
		end
		if (context.change_suit and (context.new_suit == 'Diamonds' or context.new_suit == 'zero_Brights')) or (context.setting_ability and G.P_CENTERS[context.new].key == "m_wild") then
			if not (context.other_card.edition and context.other_card.edition.negative) then
				context.other_card:set_edition({negative = true})
				context.other_card.zhorie = true
			end
		end
		if ((context.change_suit and (context.new_suit ~= 'Diamonds' and context.new_suit ~= 'zero_Brights')) or (context.setting_ability and G.P_CENTERS[context.old].key == "m_wild" and G.P_CENTERS[context.new].key ~= "m_wild")) and context.other_card.edition and context.other_card.edition.negative and context.other_card.zhorie then
			context.other_card:set_edition({base = true})
			context.other_card.zhorie = nil
		end
	end,
	pronouns = "he_him"
}

SMODS.Joker {
    key = "hartwell",
	atlas = "zero_jokers",
    pos = { x = 6, y = 2 },
	soul_pos = { x = 6, y = 3 },
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
	unlocked = true,
	discovered = true,
	config = { extra = { repetitions = 2} },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_zero_water
        return { vars = { card.ability.extra.repetitions } }
    end,
	calculate = function(self, card, context)
        if context.beat_boss and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Elemental',
                                key = 'c_zero_water'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_elemental'), colour = G.C.SECONDARY_SET.Elemental },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
		end
		if context.repetition and context.cardarea == G.play then
			local _works = true
			for _, v in pairs(context.scoring_hand) do
				if not v:is_suit("Clubs") then
					_works = false
					break
				end
			end
			if _works then
				return {
					repetitions = card.ability.extra.repetitions
				}
			end
        end
	end,
	pronouns = "she_her"
}

SMODS.Joker {
    key = "eigengrau",
	atlas = "zero_jokers",
    pos = { x = 7, y = 2 },
	soul_pos = { x = 7, y = 3 },
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_zero_cosmos
        return { vars = { colours = {G.C.SUITS.zero_Brights} } }
    end,
	add_to_deck = function(self, card, from_debuff)
		for _, v in pairs({'A', 'K', 'Q', 'J', '10', '9', '8', '7', '6', '5', '4', '3', '2'}) do
			SMODS.add_card { set = "Base", area = G.play, rank = v, suit = "zero_Brights" }
		end
		for _, v in pairs(G.play.cards) do
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.05, func = function()
				draw_card(G.play, G.deck, nil, nil, nil, v)
				G.deck:shuffle()
			return true end }))
		end
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.5, blocking = false, func = function()
			G.deck:shuffle()
		return true end }))
	end,
	calculate = function(self, card, context)
        if context.beat_boss and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Elemental',
                                key = 'c_zero_cosmos'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_elemental'), colour = G.C.SECONDARY_SET.Elemental },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
		end
		if context.joker_main then
			local brights = 0
			local nonbrights = 0
			for k,v in ipairs(G.playing_cards) do
				if v:is_suit("zero_Brights") then
					brights = brights + 1
				else
					nonbrights = nonbrights + 1
				end
			end
			if brights == 0 or nonbrights == 0 then return end
			local total_cards = brights + nonbrights
			local total_value = hand_chips + mult
			return {
				message = localize('k_ratioed_ex'),
				mult_mod = -mult + total_value * (nonbrights / total_cards),
				chip_mod = -hand_chips + total_value * (brights / total_cards),
			}
		end
	end,
	pronouns = "any_all"
}

SMODS.Joker {
    key = "lovejoy",
	atlas = "zero_jokers",
    pos = { x = 8, y = 2 },
	soul_pos = { x = 8, y = 3 },
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
	unlocked = true,
	discovered = true,
	config = { extra = { xmult = 1, xmult_mod = 0.5 } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_zero_fire
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod } }
    end,
	calculate = function(self, card, context)
        if context.beat_boss and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Elemental',
                                key = 'c_zero_fire'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_elemental'), colour = G.C.SECONDARY_SET.Elemental },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
		end
		if context.remove_playing_cards and not context.blueprint then
            local _hearts = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_suit("Hearts") then _hearts = _hearts + 1 end
            end
            if _hearts > 0 then
                card.ability.extra.xmult = card.ability.extra.xmult + _hearts * card.ability.extra.xmult_mod
                return { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
	end,
	pronouns = "they_them"
}

SMODS.Joker {
    key = "skye", --A dubious little creature, getting up to mischief. This is no good.
	atlas = "zero_jokers",
    pos = { x = 9, y = 2 },
	soul_pos = { x = 9, y = 3 },
    rarity = 4,
    blueprint_compat = true,
    cost = 20,
	unlocked = true,
	discovered = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.c_zero_earth
    end,
	calculate = function(self, card, context)
        if context.beat_boss and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Elemental',
                                key = 'c_zero_earth'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_elemental'), colour = G.C.SECONDARY_SET.Elemental },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
		end
		if context.check_enhancement and context.other_card.config.center.key ~= "c_base" then
			local ret = {}
			for _, w in pairs({G.hand.cards, G.play.cards}) do
				for _, v in pairs(w) do
					if v ~= context.other_card and v.config.center.key ~= "c_base" then
						ret[v.config.center.key] = true
					end
				end
			end
			return ret
		end
	end,
	pronouns = "any_all"
}

--patron jokers
SMODS.Rarity({
	key = "patron",
	loc_txt = {name = "Patron"},
	badge_colour = SMODS.Gradients.zero_patron
})

SMODS.Joker {
    key = "mizzo",
	atlas = "zero_patrons",
    pos = { x = 0, y = 0 },
	soul_pos = { x = 0, y = 1 },
    rarity = "zero_patron",
    cost = 20,
	unlocked = false,
	config = { extra = { hands = {} } },
	calculate = function(self, card, context)
		if context.using_consumeable and ((context.consumeable.ability.set == "Planet" and context.consumeable.ability.hand_type) or context.consumeable.config.center.key == "c_black_hole") then
			local to_upgrade
			local times
			if context.consumeable.ability.hand_type then
				card.ability.extra.hands[context.consumeable.ability.hand_type] = (card.ability.extra.hands[context.consumeable.ability.hand_type] or 0) + 1
				to_upgrade = context.consumeable.ability.hand_type
				times = card.ability.extra.hands[context.consumeable.ability.hand_type]
			else
				card.ability.extra.hands["all"] = (card.ability.extra.hands["all"] or 0) + 1
				times = card.ability.extra.hands["all"]
			end
			SMODS.calculate_effect({ message = localize('k_upgrade_ex') }, card)
            if to_upgrade then
				SMODS.upgrade_poker_hands { hands = to_upgrade, level_up = times, from = card }
			else
				update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
					{ handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						play_sound('tarot1')
						card:juice_up(0.8, 0.5)
						G.TAROT_INTERRUPT_PULSE = true
						return true
					end
				}))
				update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.9,
					func = function()
						play_sound('tarot1')
						card:juice_up(0.8, 0.5)
						return true
					end
				}))
				update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.9,
					func = function()
						play_sound('tarot1')
						card:juice_up(0.8, 0.5)
						G.TAROT_INTERRUPT_PULSE = nil
						return true
					end
				}))
				update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+' .. times })
				delay(1.3)
				SMODS.upgrade_poker_hands({ instant = true, level_up = times })
				update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
					{ mult = 0, chips = 0, handname = '', level = '' })
			end
		end
	end,
	check_for_unlock = function(self, args)
		if args.type == 'win_challenge' and G.GAME.challenge == "c_zero_black_hole_sun" then
			self.challenge_bypass = true
			unlock_card(self)
			discover_card(self)
		end
	end,
	pronouns = "she_any"
}

SMODS.Joker {
    key = "lumistratos",
	atlas = "zero_patrons",
    pos = { x = 1, y = 0 },
	soul_pos = { x = 1, y = 1 },
    rarity = "zero_patron",
    cost = 20,
	unlocked = false,
	config = { extra = { hands = {} } },
	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == "Joker" and context.card ~= card then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
					local card = create_card('Prestige',G.consumeables, nil, nil, nil, nil, nil, 'lumistratos')
					card:add_to_deck()
					G.consumeables:emplace(card)
					G.GAME.consumeable_buffer = 0
					return true
				end)}))
				return {
				message = localize('k_plus_prestige'),
				colour = G.C.SECONDARY_SET.Spectral,
				card = card
				}
			end
		end
	end,
	check_for_unlock = function(self, args)
		if args.type == 'win_challenge' and G.GAME.challenge == "c_zero_edge_of_space" then
			self.challenge_bypass = true
			unlock_card(self)
			discover_card(self)
		end
	end,
	pronouns = "she_they"
}
--[[
SMODS.Joker {
    key = "avide",
	atlas = "zero_patrons",
    pos = { x = 2, y = 0 },
	soul_pos = { x = 2, y = 1 },
    rarity = "zero_patron",
    cost = 20,
	unlocked = false,
	discovered = false,
	
	pronouns = "empty"
}]]