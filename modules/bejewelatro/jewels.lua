SMODS.Atlas {
    key = "zero_jewels",
    px = 55,
    py = 55,
    path = "jewels.png"
}

SMODS.Shader({ key = 'jewel_shine', path = 'jewel_shine.fs' })

-- adds a hidden consumable type (jewels)
SMODS.ConsumableType ({
    key = "jewel",
    primary_colour = HEX("316ea0"),
    secondary_colour = HEX("316ea0"),
    collection_rows = { 3, 4 },
    loc_txt = {},
    default = "c_zero_whitejewel",
    rate = 0,
    can_stack = false,
    can_divide = false,
    can_be_pulled = "b_take",
    no_use_button = true,
    no_collection = true,
})

local jewel_list = {
    'redjewel', 'orangejewel', 'yellowjewel', 'greenjewel', 'bluejewel', 'violetjewel', 'whitejewel',
}
local jewel_list_prism = {
    'redjewel', 'orangejewel', 'yellowjewel', 'greenjewel', 'bluejewel', 'violetjewel',
}
--[[Bejewelatro.weighted_jewel_list = {
    ['redjewel'] = {
        weight = 1,
    },
    ['orangejewel'] = {
        weight = 1,
    },
    ['yellowjewel'] = {
        weight = 1,
    },
    ['greenjewel'] = {
        weight = 1,
    },
    ['bluejewel'] = {
        weight = 1,
    },
    ['violetjewel'] = {
        weight = 1,
    },
    ['whitejewel'] = {
        weight = 1,
    },
}

function Bejewelatro.f.select_weighted_jewel(items)
    local total_weight = 0
    for key, item in ipairs(items) do
        total_weight = total_weight + item.weight
    end
    local random_value = math.random() * total_weight
    for key, item in ipairs(items) do
        random_value = random_value - item.weight
        if random_value <= 0 then
            return key
        end
    end
    return nil 
end]]


for i = 1, #jewel_list do
    SMODS.Consumable({
        set = "jewel",
        key = jewel_list[i],
        pos = { x = i-1, y = 0 },
        atlas = "zero_jewels",
        display_size = { w = 55/1.6, h = 55/1.6 },
        unlocked = true,
        discovered = true,
        --[[draw = function(self, card, layer)
            if card.config.center.discovered or card.bypass_discovery_center then
                card.children.center:draw_shader('zero_jewel_shine', nil, card.ARGS.send_to_shader)
            end
        end,]]
    })
end

-- create row of jewels
function Bejewelatro.f.create_row(row_num, empty)
    Bejewelatro.jewel_rows[row_num] = CardArea(
        0, 0,
        9.5, -- width
        2.5, -- height
        {
            type = 'title_2',
            offset = {
                x = Bejewelatro.board_pos.x - 0,
                y = Bejewelatro.board_pos.y - 2.5,
            },
            major = Bejewelatro.BG, bond = 'weak',
        }
    )
    Bejewelatro.jewel_rows[row_num].CT.x = 4.38 -- horizontal pos
    Bejewelatro.jewel_rows[row_num].CT.y = 2.65 + (row_num-1)*1.07 -- vertical pos

    if not empty then
        for i = 1,8 do
            local jwl_list = next(SMODS.find_card('j_zero_prism')) and jewel_list_prism or jewel_list
            local card_jewel = SMODS.create_card({
                set = 'jewel', 
                area = G.jokers,
                key = 'c_zero_'..pseudorandom_element(jwl_list),
                skip_materialize = true,
            })
            Bejewelatro.jewel_rows[row_num]:emplace(card_jewel)
            card_jewel.position = {x = i, y = row_num}
        end
    end
end

-- fill the board with jewels
function Bejewelatro.f.create_jewels_board(empty)
    for i = 1,8 do
        Bejewelatro.f.create_row(i, empty)
    end
    if not empty then
        Bejewelatro.f.jewel_refill(true)
    end
end

-- destroy all jewels
function Bejewelatro.f.destroy_jewels_board(jewels_only)
    for i = 1,8 do
        for j=8,1,-1 do
            Bejewelatro.jewel_rows[i].cards[j]:remove()
        end
        if not jewels_only then
            Bejewelatro.jewel_rows[i] = nil
        end
    end
end

-- advanced jewel colour checking
function is_jewel_colour(jewel, col, area)
    if area == 'card' then
        if col == 'zero_redjewel' and (jewel.ability['zero_redjewel'] 
        or (next(SMODS.find_card('j_zero_deuteranopia')) and jewel.ability['zero_greenjewel'])) then
            return true
        elseif col == 'zero_orangejewel' and jewel.ability['zero_orangejewel'] then
            return true
        elseif col == 'zero_yellowjewel' and jewel.ability['zero_yellowjewel'] then
            return true
        elseif col == 'zero_greenjewel' and (jewel.ability['zero_greenjewel'] 
        or (next(SMODS.find_card('j_zero_deuteranopia')) and jewel.ability['zero_redjewel'])) then
            return true
        elseif col == 'zero_bluejewel' and (jewel.ability['zero_bluejewel'] 
        or (next(SMODS.find_card('j_zero_deuteranopia')) and jewel.ability['zero_violetjewel']))then
            return true
        elseif col == 'zero_violetjewel' and (jewel.ability['zero_violetjewel'] 
        or (next(SMODS.find_card('j_zero_deuteranopia')) and jewel.ability['zero_bluejewel']))then
            return true
        elseif col == 'zero_whitejewel' and jewel.ability['zero_whitejewel'] then
            return true
        end
        return false
    elseif area == 'board' then
        if col == 'c_zero_redjewel' and (jewel.config.center.key == 'c_zero_redjewel' 
        or (next(SMODS.find_card('j_zero_deuteranopia')) and jewel.config.center.key == 'c_zero_greenjewel')) then
            return true
        elseif col == 'c_zero_orangejewel' and jewel.config.center.key == 'c_zero_orangejewel' then
            return true
        elseif col == 'c_zero_yellowjewel' and jewel.config.center.key == 'c_zero_yellowjewel' then
            return true
        elseif col == 'c_zero_greenjewel' and (jewel.config.center.key == 'c_zero_greenjewel'
        or (next(SMODS.find_card('j_zero_deuteranopia')) and jewel.config.center.key == 'c_zero_redjewel')) then
            return true
        elseif col == 'c_zero_bluejewel' and (jewel.config.center.key == 'c_zero_bluejewel'
        or (next(SMODS.find_card('j_zero_deuteranopia')) and jewel.config.center.key == 'c_zero_violetjewel'))then
            return true
        elseif col == 'c_zero_violetjewel' and (jewel.config.center.key == 'c_zero_violetjewel'
        or (next(SMODS.find_card('j_zero_deuteranopia')) and jewel.config.center.key == 'c_zero_bluejewel'))then
            return true
        elseif col == 'c_zero_whitejewel' and jewel.config.center.key == 'c_zero_whitejewel' then
            return true
        end
        return false
    end
end

function Bejewelatro.f.draw_random_jewelless_card()
    local random_card = nil
    local jewelless_cards = {}
    for k,v in ipairs(G.deck.cards) do
        local is_jewelless = true
        for i=1,#jewel_list do
            if v.ability['zero_'..jewel_list[i]] then
                is_jewelless = false
                break
            end
        end
        if is_jewelless then
            jewelless_cards[#jewelless_cards+1] = v
            break
        end
    end
    random_card = pseudorandom_element(jewelless_cards, pseudoseed('in_deck'))
    local is_in_hand = false
    for k,v in ipairs(G.hand.cards) do
        if v == random_card then
            is_in_hand = true
            break
        end
    end
    if random_card and not random_card.jewel_drawing then
        draw_card(G.deck, G.hand, 90,'up', nil, random_card)
        random_card.jewel_drawing = true
    end
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        blocking = false,
        func = function()
            random_card.jewel_drawing = nil
            return true
        end
    }))
end

-- card emplace 2 - allows for cards to swap positions
function Bejewelatro.f.jewel_swap(card1, card2, destroyed_swap)
    if not card1 or not card2 then return end
    if not destroyed_swap and (card1.getting_destroyed or card2.getting_destroyed) then return end
    card1.states.drag.is = false -- very important
    local x1, y1 = card1.position.x, card1.position.y
    local x2, y2 = card2.position.x, card2.position.y

    card1.position.x, card1.position.y = x2, y2
    card2.position.x, card2.position.y = x1, y1
    Bejewelatro.jewel_rows[y1].cards[x1] = card2
    Bejewelatro.jewel_rows[y2].cards[x2] = card1

    card1:set_card_area(Bejewelatro.jewel_rows[card1.position.y])
    card2:set_card_area(Bejewelatro.jewel_rows[card2.position.y])
end

function Bejewelatro.f.jewel_drag(card1, card2)
    card1:stop_drag()
    G.CONTROLLER:L_cursor_release()
    card1.states.drag.can = false
    card2.states.drag.can = false
    Bejewelatro.f.jewel_swap(card1, card2)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.1*G.SETTINGS.GAMESPEED,
        func = (function() 
            local y1, colours1 = Bejewelatro.f.check_line(function(x)
                return Bejewelatro.jewel_rows[card1.position.y].cards[x] end)
            local y2, colours2 = Bejewelatro.f.check_line(function(x)
                return Bejewelatro.jewel_rows[card2.position.y].cards[x] end)
            local x1, colours3 = Bejewelatro.f.check_line(function(y)
                return Bejewelatro.jewel_rows[y].cards[card1.position.x] end)
            local x2, colours4 = Bejewelatro.f.check_line(function(y)
                return Bejewelatro.jewel_rows[y].cards[card2.position.x] end)
            if y1 or y2 or x1 or x2 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    delay =  0.1*G.SETTINGS.GAMESPEED,
                    func = (function() 
                        for i = 1, 8 do
                            for j = 1, 8 do
                                if Bejewelatro.jewel_rows[i].cards[j].dissolve_target then
                                    Bejewelatro.f.jewel_dissolve(Bejewelatro.jewel_rows[i].cards[j])
                                end
                            end
                        end
                        return true 
                    end)
                }))
                
                local colours_list = { colours1, colours2, colours3, colours4 }
                --[[local drawn_card = nil
                for k,v in pairs(G.playing_cards) do
                    if v.recent_drawn then
                        drawn_card = v
                        v.recent_drawn = nil
                        break
                    end
                end]]
                Bejewelatro.new_colour_list = {}
                for k,v in pairs(colours_list) do
                    for kk, vv in pairs(v) do
                        --if Bejewelatro.drawn_card then Bejewelatro.drawn_card.ability[vv] = true; Bejewelatro.drawn_card = nil end
                        Bejewelatro.new_colour_list[vv] = true
                    end
                end
                
                local jewel_colours_in_deck = {}

                for kk, vv in pairs(Bejewelatro.new_colour_list) do
                    for _, v in ipairs(G.deck.cards) do
                        if kk and v.ability[kk] then
                            jewel_colours_in_deck[#jewel_colours_in_deck+1] = kk
                            break
                        end
                    end
                end

                if #jewel_colours_in_deck > 0 then -- there exists a card in deck with corresponding jewel(s)
                    local valid_jewels = {}
                    local random_jewelled_card = nil
                    for _, v in ipairs(G.deck.cards) do
                        for kk, vv in pairs(Bejewelatro.new_colour_list) do
                            if kk and v.ability[kk] then
                                valid_jewels[#valid_jewels+1] = v
                                break
                            end
                        end
                    end
                    random_jewelled_card = pseudorandom_element(valid_jewels, pseudoseed('in_deck'))
                    if random_jewelled_card then
                        local new_colour_list_length = 0
                        for kk, vv in pairs(Bejewelatro.new_colour_list) do
                            if Bejewelatro.new_colour_list[kk] then
                                new_colour_list_length = new_colour_list_length + 1
                            end
                        end
                        if new_colour_list_length >= 2 then -- add multijewel to card if multiple jewels was matched
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                blockable = false,
                                func = (function() 
                                    for kk, vv in pairs(Bejewelatro.new_colour_list) do
                                        random_jewelled_card.ability[kk] = true
                                        G.GAME.blind:debuff_card(random_jewelled_card)
                                    end
                                    return true 
                                end)
                            }))
                        end
                        if #G.hand.cards < G.hand.config.card_limit then
                            draw_card(G.deck, G.hand, 90,'up', nil, random_jewelled_card)
                        else
                            local leftmost_card = nil
                            for k,v in ipairs(G.hand.cards) do
                                local is_jewelless = true
                                for i=1,#jewel_list do
                                    if v.ability['zero_'..jewel_list[i]] then
                                        is_jewelless = false
                                        break
                                    end
                                end
                                if is_jewelless then
                                    leftmost_card = v
                                    break
                                end
                            end
                            if leftmost_card then
                                draw_card(G.hand, G.deck, 90,'up', nil, leftmost_card)
                                draw_card(G.deck, G.hand, 90,'up', nil, random_jewelled_card)
                            end
                        end
                        Bejewelatro.draw_multijewel = nil
                    end

                else -- no cards in deck have a corresponding jewel
                    local leftmost_card = nil
                    for k,v in ipairs(G.hand.cards) do
                        local is_jewelless = true
                        for i=1,#jewel_list do
                            if v.ability['zero_'..jewel_list[i]] then
                                is_jewelless = false
                                break
                            end
                        end
                        if is_jewelless then
                            leftmost_card = v
                            break
                        end
                    end
                    if leftmost_card then
                        for k,v in pairs(Bejewelatro.new_colour_list) do
                            leftmost_card.ability[k] = true
                            G.GAME.blind:debuff_card(leftmost_card)
                            leftmost_card:juice_up()
                        end
                    end

                    if #G.hand.cards < G.hand.config.card_limit then
                        Bejewelatro.f.draw_random_jewelless_card()
                    end
                end

                card1.states.drag.can = true
                card2.states.drag.can = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blockable = false,
                    delay =  0.2*G.SETTINGS.GAMESPEED,
                    func = (function() 
                        Bejewelatro.f.jewel_refill()
                        return true 
                    end)
                }))
            else
                Bejewelatro.f.jewel_swap(card2, card1)
                card1.states.drag.can = true
                card2.states.drag.can = true
            end
            return true 
        end)
    }))
end

-- CARD DRAGGING 
local mouse_x, mouse_y = nil, nil
local mouse_dx, mouse_dy = 0, 0
local tracked_card = nil
local gamescale = G.TILESCALE*G.TILESIZE
local req_dist = 0.75

-- hooks update to determine the mouse cursor's change in position after clicking a jewel
local ref = love.update
function love.update(dt)
    ref(dt)
    if tracked_card and mouse_x then
        mouse_dx = (love.mouse.getX() - mouse_x)/gamescale
        mouse_dy = (love.mouse.getY() - mouse_y)/gamescale
    end
    if tracked_card and not (tracked_card and tracked_card.states.drag.is) then
        mouse_x, mouse_y = nil, nil
        tracked_card = nil
    end
end

-- hooks card dragging - calls functions when moved too far
local drag_ref = Moveable.drag
function Moveable:drag(offset)
    if self and self.ability and self.ability.set == 'jewel' then
        if self.getting_destroyed then return end
        if not self.position or not Bejewelatro.jewel_rows[self.position.y] then
            return
        end
        if not tracked_card then
            tracked_card = self
            mouse_x, mouse_y = love.mouse.getPosition()
            mouse_dx = 0
            mouse_dy = 0
        end
        local row = Bejewelatro.jewel_rows[self.position.y]
        if math.abs(mouse_dy) < req_dist then
            if mouse_dx > req_dist and self.position.x < 8 then -- when a jewel is dragged right
                if G.GAME.blind.config.blind.key == 'bl_zero_thedescent' and G.GAME.blind.disabled == false then
                    SMODS.juice_up_blind()
                    play_sound('cancel', 0.7 + 0.05, 0.7)
                    G.CONTROLLER:L_cursor_release()
                else
                    local other_jewel = row.cards[self.position.x + 1]
                    Bejewelatro.f.jewel_drag(self, other_jewel)
                end
            elseif mouse_dx < -req_dist and self.position.x > 1 then -- when a jewel is dragged left
                if G.GAME.blind.config.blind.key == 'bl_zero_thedescent' and G.GAME.blind.disabled == false then
                    SMODS.juice_up_blind()
                    play_sound('cancel', 0.7 + 0.05, 0.7)
                    G.CONTROLLER:L_cursor_release()
                else
                    local other_jewel = row.cards[self.position.x - 1]
                    Bejewelatro.f.jewel_drag(self, other_jewel)
                end
            end
        end
        if math.abs(mouse_dx) < req_dist then
            if mouse_dy > req_dist and self.position.y < 8 then -- when a jewel is dragged down
                if G.GAME.blind.config.blind.key == 'bl_zero_thepanel' and G.GAME.blind.disabled == false then
                    SMODS.juice_up_blind()
                    play_sound('cancel', 0.7 + 0.05, 0.7)
                    G.CONTROLLER:L_cursor_release()
                else
                    local other_jewel = Bejewelatro.jewel_rows[self.position.y + 1].cards[self.position.x]
                    Bejewelatro.f.jewel_drag(self, other_jewel)
                end
            elseif mouse_dy < -req_dist and self.position.y > 1 then -- when a jewel is dragged up
                if G.GAME.blind.config.blind.key == 'bl_zero_thepanel' and G.GAME.blind.disabled == false then
                    SMODS.juice_up_blind()
                    play_sound('cancel', 0.7 + 0.05, 0.7)
                    G.CONTROLLER:L_cursor_release()
                else
                    local other_jewel = Bejewelatro.jewel_rows[self.position.y - 1].cards[self.position.x]
                    Bejewelatro.f.jewel_drag(self, other_jewel)
                end
            end
        end
        if not next(SMODS.find_card('j_zero_hypotenusejoker')) then
            if math.abs(mouse_dx) > req_dist and math.abs(mouse_dy) > req_dist then -- when a jewel is dragged too far diagonally
                G.CONTROLLER:L_cursor_release()
            end
        elseif math.abs(mouse_dx) < req_dist and math.abs(mouse_dy) < req_dist then
            if mouse_dy > req_dist/2 and mouse_dx > req_dist/2 and self.position.x < 8 and self.position.y < 8 then
                -- when a jewel is dragged down-right
                local other_jewel = Bejewelatro.jewel_rows[self.position.y + 1].cards[self.position.x + 1]
                Bejewelatro.f.jewel_drag(self, other_jewel)
            elseif mouse_dy > req_dist/2 and mouse_dx < -req_dist/2 and self.position.x > 1 and self.position.y < 8 then
                -- when a jewel is dragged down-left
                local other_jewel = Bejewelatro.jewel_rows[self.position.y + 1].cards[self.position.x - 1]
                Bejewelatro.f.jewel_drag(self, other_jewel)
            elseif mouse_dy < -req_dist/2 and mouse_dx > req_dist/2 and self.position.x < 8 and self.position.y > 1 then
                -- when a jewel is dragged up-right
                local other_jewel = Bejewelatro.jewel_rows[self.position.y - 1].cards[self.position.x + 1]
                Bejewelatro.f.jewel_drag(self, other_jewel)
            elseif mouse_dy < -req_dist/2 and mouse_dx < -req_dist/2 and self.position.x > 1 and self.position.y > 1 then
                -- when a jewel is dragged up-left
                local other_jewel = Bejewelatro.jewel_rows[self.position.y - 1].cards[self.position.x - 1]
                Bejewelatro.f.jewel_drag(self, other_jewel)
            end
        end
    else
        drag_ref(self, offset)
    end
end

-- hooks card hovering - hides ui and plays a different sfx
local hover_ref = Card.hover
function Card:hover()
    if self and self.ability and self.ability.set == 'jewel' then
        self:juice_up(0.05, 0.03)
        play_sound('paper1', math.random()*0.2 + 0.9, 0.35)
        --play_sound('foil'..math.random(1,2), math.random()*0.2 + 3, 0.35)
    else
        hover_ref(self)
    end
end

function Bejewelatro.f.jewel_dissolve(self) -- dissolve (but not 'remove') jewel
    if self.getting_destroyed then return end
    local dissolve_colours = (type(self.destroyed) == 'table' and self.destroyed.colours) or nil
    local dissolve_time_fac = (type(self.destroyed) == 'table' and self.destroyed.time) or nil
    local dissolve_time = 0.7*1
    self.getting_destroyed = true
    self.dissolve = 0
    self.dissolve_colours = dissolve_colours
        or {G.C.BLACK, G.C.ORANGE, G.C.RED, G.C.GOLD, G.C.JOKER_GREY}
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.01*dissolve_time,
        scale = 0.1,
        speed = 2,
        lifespan = 0.7*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.7*dissolve_time,
        func = (function() childParts:fade(0.3*dissolve_time) return true end)
    }))
    -- play individual destruction sound here
    --[[G.E_MANAGER:add_event(Event({
        blockable = false,
        func = (function()
                play_sound('whoosh2', math.random()*0.2 + 0.9,0.5)
                play_sound('crumple'..math.random(1, 5), math.random()*0.2 + 0.9,0.5)
            return true end)
    }))]]
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  1*dissolve_time,
        func = (function(t) return t end)
    }))
    -- fully remove jewels here
    --[[G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.05*dissolve_time,
        func = (function() self:remove() return true end)
    }))]]
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  1.051*dissolve_time,
    }))
end

function CardArea:emplace_2(card, location) -- properly handle emplace stuff when creating new jewels after board
    self:handle_card_limit(card.ability.card_limit, card.ability.extra_slots_used)
    
    table.insert(self.cards, location, card)

    card:set_card_area(self)
    self:set_ranks()
    self:align_cards()
end

function Bejewelatro.f.jewel_refill(initial) -- drop jewels downward after other jewels have been destroyed
    for i = 8, 1, -1 do -- go through each row bottom to top
        for _, jwl in ipairs(Bejewelatro.jewel_rows[i].cards) do 
            if jwl.getting_destroyed then
                for j = jwl.position.y-1 , 1, -1 do -- go through each jewel above upwards
                    if not Bejewelatro.jewel_rows[j].cards[jwl.position.x].getting_destroyed then
                        Bejewelatro.f.jewel_swap(jwl, Bejewelatro.jewel_rows[j].cards[jwl.position.x], true)
                        break
                    end
                end
            end
        end
    end
    
    local destroy_count = 0
    for i = 8,1,-1 do -- go through each column
        for j = 1,8 do -- go through each row in column
            if Bejewelatro.jewel_rows[j].cards[i] and not Bejewelatro.jewel_rows[j].cards[i].getting_destroyed then
                destroy_count = j - 1
                break
            end
        end
        if destroy_count > 0 then
            
            for j = destroy_count, 1, -1 do -- going upwards, replace dissolved jewels with new jewels
                Bejewelatro.jewel_rows[j].cards[i]:remove()
                local jwl_list = next(SMODS.find_card('j_zero_prism')) and jewel_list_prism or jewel_list
                local card_jewel = SMODS.create_card({
                    set = 'jewel', 
                    area = G.jokers,
                    key = 'c_zero_'..pseudorandom_element(jwl_list),
                    skip_materialize = true,
                })
                Bejewelatro.jewel_rows[j]:emplace_2(card_jewel, i)
                card_jewel.position = {x = i, y = j}
            end
        end
    end

    local combo_destroy_count = 0
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        func = (function() 
            for i = 1, 8 do
                for j = 1, 8 do
                    Bejewelatro.f.check_line(function(y)
                        return Bejewelatro.jewel_rows[y].cards[j]
                    end) 
                    Bejewelatro.f.check_line(function(x)
                        return Bejewelatro.jewel_rows[i].cards[x]
                    end)
                end
            end
            for i = 1, 8 do
                for j = 1, 8 do
                    if Bejewelatro.jewel_rows[i].cards[j].dissolve_target then
                        Bejewelatro.f.jewel_dissolve(Bejewelatro.jewel_rows[i].cards[j])
                        combo_destroy_count = combo_destroy_count + 1
                    end
                end
            end
            --if not initial then
                if combo_destroy_count >= 0 and combo_destroy_count < 5 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        func = (function()
                            play_sound('multhit1', math.random()*0.2 + 1.2,0.8)
                        return true end)
                    }))
                elseif combo_destroy_count > 5 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        func = (function()
                            play_sound('multhit2', math.random()*0.2 + 1.2,0.8)
                        return true end)
                    }))
                end
            --end
            return true 
        end)
    }))
    save_run()
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.1*G.SETTINGS.GAMESPEED,
        func = (function() 
            if combo_destroy_count > 0 then
                Bejewelatro.f.jewel_refill()
            end
            return true 
        end)
    }))
end

function Bejewelatro.f.check_line(get_jewel)
    local valid_move = false
    local flush_colours = {}
    
    for i = 1, 8 do
        
        local jewel = get_jewel(i)
        local colour = jewel.config.center.key
        
        local flush = 1
    
        for j = i + 1, 8 do
            local next_jewel = get_jewel(j)
            --print(is_jewel_colour(next_jewel, colour, 'board'))
            if is_jewel_colour(next_jewel, colour, 'board') then
                flush = flush + 1
            else
                break
            end
        end

        if flush >= 3 then
            table.insert(flush_colours, string.sub(jewel.config.center.key, -1*(#jewel.config.center.key) + 2))
            if not valid_move or flush > valid_move then
                valid_move = flush
            end
            for k = 0, flush - 1 do
                local target = get_jewel(i + k)
                target.dissolve_target = true
            end
        end

    end

    return valid_move, flush_colours
end

local save_run_ref = save_run -- Hooks saving to save the state of all jewels
function save_run()
    if Bejewelatro.jewel_rows and Bejewelatro.jewel_rows[1] and Bejewelatro.jewel_rows[1].cards and Bejewelatro.jewel_rows[1].cards[1] then
        G.GAME.Bejewelatro_jewels = {}
        for row = 1,8 do
            G.GAME.Bejewelatro_jewels[row] = {}
            for jwl = 1,8 do
                G.GAME.Bejewelatro_jewels[row][jwl] = Bejewelatro.jewel_rows[row].cards[jwl].config.center.key
            end
        end
    end
    save_run_ref()
end