function zero_brights_in_deck()
	if G.deck then
		for k,v in ipairs(G.playing_cards) do
			if v.base.suit == "zero_Brights" and not SMODS.has_no_suit(v) then
				return true
			end
		end
	end
	return false
end

function zero_has_any_regular_suit(card)
	if SMODS.has_no_suit(card) then return false end
	if SMODS.has_any_suit(card) then return true end
	if card.base and card.base.suit == "zero_Brights" then return true end
	if card.zero_secret_bright then
		for k, v in pairs(G.jokers.cards) do
			if v.config.center.key == "j_zero_found_a_star" and v.ability.extra.placed and v.ability.extra.placed == card.zero_secret_bright then
				return true
			end
		end
	end
	-- WARNING may break with quantum enhancements enabled
	-- (hopefully doesnt :fingers_crossed:)
	if SMODS.has_enhancement(card, "m_zero_suit_yourself") then
		return true
	end
	
	return false
end

function zero_cube_shuffle(_table)
	for i = #_table, 2, -1 do
		local j = pseudorandom("dismantled_cube", 1, i)
		_table[i], _table[j] = _table[j], _table[i]
    end
end

--mutation-related functions
-- Returns a list of every valid mutation effect
zero_list_mutation_effects = function(self)
	local ret = {}
	for key,effect in pairs(self.mutation_effects) do
		if type(effect.in_pool) ~= "function" or effect:in_pool() then
			ret[#ret+1] = key
		end
	end
	return ret
end
	
-- Creates a new mutation and places it into the mutations of card
zero_create_mutation = function(self, card, gala)
	local mutations = zero_list_mutation_effects(self)
	
	if gala then
		local mutation = { effect = pseudorandom_element(mutations, "zero_alpine_lily_new_mutation"), value = pseudorandom("zero_alpine_lily_new_value", card.edition.extra.min_new_value, card.edition.extra.max_new_value) }
	
		card.edition.extra.mutations[#card.edition.extra.mutations+1] = mutation
	else
		local mutation = { effect = pseudorandom_element(mutations, "zero_alpine_lily_new_mutation"), value = pseudorandom("zero_alpine_lily_new_value", card.ability.extra.min_new_value, card.ability.extra.max_new_value) }
	
		card.ability.extra.mutations[#card.ability.extra.mutations+1] = mutation
	end
	return mutation
end

zero_mutation_effects = function()
	return SMODS.Centers.j_zero_alpine_lily.mutation_effects
end

zero_ond_score = function(card)
	local effects = zero_mutation_effects()
	local ret
	local tail
	for _, mutation in ipairs(card.ability.zero_ond.mutations) do
		local effect = effects[mutation.effect]
		if effect and type(effect.calculate) == "function" then
			local result = effect:calculate(card, mutation.value)
			if tail then
				tail.extra = result
			else
				ret = result
			end
			tail = result
		end
	end
	return ret
end

zero_ond_mutate = function(self, ond, target)
	local extra = ond.ability.extra
	local odds_list = { "new_effect", "lose_effect", "change_effect", "gain_value", "lose_value", "nothing" }
	local total = 0
	for _, v in ipairs(odds_list) do total = total + extra.odds[v] end
	local roll = pseudorandom("zero_ond_roll", 1, total)
	local outcome
	for _, v in ipairs(odds_list) do
		if roll <= extra.odds[v] then
			outcome = v
			break
		end
		roll = roll - extra.odds[v]
	end
	local mutations = target.ability.zero_ond.mutations
	if outcome == "lose_effect" and #mutations <= 1 then outcome = "new_effect" end
	local picked = mutations[pseudorandom("zero_ond_pick", 1, #mutations)]
	if outcome == "new_effect" then
		mutations[#mutations + 1] = {
			effect = pseudorandom_element(zero_list_mutation_effects(self), "zero_ond_new_effect"),
			value = pseudorandom("zero_ond_new_value", extra.min_new_value, extra.max_new_value)
		}
	elseif outcome == "lose_effect" then
		table.remove(mutations, pseudorandom("zero_ond_lose_effect", 1, #mutations))
	elseif outcome == "change_effect" then
		picked.effect = pseudorandom_element(zero_list_mutation_effects(self), "zero_ond_change_effect")
	elseif outcome == "gain_value" then
		picked.value = picked.value + pseudorandom("zero_ond_gain_value", extra.min_gain_value, extra.max_gain_value)
	elseif outcome == "lose_value" then
		picked.value = math.max(0, picked.value - pseudorandom("zero_ond_lose_value", extra.min_lose_value, extra.max_lose_value))
	end
	return "k_" .. outcome .. "_ex"
end

--for lipu suno, compose Toki Pona numerals using luka (5), tu (2), wan (1)
--i need this so that the joker can have dynamic odds like all the others for oops-like effects...
zero_compose_toki_pona = function(number)
    if number <= 0 then return "ala" end
    local parts = {}
    local fives = math.floor(number / 5)
    local remainder = number % 5
    local twos = math.floor(remainder / 2)
    local ones = remainder % 2
    for _ = 1, fives do table.insert(parts, "luka") end
    for _ = 1, twos  do table.insert(parts, "tu")   end
    for _ = 1, ones  do table.insert(parts, "wan")  end
    return table.concat(parts, " ")
end

--for 3trainerpoke and any other future joker that needs to alter joker stats
--checks a card's ability table, compares it the config table of that card's center
--and only changes the values that exist in both, iterates through other tables too
zero_value_multiplier = function(ability, config, multiplier)
	local result = {}
    for key, v in pairs(ability) do
        local filter = config[key]
        if type(v) == "number" then
            if filter then
                result[key] = v * multiplier
            else
                result[key] = v
            end
        elseif type(v) == "table" then
            if type(filter) == "table" then
                result[key] = zero_value_multiplier(v, filter, multiplier)
            else
                result[key] = v
            end
        else
            result[key] = v
        end
    end
	return result
end

--check if a card actually has any editable values
zero_value_compatible = function(ability, config)
	for key, v in pairs(config) do
        local filter = ability[key]
        if type(v) == "number" then
            if filter then
                return true
            end
        elseif type(v) == "table" then
            if type(filter) == "table" then
                return zero_value_compatible(filter, v)
            end
        end
    end
	return false
end

--behold: stupid random function for witness
local bit = require("bit")
function zero_needlesslycomplexrandomchips(seed)
    local t = os.clock() * 10000
    local s = tostring({}):sub(8)
    local why = tonumber(s, 16) or 1
    local x = (seed or math.random())
    x = x * t + why
    x = bit.bxor(x, bit.lshift(x, 1))
    x = bit.bxor(x, bit.rshift(x, 1))
    local y = math.sin(x * 0.000123)
            + math.cos(x * 0.000987)
            + math.tan((x % 314) / 1000)
    local str = tostring(y):reverse() .. tostring(x):sub(1, 6)
    local hash = 0
    for i = 1, #str do
        local b = str:byte(i)
        hash = bit.bxor(hash, b * i * 7919)
        hash = hash % 100000
    end
    local final = ((hash * 37) % 149) + 1
    return final
end

