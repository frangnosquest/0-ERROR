assert(SMODS.load_file("./modules/logo.lua"))()
assert(SMODS.load_file("./modules/resources.lua"))()
assert(SMODS.load_file("./modules/hooks.lua"))()
assert(SMODS.load_file("./modules/funcs.lua"))()

SMODS.current_mod.optional_features = function()
    return { retrigger_joker = true, post_trigger = true, quantum_enhancements = true, }
end

zero_config = SMODS.current_mod.config
assert(SMODS.load_file("./modules/config_ui.lua"))()

assert(SMODS.load_file("./modules/prestige.lua"))()
assert(SMODS.load_file("./modules/cups.lua"))()
assert(SMODS.load_file("./modules/elemental.lua"))()
assert(SMODS.load_file("./modules/jokers.lua"))()
assert(SMODS.load_file("./modules/tags.lua"))()
assert(SMODS.load_file("./modules/enhancements.lua"))()
assert(SMODS.load_file("./modules/editions.lua"))()
assert(SMODS.load_file("./modules/suits.lua"))()
assert(SMODS.load_file("./modules/tarot.lua"))()
assert(SMODS.load_file("./modules/planet.lua"))()
assert(SMODS.load_file("./modules/spectral.lua"))()
assert(SMODS.load_file("./modules/code_fu.lua"))()
assert(SMODS.load_file("./modules/vouchers.lua"))()
assert(SMODS.load_file("./modules/decks.lua"))()
assert(SMODS.load_file("./modules/secret.lua"))()
assert(SMODS.load_file("./modules/jumpscare.lua"))()

if next(SMODS.find_mod('cardpronouns')) then
	assert(SMODS.load_file("./modules/crossmod/pronouns.lua"))()
end

if next(SMODS.find_mod('Cryptid')) then
	assert(SMODS.load_file("./modules/crossmod/cryptid/vouchers.lua"))()
	assert(SMODS.load_file("./modules/crossmod/cryptid/bg_music.lua"))()
end

assert(SMODS.load_file("./modules/challenges.lua"))()

assert(SMODS.load_file("./modules/ui.lua"))()

assert(SMODS.load_file("./modules/bejewelatro/bejewelatro.lua"))()
print("0 ERROR")