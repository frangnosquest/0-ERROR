SMODS.Font {
	key = "pokemon",
	path = "pokemon-font.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 0.9,
	TEXT_OFFSET = { x = 12, y = -24 },
	FONTSCALE = 0.06,
	squish = 1,
	DESCSCALE = 1
}

SMODS.Font {
	key = "pixeldingbats",
	path = "pixel_dingbats-7.ttf",
	render_scale = 200,
	TEXT_HEIGHT_SCALE = 0.9,
	TEXT_OFFSET = { x = 12, y = -24 },
	FONTSCALE = 0.06,
	squish = 1,
	DESCSCALE = 1
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "music_prestige", 
    path = "prestigepack.ogg",
    select_music_track = function() 
        local booster = G.pack_cards and G.pack_cards.cards and SMODS.OPENED_BOOSTER
		if booster and booster.config.center_key:find('p_zero_prestige_') then
			return 1e10
		end
	end
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "music_cups", 
    path = "cupspack.ogg",
    select_music_track = function() 
        local booster = G.pack_cards and G.pack_cards.cards and SMODS.OPENED_BOOSTER
		if booster and booster.config.center_key:find('p_zero_cups_') then
			return 1e10
		end
	end
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "music_elemental", 
    path = "elementalpack.ogg",
    select_music_track = function() 
        local booster = G.pack_cards and G.pack_cards.cards and SMODS.OPENED_BOOSTER
		if booster and booster.config.center_key:find('p_zero_elemental_') then
			return 1e10
		end
	end
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "music_for_soshi", 
    path = "for_soshi.ogg",
	sync = false,
    select_music_track = function() 
        if G.zero_soshi_area and G.zero_soshi_area.cards then
			return 1e10
		end
	end
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "music_all_secrets_revealed", 
    path = "all_secrets_revealed.ogg",
    select_music_track = function() 
        if G.zero_soshi_area and G.zero_secret_unlocks_area and G.zero_secret_unlocks_area[1].cards then
			return 1e10
		end
	end
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "music_silence", 
    path = "silence.ogg",
    select_music_track = function() 
        return next(SMODS.find_card('j_zero_female_symbol')) and 100 or nil
	end
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "galasfx", 
    path = "galasfx.ogg",
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "occultsfx", 
    path = "occultsfx.ogg",
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "sunsteelpow", 
    path = "sunsteelpow.ogg",
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "hoshisaga_chirin", 
    path = "hoshisaga_chirin.ogg",
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "infinity_fanfare", 
    path = "infinity_fanfare.ogg",
}

SMODS.Sound{
     vol = 1.0,
    pitch = 1.0, 
    key = "meow", 
    path = "meow.ogg",
}

SMODS.Shader({
    key = "matrix_badge",
    path = "matrix_badge.fs",
    send_vars = function (element, ...)
        local tile_scale = G.TILESCALE * G.TILESIZE * G.CANV_SCALE
        local vt = {x = element.VT.x, y = element.VT.y, w = element.VT.w, h = element.VT.h}
        vt.x = vt.x + (element.container and element.container.T.x or 0)
        vt.y = vt.y + (element.container and element.container.T.y + 0.018 or 0)
        local pos = {vt.x * tile_scale, vt.y * tile_scale}
        local size = {vt.w * tile_scale, vt.h * tile_scale}
        return {
            badge_pos = pos,
            badge_size = size,
        }
    end
})

local old_create_mod_badges = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    old_create_mod_badges(obj, badges)
    if obj then
        for i = 1, #badges do
            if badges[i].nodes[1].nodes[2].config.object and badges[i].nodes[1].nodes[2].config.object.content and badges[i].nodes[1].nodes[2].config.object.content.string == "0 ERROR" then
                if not obj.no_shader_on_modbadge then
                    badges[i].nodes[1].config.shader = "zero_matrix_badge"
                end
            end
        end
    end
end

SMODS.Shader{
	key = "gala",
	path = "gala.fs"
}

SMODS.Shader{
	key = "occult",
	path = "occult.fs"
}

SMODS.Shader{
	key = "matrix",
	path = "matrix.fs"
}

SMODS.ScreenShader({
	key = 'greyscale',
	path = 'greyscale.fs',
	should_apply = function()
		return next(SMODS.find_card("j_zero_dotdotdotdotdotdot", true))
	end,
})

--Custom Colors
G.C.CUPS = HEX("53468A")
G.C.PRESTIGE = HEX("344245")
G.C.ELEMENTAL = HEX("D16F3E")
G.C.RAINBOW = SMODS.Gradient {
    key = 'rainbow',
    colours = { HEX("FFB0B2"), HEX("FFD7B0"), HEX("FFFAB0"), HEX("BFFFB0"), HEX("B0FFED"), HEX("B0E7FF"), HEX("B0B0FF"), HEX("E0B0FF") }
}
G.C.PATRON = SMODS.Gradient {
    key = 'patron',
    colours = { HEX("0A192F"), HEX("4B0082"), HEX("D4AF37") }
}

local ref_loc_colour = loc_colour
function loc_colour(_c, _default)
    ref_loc_colour(_c, _default)
    G.ARGS.LOC_COLOURS.cups = G.C.CUPS
	G.ARGS.LOC_COLOURS.prestige = G.C.PRESTIGE
	G.ARGS.LOC_COLOURS.elemental = G.C.ELEMENTAL
	G.ARGS.LOC_COLOURS.secret_rare = G.C.RAINBOW
	G.ARGS.LOC_COLOURS.patron = G.C.PATRON
    return G.ARGS.LOC_COLOURS[_c] or _default or G.C.UI.TEXT_DARK
end