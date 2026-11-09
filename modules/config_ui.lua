SMODS.current_mod.config_tab = function()
    local stake_colour_options = {}

    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
			{n=G.UIT.R, config = {align = 'cm'}, nodes={
                create_toggle({label = "(Spectrum Framework) Force-activate Specflush hand config on startup", ref_table = zero_config, ref_value = 'force_specflush', active_colour = G.C.RED, right = true}),
				create_toggle({label = "(Cryptid) Remix Background Music", ref_table = zero_config, ref_value = 'remix_cryptid_alt_bg_music', active_colour = G.C.BLUE, right = true}),
				create_toggle({label = "Alternate (SFW) soul sprite for Orched, the Incubine", ref_table = zero_config, ref_value = 'sfw_orched', active_colour = G.C.SUITS.Hearts, right = true}),
            }},
    }}
end