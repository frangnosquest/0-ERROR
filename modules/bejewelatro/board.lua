function G.UIDEF.bejewelatro_main()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8.7, minh = 8.7, align = "tm", padding = 0.2, colour = G.C.UI.TRANSPARENT_DARK }, nodes = {
    }}
end

function Bejewelatro.f.drawBG()
    Bejewelatro.BG = UIBox{
        definition = G.UIDEF.bejewelatro_main(),
        config = {align='cm', offset = {
            x=Bejewelatro.board_pos.x - 0.875 ,y=Bejewelatro.board_pos.y - 0.6
        }, major = G.ROOM_ATTACH, bond = 'Weak'}
    }
    Bejewelatro.BG:recalculate()
end

function Bejewelatro.f.board_raise(empty)
    if do_bejewelatro() then
        Bejewelatro.board_visible = true
        Bejewelatro.f.create_jewels_board(empty)
        Bejewelatro.board_pos.y = 20
        G.E_MANAGER:add_event(Event({
            trigger = "ease",
            ease = 'quad',
            delay = 1,
            ref_table = Bejewelatro.board_pos,
            ref_value = "y",
            ease_to = 2.5,
        }))
    end
end

function Bejewelatro.f.board_drop()
    if do_bejewelatro() then
        Bejewelatro.board_pos.y = 2.5
        G.E_MANAGER:add_event(Event({
            trigger = "ease",
            ease = 'quad',
            delay = 1,
            ref_table = Bejewelatro.board_pos,
            ref_value = "y",
            ease_to = 20,
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                Bejewelatro.board_visible = false
                Bejewelatro.f.destroy_jewels_board()
                return true
            end
        }))
    end
end

-- every frame, update the bg
function Bejewelatro.f.update_bg(dt)
    if Bejewelatro.BG then Bejewelatro.BG:remove() end
    Bejewelatro.f.drawBG()
end

-- remove the bg when starting run (removes bg from other decks)
--[[local start_run_ref = Game.start_run
function Game:start_run(args)
    start_run_ref(self, args)
    if args.savetext and G.STATE (not do_bejewelatro()) 
    Bejewelatro.board_visible = false
end]]

local play_cards_from_highlighted_ref = G.FUNCS.play_cards_from_highlighted
function G.FUNCS.play_cards_from_highlighted(e)
    G.E_MANAGER:add_event(Event({
        trigger = "ease",
        ease = 'quad',
        delay = 1,
        ref_table = Bejewelatro.board_pos,
        ref_value = "y",
        ease_to = 9,
    }))
    play_cards_from_highlighted_ref(e)
end

local draw_from_play_to_discard_ref = G.FUNCS.draw_from_play_to_discard
function G.FUNCS.draw_from_play_to_discard(e)
    G.E_MANAGER:add_event(Event({
        trigger = "before",
        func = function()
            draw_from_play_to_discard_ref(e)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        func = function()
            G.E_MANAGER:add_event(Event({
                trigger = "ease",
                ease = 'quad',
                delay = 1,
                ref_table = Bejewelatro.board_pos,
                ref_value = "y",
                ease_to = 2.5,
            }))
            return true
        end
    }))
end

local start_run_ref = Game.start_run
function Game:start_run(args)
    start_run_ref(self, args)
    if not (args and args.savetext) then Bejewelatro.board_pos.y = 20 end
    if G.STATE == G.STATES.SELECTING_HAND and do_bejewelatro() then Bejewelatro.board_visible = true end
end