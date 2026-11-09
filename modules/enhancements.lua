SMODS.Atlas {
  key = "zero_enhancers",
  px = 71,
  py = 95,
  path = "zero_enhancers.png"
}

SMODS.Enhancement {
  key = "sunsteel",
  name = "Sunsteel Card",
  config = {
    extra = {
	  xmult = 1.05,
	  xmult_mod = 0.05,
	},
  },
  pos = {x = 0, y = 0},
  atlas = "zero_enhancers",
  unlocked = true,
  discovered = true,
  loc_vars = function(self, info_queue, card)
    return { vars = {
	  card.ability.extra.xmult + (G.GAME.zero_sunsteel_pow or 0),
	  card.ability.extra.xmult_mod + (G.GAME.zero_sunsteel_pow or 0)
	}}
  end,
  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.hand then
	  local val = card.ability.extra.xmult + (G.GAME.zero_sunsteel_pow or 0)
	  for k,v in ipairs(G.hand.cards) do
	    if v ~= card and SMODS.has_enhancement(v, "m_zero_sunsteel") then
		  val = val + card.ability.extra.xmult_mod + (G.GAME.zero_sunsteel_pow or 0)
		end
      end
      return { xmult = val }
	end
  end,
}

SMODS.Enhancement {
  key = "suit_yourself",
  name = "Suit Yourself Card",
  config = {
    extra = {
	  dollars = 8,
	  active = false,
	},
  },
  pos = {x = 1, y = 0},
  atlas = "zero_enhancers",
  unlocked = true,
  discovered = true,
  replace_base_card = true,
  no_rank = true,
  -- they're not actually *any* suit,
  -- so any_suit isn't set to true here
  -- instead, their suitedness is handled
  -- in zero_has_any_regular_suit
  loc_vars = function(self, info_queue, card)
    return { vars = {
	  card.ability.extra.dollars,
	}}
  end,
  calculate = function(self, card, context)
	if context.main_scoring and context.cardarea == G.play then
		local suits = {
			['Hearts'] = 0,
			['Diamonds'] = 0,
			['Spades'] = 0,
			['Clubs'] = 0,
		}
		local wild_or_whatever = 0


		for i = 1, #context.scoring_hand do
			if not zero_has_any_regular_suit(context.scoring_hand[i]) then
				if context.scoring_hand[i]:is_suit('Hearts', true) and suits["Hearts"] == 0 then
					suits["Hearts"] = suits["Hearts"] + 1
				elseif context.scoring_hand[i]:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
					suits["Diamonds"] = suits["Diamonds"] + 1
				elseif context.scoring_hand[i]:is_suit('Spades', true) and suits["Spades"] == 0 then
					suits["Spades"] = suits["Spades"] + 1
				elseif context.scoring_hand[i]:is_suit('Clubs', true) and suits["Clubs"] == 0 then
					suits["Clubs"] = suits["Clubs"] + 1
				end
			else
				wild_or_whatever = wild_or_whatever + 1
			end
		end

		for k,v in pairs(suits) do
			if v == 0 and wild_or_whatever > 0 then
				wild_or_whatever = wild_or_whatever - 1
				suits[k] = v + 1
			end
		end

		if suits["Hearts"] > 0 and suits["Diamonds"] > 0 and
		  suits["Spades"] > 0 and suits["Clubs"] > 0 then
			card.ability.extra.active = true
			return { dollars = card.ability.extra.dollars }
		end

		
	end
	if context.destroy_card == card and card.ability.extra.active then
		return { remove = true }
	end
  end
}

--for debugging reasons i'd recommend to add further enhancements here
--before the key to my he4rt ones, this is because they cannot change
--to another enhancement once you apply them, even with debugplus

SMODS.Enhancement {
  key = "l0ck",
  name = "L0ck Card",
  config = {
  },
  pos = {x = 3, y = 0},
  atlas = "zero_enhancers",
  unlocked = true,
  replace_base_card = true,
  no_rank = true,
  no_suit = true,
  always_scores = true,
  discovered = true,
  loc_vars = function(self, info_queue, card)
	return {
        vars = {"L0ck Card", "K3y Card"},
        key = 'm_zero_l0ck_k3y', set = 'Enhanced',
    }
  end,
  calculate = function(self, card, context)
	if context.debuff_hand then
		for _, v in pairs(context.full_hand) do
			if v.config.center and v.config.center == G.P_CENTERS.m_zero_k3y then
				return
			end
		end
		for _, v in pairs(context.full_hand) do
			if v == card then
				return { debuff = true, debuff_text = localize("k_zero_l0ck_k3y_warning") }
			end
		end
	end
	if context.press_play and G["Keytomyhe4rt_zone"] and #G["Keytomyhe4rt_zone"].cards > 0 then
		local debuffed = true
		for _, v in pairs(G.hand.highlighted) do
			if v.config.center and v.config.center == G.P_CENTERS.m_zero_k3y then
				debuffed = false
			end
		end
		if debuffed == true then return end
		for _, v in pairs(G["Keytomyhe4rt_zone"].cards) do
			local _card = copy_card(v)
			_card:add_to_deck()
			G.play:emplace(_card)
			_card:start_materialize()
			_card.keytomyhe4rt_storage = true
			table.insert(G.playing_cards, _card)
			v:start_dissolve()
		end
	end
	if context.before then
		local count = 0
		for _, v in pairs(context.full_hand) do
			count = count + 1
			if v.config.center and (v.config.center == G.P_CENTERS.m_zero_k3y or v.config.center == G.P_CENTERS.m_zero_l0ck) then
				break
			end
		end
		local _swapped = false
		local _scoring
		for i = 1, #context.full_hand do
			if context.full_hand[i].keytomyhe4rt_storage and i < count then
				_scoring = false
				for j = 1, #context.scoring_hand do
					if context.scoring_hand[j] == context.full_hand[i] then
						_scoring = true
					end
				end
				if _scoring == false then
					context.full_hand[i].keytomyhe4rt_storage = nil
				else
					if _swapped == false then
						_swapped = true
						local swap = context.full_hand[i]
						context.full_hand[i] = context.full_hand[count]
						context.full_hand[count] = swap
					end
				end
			end
		end
		local _found = false
		local open = false
		for _, v in pairs(context.scoring_hand) do
			if v.config.center == G.P_CENTERS.m_zero_k3y then
				_found = true
			end
		end
		if _found == true then
			for _, v in pairs(context.scoring_hand) do
				if open == true and (not v.config.center or (v.config.center ~= G.P_CENTERS.m_zero_l0ck and v.config.center ~= G.P_CENTERS.m_zero_k3y)) then
					v.keytomyhe4rt_storage = true
				elseif v.config.center == G.P_CENTERS.m_zero_k3y or v.config.center == G.P_CENTERS.m_zero_l0ck then
					if open == true then
						open = false
					else
						open = true
					end
				end
			end
		end
	end
--most of this is derivative of how PTA creates new areas to make certain Jokers
--that can copy Jokers that "aren't there" (see cast), thank you Paya!
	if context.destroying_card and context.destroying_card.keytomyhe4rt_storage then
		if not G["Keytomyhe4rt_zone"] then
			G["Keytomyhe4rt_zone"] = CardArea(0, 0, G.CARD_W * 100, G.CARD_H,
				{ card_limit = 1e300, type = 'play', highlight_limit = 0 })
			local playing_cards_storage = G["Keytomyhe4rt_zone"]
			playing_cards_storage.states.visible = false
			playing_cards_storage.states.collide.can = false
			playing_cards_storage.states.focus.can = false
			playing_cards_storage.states.click.can = false
			G.GAME.zero_Keytomyhe4rt_zone = true
		end
		local _card = copy_card(context.destroying_card)
		G["Keytomyhe4rt_zone"]:emplace(_card)
		return {
			remove = true
		}
	end
  end,
  in_pool = function(self)
    return false
  end,
  no_collection = true
}

SMODS.Enhancement {
  key = "k3y",
  name = "K3y Card",
  pos = {x = 4, y = 0},
  atlas = "zero_enhancers",
  unlocked = true,
  replace_base_card = true,
  no_rank = true,
  no_suit = true,
  always_scores = true,
  discovered = true,
  loc_vars = function(self, info_queue, card)
	return {
        vars = {"K3y Card", "L0ck Card"},
        key = 'm_zero_l0ck_k3y', set = 'Enhanced',
    }
  end,
  calculate = function(self, card, context)
	if context.debuff_hand then
		for _, v in pairs(context.full_hand) do
			if v.config.center and v.config.center == G.P_CENTERS.m_zero_l0ck then
				return
			end
		end
		for _, v in pairs(context.full_hand) do
			if v == card then
				return { debuff = true, debuff_text = localize("k_zero_l0ck_k3y_warning") }
			end
		end
	end
  end,
  in_pool = function(self)
    return false
  end,
  no_collection = true
}
