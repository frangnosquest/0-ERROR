CardPronouns.Pronoun {
	colour = HEX("99E0E8"),
	text_colour = G.C.WHITE,
	pronoun_table = { "mirror :P" },
	in_pool = function()
		return false
	end,
	key = "mirror"
}

CardPronouns.Pronoun {
	colour = HEX("000000"),
	text_colour = G.C.WHITE,
	pronoun_table = { "" },
	in_pool = function()
		return false
	end,
	key = "empty"
}

CardPronouns.Pronoun {
	colour = HEX("948066"),
	text_colour = G.C.WHITE,
	pronoun_table = { "It", "They", "Thon" },
	in_pool = function()
		return false
	end,
	key = "it_they_thon"
}

CardPronouns.Pronoun {
	colour = HEX("FF90FF"),
    text_colour = G.C.WHITE,
    pronoun_table = { "She", "Any" },
	in_pool = function()
		return false
	end,
	key = "she_any"
}