local loc_stuff = {
  descriptions = {
    Back = {
	  b_zero_sparkling = {
        name = "Sparkling Deck",
        text = {
            "Start run with only a",
            "full set of {V:1}Brights{},",
			"{C:blue}-2{} Hands every round"
        }
      },
	  b_zero_draft = {
        name = "Draft Deck",
        text = {
            "Start run by choosing",
            "{C:attention}1{} of {C:attention}6 Eternal",
			"starting Jokers"
        }
      },
	  b_zero_divine = {
        name = "Divine Deck",
        text = {
            "Start run by choosing",
            "a {C:patron}Patron Joker"
        },
		unlock = {
            "{C:attention}Unlock{} a",
            "{C:patron}Patron Joker",
        }
      },
      b_zero_bejeweled = {
        name = "Bejeweled Deck",
        text = {
          "Make poker hands",
          "with {E:1,C:attention}match 3{C:inactive}..?",
          "{s:0.8,C:red}#1#{s:0.8} hand size, {s:0.8,C:red}+#2#{s:0.8} Discards",
          "{s:0.8}Win after Ante #3#",
        }
      },
      b_zero_blue_bejeweled = {
        name = "Blue Bejeweled Deck",
        text = {
          "Make poker hands",
          "with {E:1,C:attention}match 3{C:inactive}..?",
          "{s:0.8,C:red}#1#{s:0.8} hand size, {s:0.8}Win after Ante #2#{},",
          "Start with 52 {C:attention,T:m_stone}Stone Cards{}",
          "that give only {C:chips}+#3#{} Chips",
        }
      },
    },
    Blind = {
        bl_zero_redjewelblind = {
            name = "The Clover",
            text = {
                "All Red Gem cards",
                "are debuffed",
            },
        },
        bl_zero_orangejewelblind = {
            name = "The Wave",
            text = {
                "All Orange Gem cards",
                "are debuffed",
            },
        },
        bl_zero_yellowjewelblind = {
            name = "The Royalty",
            text = {
                "All Yellow Gem cards",
                "are debuffed",
            },
        },
        bl_zero_greenjewelblind = {
            name = "The Cleave",
            text = {
                "All Green Gem cards",
                "are debuffed",
            },
        },
        bl_zero_bluejewelblind = {
            name = "The Radiance",
            text = {
                "All Blue Gem cards",
                "are debuffed",
            },
        },
        bl_zero_violetjewelblind = {
            name = "The Cost",
            text = {
                "All Violet Gem cards",
                "are debuffed",
            },
        },
        bl_zero_whitejewelblind = {
            name = "The Ink",
            text = {
                "All White Gem cards",
                "are debuffed",
            },
        },
        bl_zero_thepanel = {
            name = "The Panel",
            text = {
                "Gems on Board cannot",
                "be moved vertically",
            },
        },
        bl_zero_thedescent = {
            name = "The Descent",
            text = {
                "Gems on Board cannot",
                "be moved horizontally",
            },
        },
    },
    Edition = {
      e_zero_gala = {
        name = "Gala",
        text = {
			"{C:attention}Mutates #1#{} time#2#",
			"at end of round",
			"{s:0.15} ",
        }
      },
	  e_zero_gala_playing_card = {
        name = "Gala",
        text = {
			"{C:attention}Mutates #1#{} time#2#",
			"at end of scoring",
			"{s:0.15} ",
        }
      },
	  e_zero_occult = {
        name = "Occult",
        text = {
			"Rarer {C:attention}Jokers",
			"appear more often"
        }
      },
	},
    Enhanced = {
	  m_wild = {
                name = "Wild Card",
                text = {
                    "Can be used as",
                    "any suit, cannot",
					"be {C:attention}debuffed"
                },
            },
	  m_zero_sunsteel = {
	    name = "Sunsteel Card",
		text = {
		  "{X:mult,C:white}X#1#{} Mult while this card",
		  "stays in hand, increased",
		  "by {X:mult,C:white}X#2#{} for each other",
		  "{C:attention}Sunsteel Card{} held in hand",
		},
	  },
	  m_zero_suit_yourself = {
	    name = "Suit Yourself Card",
		text = {
		  "No rank, counts as",
		  "any regular suit",
		  "If scored with cards of",
		  "each regular suit, earns",
		  "{C:money}$#1#{} then {E:2,C:red}self destructs",
		},
	  },
	  m_zero_l0ck = {
	    name = "L0ck Card",
	  },
	  m_zero_k3y = {
	    name = "K3y Card",
	  },
	  m_zero_l0ck_k3y = {
	    name = "#1#",
		text = {
		  "{C:attention}Immutable{}, must be played",
		  "with {C:attention}#2#{}, all scoring ",
		  "cards between the two are",
		  "{C:attention}stored{} until played again"
		},
	  },
	},
	Tag = {
	  tag_zero_crispr = {
	    name = "CRISPR Tag",
		text = {
          "Gives a free",
          "{X:prestige,C:white}Mega{} {X:prestige,C:white}Prestige{} {X:prestige,C:white}Pack",
		},
	  },
	  tag_zero_chalice = {
	    name = "Chalice Tag",
		text = {
          "Gives a free",
          "{C:cups}Mega Cups Pack",
		},
	  },
	  tag_zero_alchemical = {
	    name = "Alchemical Tag",
		text = {
          "Gives a free",
          "{C:elemental}Mega Element Pack",
		},
	  },
	  tag_zero_gala = {
	    name = "Gala Tag",
		text = {
          "Next base edition shop",
          "Joker is free and",
          "becomes {C:dark_edition}Gala",
		},
	  },
	  tag_zero_occult = {
	    name = "Occult Tag",
		text = {
          "Next base edition shop",
          "Joker is free and",
          "becomes {C:dark_edition}Occult",
		},
	  },
	},
    Tarot = {
	  c_zero_light = {
	    name = "The Light",
		text = {
          "Converts up to {C:attention}#1#{}",
		  "selected cards to {V:1}#2#{}",
		  "{C:inactive,s:0.7}({V:1,s:0.7}#2#{C:inactive,s:0.7} count as any regular suit)",
		},
	  },
	  c_zero_flame = {
	    name = "The Flame",
		text = {
		  "Enhances {C:attention}#1#",
		  "selected card#3# to",
		  "{C:attention}#2##3#",
		},
	  },
	  c_zero_choice = {
	    name = "The Choice",
		text = {
		  "Enhances {C:attention}#1#",
		  "selected card#3# to",
		  "{C:attention}#2##3#",
		},
	  },
	},
	Planet = {
	  c_zero_ievea = {
	    name = "Iev'ea",
	    text = {
	    	"({V:1}lvl.#1#{}) Level up",
	    	"{C:attention}#2#",
	    	"{C:mult}+#3#{} Mult and",
	    	"{C:chips}+#4#{} chips",
	    },
	  },
	  c_zero_id = {
	       name = "Id",
	    text = {
               "({V:1}lvl.#1#{}) Level up",
               "{C:attention}#2#",
               "{C:mult}+#3#{} Mult and",
               "{C:chips}+#4#{} chips",
           },
	  },
	  c_zero_false_vacuum = {
	       name = "False Vacuum",
	    text = {
               "({V:1}lvl.#1#{}) Level up",
               "{C:attention}#2#",
               "{C:mult}+#3#{} Mult and",
               "{C:chips}+#4#{} chips",
           },
	  },
	  c_zero_everblaze_isles = {
	    name = "Everblaze Isles",
		text = {
           "({V:1}lvl.#1#{}) Level up",
           "{C:attention}#2#",
           "{C:mult}+#3#{} Mult and",
           "{C:chips}+#4#{} chips",
        },
	  },
    c_zero_gemfall = {
	    name = "Gem Fall",
	    text = {
	    	"({V:1}lvl.#1#{}) Level up",
	    	"{C:attention}#2#",
	    	"{C:mult}+#3#{} Mult and",
	    	"{C:chips}+#4#{} chips",
	    },
	  },
    c_zero_spectrum = {
	    name = "Spectrum",
	    text = {
	    	"({V:1}lvl.#1#{}) Level up",
	    	"{C:attention}#2#",
	    	"{C:mult}+#3#{} Mult and",
	    	"{C:chips}+#4#{} chips",
	    },
	  },
    c_zero_coalmine = {
	    name = "Coal Mine",
	    text = {
	    	"({V:1}lvl.#1#{}) Level up",
	    	"{C:attention}#2#",
	    	"{C:mult}+#3#{} Mult and",
	    	"{C:chips}+#4#{} chips",
	    },
	  },
    c_zero_chainreaction = {
	    name = "Chain Reaction",
	    text = {
	    	"({V:1}lvl.#1#{}) Level up",
	    	"{C:attention}#2#",
	    	"{C:mult}+#3#{} Mult and",
	    	"{C:chips}+#4#{} chips",
	    },
	  },
    c_zero_arsenal = {
	    name = "Arsenal",
	    text = {
	    	"({V:1}lvl.#1#{}) Level up",
	    	"{C:attention}#2#",
	    	"{C:mult}+#3#{} Mult and",
	    	"{C:chips}+#4#{} chips",
	    },
	  },
    c_zero_firestorm = {
	    name = "Firestorm",
	    text = {
	    	"({V:1}lvl.#1#{}) Level up",
	    	"{C:attention}#2#",
	    	"{C:mult}+#3#{} Mult and",
	    	"{C:chips}+#4#{} chips",
	    },
	  },
    c_zero_preserver = {
	    name = "Preserver",
	    text = {
	    	"({V:1}lvl.#1#{}) Level up",
	    	"{C:attention}#2#",
	    	"{C:mult}+#3#{} Mult and",
	    	"{C:chips}+#4#{} chips",
	    },
	  },
	},
	Spectral = {
        c_zero_philosopher_stone = {
            name = "Philosopher's Stone",
            text = {
                "Combines any number of",
                "cards into a {C:attention}Joker",
                "{C:inactive}(Creating {C:attention}#1#{C:inactive})",
            },
        },
        c_zero_code_fu = {
            name = "Code Fu",
            text = {
                "Creates the {C:attention}best possible{}",
                "card for the current situation",
                "{C:inactive}(Must have room)",
            },
        },
        c_zero_moonstone = {
            name = "Moonstone",
            text = {
                {
                    "Upgrade all {C:zero_raregem}Rare Gems{} by",
                    "their corresponding {C:dark_edition}Scaler{} values",
                },
                {
                    "All cards with {C:attention}any gem{}",
                    "gain bonus {X:chips,C:white}XChips{} based on",
                    "their corresponding {C:zero_raregem}Rare Gem{}'s",
                    "level after upgrading",
                }
            },
        },
    },
    Joker = {
      j_zero_mad = {
        name = "Mutual Assured Destruction",
        text = {
          {
            "Creates a {X:prestige,C:white}Prestige{} card when {C:attention}Blind{}",
            "is beaten on {C:attention}final {C:attention}hand{} of round"
          }
        },
      },
      j_zero_paraquiet = {
        name = "Paraquiet",
        text = {
          {
            "{C:green}#1# in #2#{} chance to reduce the rank",
            "of each {C:attention}played card{}, this joker",
            "gains {C:mult}+#3# Mult{} for each rank lost",
            "{C:inactive}(Currently {C:mult}+#4#{C:inactive} Mult)",
            "{C:inactive}(Cannot reduce ranks past 2)",
          }
        },
      },
      j_zero_e_supercharge = {
        name = "Energy Supercharge",
        text = {
          {
            "Once per round, {C:dark_edition,E:1}use{} this Joker",
            "to add a random {C:red}temporary{} {C:attention}Enhanced",
            "card of each suit to your hand"
          }
        },
      },
      j_zero_awesome_face = {
        name = "Awesome Face",
        text = {
          {
            "{C:dark_edition,E:1}Use{} this Joker to gain",
            "{C:attention}four fifths{} of the blind score",
            "{C:red,E:2}self destructs{}"
          }
        },
      },
      j_zero_perma_monster = {
        name = "Perma-Monster",
        text = {
          {
            "Once per ante, {C:dark_edition,E:1}use{} this Joker",
            "to destroy the {C:attention}leftmost{}",
            "{C:attention}Joker and permanently copy it",
            "{C:inactive}(Currently copying #1#)"
          }
        },
      },
      j_zero_elite_inferno = {
        name = "Elite Inferno",
        text = {
          {
            "Once per ante, {C:dark_edition,E:1}use{} this",
            "Joker to {C:dark_edition,E:1}activate{} it.",
            "{X:mult,C:white}X#2#{} Mult if {C:dark_edition,E:1}active{}",
            "{C:inactive}(Currently {C:attention}#1#{C:inactive})"
          }
        },
      },
      j_zero_defense_removal = {
        name = "Defense Removal",
        text = {
          {
            "Once per ante, {C:dark_edition,E:1}use{} this Joker",
            "to reduce the {C:attention}blind",
            "requirement by three quarters"
          }
        },
      },
      j_zero_dream_book = {
        name = "Dream Book",
        text = {
          {
            "Once per ante, {C:dark_edition,E:1}use{} this Joker to draw ",
            "a card for each card currently in hand,",
            "and get +1 {C:blue}selection {C:red}limit{} until end of round"
          }
        },
      },
      j_zero_brilliance = {
        name = "Brilliance",
        text = {
          {
            "Played {C:attention}Gold Cards{} give",
			"{X:mult,C:white}X#1#{} Mult when scored",
			"Played {C:attention}Steel Cards{}",
			"earn {C:money}$#2#{} when scored",
          }
        },
      },
      j_zero_dragonsthorn = {
        name = "Dragonsthorn",
        text = {
          {
            "Played {C:attention}Sunsteel Cards{}",
			"give {X:mult,C:white}X#1#{} Mult when",
			"scored for each {C:attention}Sunsteel",
			"{C:attention}Card{} in your {C:attention}full deck",
			"{C:inactive}(Currently: {X:mult,C:white}X#2#{C:inactive} Mult)",
          }
        },
      },
	  j_zero_dismantled_cube = {
        name = "Dismantled Cube",
        text = {
          {
			"Sorts Deck",
			"by {C:attention}Suit order",
          }
        },
      },
      j_zero_venture_card = {
        name = "Venture Card",
        text = {
          {
			"Adds a {C:attention}Suit Yourself{}",
			"card to deck when",
			"{C:attention}Blind{} is selected",
          }
        },
      },
      j_zero_alpine_lily = {
        name = "Alpine Lily",
        text = {
          {
			"{C:attention}Mutates #1#{} time#2#",
			"at end of round",
			"{s:0.15} ",
          }
        },
      },
	  j_zero_alpine_lily_mult = {
		text = {
			"{C:mult}+#1#{} Mult",
		},
	  },
	  j_zero_alpine_lily_chips = {
		text = {
			"{C:chips}+#1#{} Chips",
		},
	  },
	  j_zero_alpine_lily_xmult = {
		text = {
			"{X:mult,C:white}X#1#{} Mult",
		},
	  },
	  j_zero_alpine_lily_xchips = {
		text = {
			"{C:white,X:chips}X#1#{} Chips",
		},
	  },
	  j_zero_alpine_lily_dollars = {
		text = {
			"{C:money}+$#1#",
		},
	  },
	  j_zero_despondent_joker = {
        name = "Despondent Joker",
        text = {
          {
			"Played cards with",
            "{V:1}#2#{} suit give",
            "{C:mult}+#1#{} Mult when scored",
          }
        },
      },
	  j_zero_star_sapphire = {
        name = "Star Sapphire",
        text = {
			{
			"Played cards with",
            "{V:1}#1#{} suit randomly",
            "give {C:money}$#2#{}, {X:mult,C:white} X#3# {} Mult,",
            "{C:chips}+#4#{} Chips or {C:mult}+#5#{} Mult",
			"when scored"
          }
        },
      },
	  j_zero_konpeito = {
        name = "Konpeito",
        text = {
			{
			"Consume this and convert",
			"all cards to {V:1}#1#{} when a",
            "{C:attention}5-card{} poker hand is played",
			"{C:inactive,s:0.7}({V:1,s:0.7}#1#{C:inactive,s:0.7} count as any regular suit)",
          }
        },
      },
	  j_zero_mirror_shard = {
        name = "Mirror Shard",
        text = {
			{
			"{C:attention}Glass Cards{} retrigger",
			"adjacent cards"
          }
        },
      },
	  j_zero_queen_sigma = {
        name = "Queen Sigma!",
        text = {
			{
			"{C:green}#2# in #1#{} chance to create",
			"a {C:tarot}Tarot{} card when a {C:attention}Queen{}",
			"is scored, make it {C:dark_edition}Negative{} if",
			"that card's suit is {C:clubs}Clubs{}",
			"{C:inactive,s:0.7}(Chance based on discovered {C:attention,s:0.7}base-game {C:inactive,s:0.7}Jokers)"
          }
        },
      },
	  j_zero_he_has_a_gun = {
        name = "HE HAS A GUN",
        text = {
			{
			"FORCES ALL {C:attention}7S{} TO BE SELECTED",
			"WHEN CARDS ARE DRAWN, {C:attention}7S{} HAVE A",
			"{C:green}#1# IN #2#{} CHANCE TO EARN {C:money}$#3#{}, {C:attention}+1{} CARD",
			"SELECTION LIMIT PER {C:attention}7{} IN HAND"
          }
        },
      },
	  j_zero_lockout = {
        name = "Lockout",
        text = {
			{
			"{C:attention}3{} times per round,",
			"shuffle all cards back",
			"in deck if only possible",
			"hand is a {C:attention}High Card",
			"{C:inactive}({C:attention}#1#{C:inactive}/#2#)"
          }
        },
      },
	  j_zero_female_symbol = {
        name = "{f:zero_pixeldingbats}l{f:zero_pokemon} ♀ .",
        text = {
			{ --oh lawd
			"{f:zero_pixeldingbats}O{f:zero_pokemon}Pl{f:zero_pixeldingbats}A{f:zero_pokemon}yed{f:zero_pixeldingbats}/{C:attention,f:zero_pokemon}Queens{f:zero_pixeldingbats}\"{f:zero_pokemon}gain",
			"{f:zero_pixeldingbats})?{C:attention,f:zero_pokemon}rand{C:attention,f:zero_pixeldingbats}B{C:attention,f:zero_pokemon}m{C:attention,f:zero_pixeldingbats}=CV{C:attention,f:zero_pokemon}nuses{f:zero_pixeldingbats}£l<",
			"{f:zero_pixeldingbats}GJD{f:zero_pokemon}wh{f:zero_pixeldingbats}U{f:zero_pokemon}en{f:zero_pixeldingbats}[{f:zero_pokemon}sc{f:zero_pixeldingbats}UQ{f:zero_pokemon}ed{f:zero_pixeldingbats}QWQW"
          }
        },
      },
	  j_zero_key_he4rt = {
        name = "The Key To My He4rt",
        text = {
			{
			"While owned, add a {C:attention}L0ck Card{}",
			"and a {C:attention}K3y Card{} to deck"
          }
        },
      },
	  j_zero_hater = {
        name = "Hater",
        text = {
			{
			"This Joker gains {C:chips}Chips{} equal to",
			"total sell value of all current",
			"{C:attention}Jokers{} when hand is played",
			"{C:inactive,s:0.7}(Max of {C:chips,s:0.7}+#2#{C:inactive,s:0.7} at once, currently {C:chips,s:0.7}+#1#{C:inactive,s:0.7} Chips)"
          }
        },
      },
	  j_zero_valdi = {
        name = "Valdi",
        text = {
			{
			"Copies ability of {C:attention}Joker{}",
			"to the left {C:attention}#1#{} time#2#,",
			"{C:attention,s:0.7}Upgrades{s:0.7} if a {X:prestige,C:white,s:0.7}Prestige{s:0.7} card is used",
			"",
			"{C:dark_edition,s:0.7}Cooldown{s:0.3,C:attention} {f:6,s:0.55}—{s:0.3,C:attention} {C:attention,s:0.7}#3#"
          }
        },
      },
	  j_zero_valdi_cd = {
        name = "Valdi",
        text = {
			{
			"Copies ability of {C:attention}Joker{}",
			"to the left {C:attention}#1#{} time#2#,",
			"{C:red,s:0.7}Upgrade on cooldown!{}",
			"",
            "{s:0.7}Will become functional",
            "{s:0.7}after {C:attention,s:0.7}#3#{s:0.7} more {X:prestige,C:white,s:0.7}Prestige{s:0.7} use#4#"
          }
        },
      },
	  j_zero_4_h = {
        name = "{f:zero_pokemon}4 h",
        text = {
			{
			"{f:zero_pokemon}Pl{f:zero_pixeldingbats}A{f:zero_pokemon}yed{f:zero_pixeldingbats}W{f:zero_pokemon,C:attention}#1#s{f:zero_pixeldingbats}PkO",
			"{f:zero_pixeldingbats}CP{f:zero_pokemon}Kaf{f:zero_pixeldingbats}S{f:zero_pokemon}Js{f:zero_pixeldingbats}MV{f:zero_pokemon}srt",
			"{f:zero_pokemon,C:attention}#2#",
          }
        },
      },
	  j_zero_prestige_tree = {
        name = "Prestige Tree",
        text = {
			{
			"{C:chips}+#3#{} Chips, {C:mult}+#4#{} Mult,",
			"{C:green}#2# in #1#{} chance to create",
			"another {X:prestige,C:white}Prestige{} card",
			"when one is used"
			}
        },
      },
	  j_zero_ankimo = {
        name = "Ankimo",
        text = {
			{
			"While playing your {C:attention}highest-level",
			"hand above {C:attention}1{}, played cards {C:attention}mutate",
			"this Joker {C:attention}#1#{} time#2# when scored",
			"{C:inactive}(#3#)"
			}
        },
      },
	  j_zero_receipt = {
        name = "Receipt",
        text = {
			{
			"Bought cards gain",
			"{C:money}$#1#{} of {C:attention}sell value"
			}
        },
      },
	  j_zero_playjoke_chips = {
        name = "Playjoke",
        text = {
			{
			"{C:chips}+#1#{} Chips,",
			"{C:dark_edition,E:1}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_mult = {
        name = "Playjoke",
        text = {
			{
			"{C:mult}+#1#{} Mult,",
			"{C:dark_edition,E:1}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_xmult = {
        name = "Playjoke",
        text = {
			{
			"{X:mult,C:white}X#1#{} Mult,",
			"{C:dark_edition,E:1}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_dollars = {
        name = "Playjoke",
        text = {
			{
			"{C:money}+$#1#{},",
			"{C:dark_edition,E:1}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_swap = {
        name = "Playjoke",
        text = {
			{
			"Swap {X:chips,C:white}Chips{} and {X:mult,C:white}Mult{},",
			"{C:dark_edition,E:1}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_enhance = {
        name = "Playjoke",
        text = {
			{
			"Randomly {C:attention}enhance",
			"a card in play,",
			"{C:dark_edition,E:1}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_playjoke_consumable = {
        name = "Playjoke",
        text = {
			{
			"{C:green}#2# in #1#{} chance to create",
			"a random consumable,",
			"{C:dark_edition,E:1}use{} to swap",
			"between modes"
			}
        },
      },
	  j_zero_lipu_suno = {
        name = "lipu suno",
        text = {
			{
			"kipisi tenpo la {C:attention}ante{} e {V:1}lipu suno",
			"{C:inactive}({C:green}#2#{C:inactive} kipisi {C:green}#1#{C:inactive} ken)"
			}
        },
      },
	  j_zero_downx2 = {
        name = "Down Down",
        text = {
			{
			"{C:green}#2# in #1#{} chance",
			"to {C:attention}halve{} all costs",
			"when entering {C:attention}shop"
			}
        },
      },
	  j_zero_sacred_pyre = {
        name = "Sacred Pyre",
        text = {
			{
			"Add a random {C:attention}Sunsteel Card{} to",
			"deck and increase {C:attention}Sunsteel Power",
			"by {X:diamonds,C:white}X#1#{} at end of round,",
			"{C:red,E:2,s:0.9}self destructs{s:0.9} to prevent death once"
			}
        },
      },
	  j_zero_sacred_pyre_resurrected = {
        name = "Sacred Pyre",
        text = {
			{
			"Add a random {C:attention}Sunsteel Card{} to",
			"deck and increase {C:attention}Sunsteel Power",
			"by {X:diamonds,C:white}X#1#{} at end of round,"
			}
        },
      },
	  j_zero_violet_apostrophe_s_vessel = {
        name = "Violet's Vessel",
        text = {
			{
			"Create {C:attention}#2# {C:cups}Cups{} card#3#",
            "when {C:attention}Blind{} is selected,",
			"{X:attention,C:white}X#1#{C:attention} Blind{} size"
			}
        },
      },
	  j_zero_viscount = {
        name = "Viscount",
        text = {
			{
			"{C:cups}Cups{} cards in your",
            "{C:attention}consumable{} area give",
            "{X:red,C:white} X#1# {} Mult",
			}
        },
      },
	  j_zero_qrcode = {
        name = "QR Code",
        text = {
            "{C:chips}+#1#{} Chips for each",
            "{C:attention}0 ERROR{C:attention} Joker{} card",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
        },
      },
	  j_zero_cups_prince = {
        name = "Prince of Cups",
        text = {
            "Create a {C:cups}Cups{} card if",
            "played hand contains",
            "only {C:attention}face{} cards with",
			"the same rank"
        },
      },
	  j_zero_dotdotdotdotdotdot = {
        name = "{f:zero_pokemon}......",
        text = {
			{
			"{f:zero_pixeldingbats}NJG{f:zero_pokemon,X:red,C:white}X#1#{f:zero_pokemon}Mult{f:zero_pixeldingbats}VCM",
			"{f:zero_pixeldingbats}£l<XMNCVBN,Aò",
			"{f:zero_pixeldingbats},AòGBY{f:zero_pokemon,C:diamonds}NO {f:zero_pokemon,C:hearts}REDS{f:zero_pixeldingbats}L"
          }
        },
      },
	  j_zero_damocles = {
        name = "Damocles",
        text = {
            "{C:dark_edition,E:1}Use{} to receive",
			"a {E:1,C:blue}King's Blessing",
			"and a {E:2,C:red}Curse"
        },
      },
	  j_zero_damocles_active = {
        name = "Damocles",
        text = {
            "{C:attention}+#1#{C:blue} free{} card slots",
            "available in shop,",
			"{C:red}forces{} hands per",
			"round to {C:attention}1"
        },
      },
	  j_zero_crux = {
        name = "Crux",
        text = {
            "{C:attention}Transform{} a random {C:attention}consumable",
            "into a {C:planet}Planet{} card for your",
			"most played {C:attention}poker hand{} at",
			"the end of the {C:attention}shop"
        },
      },
	  j_zero_h_poke = {
        name = "{f:zero_pokemon,s:1.5}h POKé",
        text = {
			"{f:zero_pixeldingbats,s:1.5}FESGFDBGJHNFJ",
			"{f:zero_pixeldingbats,s:1.5}NCHLIAIPVINSK",
			"{f:zero_pixeldingbats,s:1.5}SCHWJSRGKVBMO",
			"{f:zero_pixeldingbats,s:1.5}NBXZZWBAFFDJC",
			"{f:zero_pixeldingbats,s:1.5}QMDORROGCVLXA",
			"{f:zero_pixeldingbats,s:1.5}RPMZDPVONWKQE",
			"{f:zero_pixeldingbats,s:1.5}WYBYVJSLYQLYB",
			"{f:zero_pixeldingbats,s:1.5}CCFNUGHGKFOTE",
			"{f:zero_pixeldingbats,s:1.5}ALFDWDYQWHQPZ",
			"{f:zero_pixeldingbats,s:1.5}GRMAZABRKRZZR",
			"{f:zero_pixeldingbats,s:1.5}JQAVAACEGFYJS",
			"{f:zero_pixeldingbats,s:1.5}IZORSHZUNTAKJ",
			"{f:zero_pixeldingbats,s:1.5}DJWMFMNYUETLS",
			"{f:zero_pixeldingbats,s:1.5}IJURGPRGIUNVI",
			"{f:zero_pixeldingbats,s:1.5}KIGBHYOGMIXOK",
			"{f:zero_pixeldingbats,s:1.5}PGAWOFIMZFVSN",
			"{f:zero_pixeldingbats,s:1.5}ZYRSHTQNZUMNB",
			"{f:zero_pixeldingbats,s:1.5}IHKTWFNMEWFBN",
			"{f:zero_pixeldingbats,s:1.5}XLHFHVIKHVSGJ",
			"{f:zero_pixeldingbats,s:1.5}XUJWXORTSZIIY",
			"{f:zero_pixeldingbats,s:1.5}QAVMWUIAGGWBO",
        },
      },
	  j_zero_strange_seeds = {
        name = "Strange Seeds",
        text = {
            "Blooms into a random",
            "{C:green}Magic Plant{} Joker",
			"after {C:attention}#1#{} rounds",
			"{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
        },
      },
	  j_zero_fabled_rose_of_isola = {
        name = {"Fabled Rose of Isola",
				"{s:0.5}Fabled Lemonbush"},
        text = {
			"Extremely valuable, gains {C:money}$#1#{} of",
            "{C:attention}sell value{} at end of round",
        },
      },
	  j_zero_magic_tree_of_fragrance = {
        name = {"Magic Tree of Fragrance",
				"{s:0.5}Fourpetal Maple"},
        text = {
			"{C:green}#2# in #1#{} chance to add a {C:red}Rare",
            "Joker to shop when {C:attention}rerolling"
        },
      },
	  j_zero_golden_berries_of_wealth = {
        name = {"Golden Berries of Wealth",
				"{s:0.5}Aureus Scandens"},
        text = {
			"{X:money,C:white}X#1#{} sell value to",
            "a random Joker"
        },
      },
	  j_zero_rose_of_joy = {
        name = {"Rose of Joy",
				"{s:0.5}Rosaceae Fern"},
        text = {
			"While shopping, {C:attention}selling",
            "a Joker adds {C:attention}2{} cards",
			"to shop"
        },
      },
	  j_zero_fruit_of_life = {
        name = {"Fruit of Life",
				"{s:0.5}Mela Rare Oak"},
        text = {
			"Sell this to create",
            "a {C:dark_edition}Negative{} {C:green}Strange Seeds{},",
			"it blooms in {C:attention}4{} less rounds"
        },
      },
	  j_zero_fruit_of_life_negative = {
        name = {"Fruit of Life",
				"{s:0.5}Mela Rare Oak"},
        text = {
			"Sell this to gain",
			"{C:dark_edition}+1{} Joker slot and create",
            "a {C:dark_edition}Negative{} {C:green}Strange Seeds{},",
			"it blooms in {C:attention}4{} less rounds"
        },
      },
	  j_zero_flower_of_knowledge = {
        name = {"Flower of Knowledge",
				"{s:0.5}Nox Orchid"},
        text = {
			"{C:attention}Removes{} the cap on interest",
			"earned in each round"
        },
      },
	  j_zero_croque_madame = {
        name = "Croque Madame",
        text = {
			"If a Joker is on the right of",
			"this at end of round, consume",
			"this and gain {C:money}${} equal to {C:attention}double",
			"the {C:attention}sell value{} of both"
        },
      },
	  j_zero_lip_balm = {
        name = "Lip Balm",
        text = {
			"Cards cannot be {C:attention}debuffed{},",
			"lasts {C:attention}#1#{} rounds",
        },
      },
	  j_zero_red_sketch = {
        name = "Red Sketch",
        text = {
			"Consumables copy the ability",
			"of rightmost {C:attention}Joker{}, destroy all",
			"consumables at end of round"
        },
      },
	  j_zero_q_triangle = {
        name = "{f:zero_pokemon}Q ▶",
        text = {
			"{f:zero_pixeldingbats}O{f:zero_pokemon,C:attention}H{f:zero_pixeldingbats}RE{f:zero_pokemon}8{f:zero_pixeldingbats}H{f:zero_pokemon}7{f:zero_pixeldingbats}S",
			"{f:zero_pixeldingbats}DHZ{f:zero_pokemon,C:attention}I{f:zero_pixeldingbats}NWAN",
			"{f:zero_pixeldingbats}Y{f:zero_pokemon}1{f:zero_pixeldingbats}GDA{f:zero_pokemon,C:attention}D{f:zero_pixeldingbats}ST",
			"{f:zero_pixeldingbats}IYUGZOO{f:zero_pokemon,C:attention}E{f:zero_pixeldingbats}",
        },
      },
	  j_zero_sharps_bin = {
        name = "Sharps Bin",
        text = {
            "This Joker gains {X:mult,C:white} X#1# {} Mult",
            "when a {C:attention}Glass{} card is added,",
            "destroyed or enhanced",
            "{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
      },
	  j_zero_3trainerpoke = {
        name = "{f:zero_pokemon}3TrainerPoké $",
        text = {
			"{f:zero_pixeldingbats}O{f:zero_pokemon,C:attention}Change{f:zero_pixeldingbats}WMYT{f:zero_pokemon}JokeRight{f:zero_pixeldingbats}YUI",
			"{f:zero_pixeldingbats}MCY{f:zero_pokemon}values{f:zero_pixeldingbats}PQU{f:zero_pokemon,C:red}Randomly{f:zero_pixeldingbats}QOI"
        },
      },
	  j_zero_soda_shake = {
        name = "Soda Shake",
        text = {
			{
			"Gains {C:mult}+#1#{} Mult at end of round.",
			"After {C:attention}#3#{} rounds, {C:green}#4# in #5#{} chance to {C:attention}pop{}",
			"at end of round, creating a random {C:attention}Tag{}",
			"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
          }
        },
      },
	  j_zero_ond = {
        name = "{f:zero_symbols}Ω{}ND",
        text = {
			{
			"{C:attention}Mutates{} a random adjacent",
			"{C:attention}Joker{} at end of round"
          }
        },
      },
	  j_zero_missingno = {
        name = "{f:zero_pokemon}MissingNo.",
        text = {
			"{f:zero_pixeldingbats}OVCH{f:zero_pokemon}ヂャグ{f:zero_pixeldingbats}QEHEDS",
			"{f:zero_pixeldingbats}DS{f:zero_pokemon}�№{f:zero_pixeldingbats}ZINHCWANJ",
			"{f:zero_pixeldingbats}YGZFDBASDS{f:zero_pokemon}?シも",
			"{f:zero_pokemon}PKMN{f:zero_pixeldingbats}IYRMZ{f:zero_pokemon}のほ{f:zero_pixeldingbats}IE",
        },
      },
	  j_zero_portrait_dragee = {
        name = "Dragee's Portrait",
        text = {
			"Draw a {C:attention}Sunsteel Card{} and",
			"immediately {C:attention}score{} it when",
			"a {C:attention}Sunsteel Card{} or a card",
			"with {C:hearts}Heart{} suit scores"
        },
      },
	  j_zero_portrait_lunchalot = {
        name = "Lunchalot's Portrait",
        text = {
			"Retrigger all {C:attention}Gold{} and {C:attention}Steel Cards",
			"{C:inactive}({C:attention}Once{C:inactive} in hand and {C:attention}twice{C:inactive} in play)"
        },
      },
	  j_zero_found_a_star = {
        name = "Found a Star!",
        text = {
			"{C:attention}One{} random card in your",
			"deck is secretly {V:1}#1#",
			"suit, score it to {C:attention}reveal{} it",
			"{C:inactive,s:0.7}({V:1,s:0.7}#2#{C:inactive,s:0.7} count as any regular suit)",
        },
      },
	  j_zero_obsessive_elementation = {
        name = "Obsessive Elementation",
        text = {
			"{C:green}#1# in #2#{} chance for played",
			"cards with a suit to create a",
			"{C:elemental}Basic Element{} card of their",
			"{C:attention}original suit{} when scored"
        },
      },
	  j_zero_e = {
        name = "E",
        text = {
			"This Joker {C:attention}secretly{} chooses",
			"a suit every round and",
			"gains {X:mult,C:white} X#1# {} Mult when a",
			"card of that suit is scored",
			"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)",
        },
      },
	  j_zero_time_walk = {
        name = "Time Walk",
        text = {
			"{C:attention}Ante{} can't change, {C:red,E:2}destroyed",
			"when a total of {C:money}#1#${} is earned",
			"{C:inactive}(Currently {C:money}#2#${C:inactive})",
        },
      },
	  j_zero_dazzles = {
        name = "The Dazzles",
        text = {
			"{C:mult}+#1#{} Mult after {C:attention}#2#{} card#3#",
			"scored, then change to a random",
			"number between {C:attention}1{}, {C:attention}2{}, {C:attention}3{} and {C:attention}6{}",
        },
      },
	  j_zero_cock_king = {
        name = "Cockatrice King",
        text = {
			"Each card held in hand gives",
			"{C:mult}+#1#{} Mult. Once per ante, {C:dark_edition,E:1}use",
			"this Joker to gain {C:attention}+#2#{} hand",
			"size until end of round"
        },
      },
	  j_zero_poison_heal = {
        name = "Poison Heal",
        text = {
			"Once per round, {C:dark_edition,E:1}use{} this",
			"Joker to lose {C:chips}1{} Hand per",
			"round and gain {C:white,X:chips}X#1#{} Chips",
			"{C:inactive}(Currently {C:white,X:chips}X#2#{C:inactive} Chips)",
        },
      },
	  j_zero_stat_wipeout = {
        name = "Stat Wipeout",
        text = {
			"{C:dark_edition,E:1}Use{} this Joker to remove the",
			"{C:attention}Enhancement{} of {C:attention}#3#{} cards and gain",
			"{C:attention}1{} Charge, disables the effects of",
			"{C:attention}Boss Blinds{} at the cost of {C:attention}1{} Charge",
			"{C:inactive}(Currently {C:attention}#1#{C:inactive} Charge#2#)"
			
        },
      },
	  j_zero_holy_symbol = {
        name = "Holy Symbol",
        text = {
			"{C:dark_edition,E:1}Use{} to {C:dark_edition,E:1}activate{}, when {C:dark_edition,E:1}active{}:",
			"all {C:attention}Jokers{} give {C:white,X:chips}X#1#{} Chips,",
			"{E:2,C:red}self destructs{} in {C:attention}#2#{} rounds",
			"{C:inactive}(#3#ctive!)"
        }
      },
    j_zero_gemjimbo = {
        name = "Joker",
        text = {
            "{C:mult}+#1#{} Mult",
        },
      },
    j_zero_gemred = {
        name = "Angry Joker",
        text = {
            "Played cards with",
            "a {C:red}Red Gem{} give",
            "{C:mult}+#1#{} Mult when scored",
        },
      },
    j_zero_gemorange = {
        name = "Hungry Joker",
        text = {
            "Played cards with",
            "an {C:attention}Orange Gem{} give",
            "{C:mult}+#1#{} Mult when scored",
        },
      },
    j_zero_gemyellow = {
        name = "Frugal Joker",
        text = {
            "Played cards with",
            "a {C:gold}Yellow Gem{} give",
            "{C:mult}+#1#{} Mult when scored",
        },
      },
    j_zero_gemgreen = {
        name = "Jealous Joker",
        text = {
            "Played cards with",
            "a {C:green}Green Gem{} give",
            "{C:mult}+#1#{} Mult when scored",
        },
      },
    j_zero_gemblue = {
        name = "Vain Joker",
        text = {
            "Played cards with",
            "a {C:blue}Blue Gem{} give",
            "{C:mult}+#1#{} Mult when scored",
        },
      },
    j_zero_gemviolet = {
        name = "Affectionate Joker",
        text = {
            "Played cards with",
            "a {C:tarot}Violet Gem{} give",
            "{C:mult}+#1#{} Mult when scored",
        },
      },
    j_zero_gemwhite = {
        name = "Sleepy Joker",
        text = {
            "Played cards with",
            "a {C:inactive}White Gem{} give",
            "{C:mult}+#1#{} Mult when scored",
        },
      },
    j_zero_gempair = {
        name = "Ambivalent Joker",
        text = {
            "{C:red}+#1#{} Mult if played",
            "hand contains",
            "a {C:attention}#2#",
        },
      },
    j_zero_gemspectrum = {
        name = "Downtrodden Joker",
        text = {
            "{C:red}+#1#{} Mult if played",
            "hand contains",
            "a {C:attention}#2#",
        },
      },
    j_zero_gemtwopair = {
        name = "Helpless Joker",
        text = {
            "{C:red}+#1#{} Mult if played",
            "hand contains",
            "a {C:attention}#2#",
        },
      },
    j_zero_gemthree = {
        name = "Blithe Joker",
        text = {
            "{C:red}+#1#{} Mult if played",
            "hand contains",
            "a {C:attention}#2#",
        },
      },
    j_zero_gemhouse = {
        name = "Wishy-Washy Joker",
        text = {
            "{C:red}+#1#{} Mult and {C:chips}+#2#{} Chips",
            "if played hand contains",
            "a {C:attention}#3#",
        },
      },
    j_zero_gemfour = {
        name = "Apathetic Joker",
        text = {
            "{C:red}+#1#{} Mult and {C:chips}+#2#{} Chips",
            "if played hand contains",
            "a {C:attention}#3#",
        },
      },
    j_zero_gemflush = {
        name = "Unfeeling Joker",
        text = {
            "{C:red}+#1#{} Mult and {C:chips}+#2#{} Chips",
            "if played hand contains",
            "a {C:attention}#3#",
        },
      },
    j_zero_scarletfire = {
        name = "Scarlet Fire",
        text = {
            "Played cards with",
            "a {C:red}Red Gem{} give",
            "{X:mult,C:white} X#1# {} Mult when scored",
        },
      },
    j_zero_amberstar = {
        name = "Amber Star",
        text = {
            "{C:attention}+#1#{} hand size for",
            "each played card with an ",
            "{C:attention}Orange Gem{} scored {C:attention}this round{}",
            "{C:inactive}(Currently {}{C:attention}+#2#{}{C:inactive} hand size)",
        },
      },
    j_zero_goldentwilight = {
        name = "Golden Twilight",
        text = {
            "{C:green}#1# in #2#{} chance for",  
            "played cards with",
            "a {C:gold}Yellow Gem{} to",
            "give {C:money}$#3#{} when scored",
        },
      },
    j_zero_chartreusespring = {
        name = "Chartreuse Spring",
        text = {
            "{C:green}#1# in #2#{} chance for",  
            "played cards with",
            "a {C:green}Green Gem{} to give",
            "{C:white,X:chips}X#3#{} Chips when scored",
        },
      },
    j_zero_azurewave = {
        name = "Azure Wave",
        text = {
            "Played cards with",
            "a {C:blue}Blue Gem{} give",
            "{C:chips}+#1#{} Chips when scored",
        },
      },
    j_zero_fuschiarose = {
        name = "Fuschia Rose",
        text = {
            "{C:green}#1# in #2#{} chance for",  
            "played cards with",
            "a {C:tarot}Violet Gem{} to create",
            "a {C:cups}Cups{} card when scored",
            "{C:inactive}(Must have room)"
        },
      },
    j_zero_ivorybloom = {
        name = "Ivory Bloom",
        text = {
            "{C:green}#1# in #2#{} chance for",  
            "played cards with",
            "a {C:inactive}White Gem{} to create a",
            "{X:prestige,C:white}Prestige{} card when scored",
            "{C:inactive}(Must have room)"
        },
      },
    j_zero_hypotenusejoker = {
        name = "Hypotenuse",
        text = {
          "Gems on the board",
          "can be moved {C:attention}diagonally{}",
        },
      },
    j_zero_badtrip = {
       name = "Bad Trip",
       text = {
          "Gain {C:red}+#1#{} Discards for",
          "this round if played hand",
          "contains a {C:attention}Spectrum{}", -- this should include non-gem Spectrums
       },
      },
    j_zero_deuteranopia = {
        name = "Deuteranopia",
        text = {
          "{C:red}Red Gems{} and {C:green}Green Gems{}",
          "count as the same gem,",
          "{C:blue}Blue Gems{} and {C:tarot}Violet Gems{} ",
          "count as the same gem",
        },
      },
    j_zero_prism = {
        name = "Prism",
        text = {
          "{C:inactive}White Gems{} no longer",
          "appear on the board",
        },
      },
    j_zero_zxspectrum = {
        name = "ZX Spectrum",
        text = {
            "Earn {C:money}$#1#{} when",
            "a card with {C:attention}2 or more{}",
            "{C:attention}Gems{} is scored",
        },
      },
	  j_zero_rewards_card = {
        name = "Joker Rewards Card",
        text = {
			"Retriggers random {C:attention}Jokers{} and cards in",
			"play, total retriggers equal number of",
			"{C:attention}Gold Stickers{} in your collection",
			"{C:inactive}(Currently {C:attention}#1#{C:inactive})"
			
        },
		unlock = {
            "Win a run on {C:attention}Gold",
            "{C:attention}Stake{} difficulty",
            "with any {C:attention}Joker",
        }
      },
	  j_zero_consortium = {
        name = "Character Consortium",
        text = {
			"When {C:attention}Blind{} is selected,",
            "create {C:attention}#1# {C:blue}Common{C:attention} Jokers",
			"{C:inactive}(Prioritizes {C:dark_edition}Mods{C:inactive} you own no",
            "{C:attention}Jokers {C:inactive}of, must have room)",
        },
      },
	  j_zero_paragon_rod = {
        name = "Paragon Rod",
        text = {
			"{C:dark_edition,E:1}Use{} this Joker to {C:dark_edition,E:1}activate{} it,",
            "if {C:dark_edition,E:1}active{}, combines played hand",
			"into a {C:attention}Joker{} after scoring",
            "{C:red,E:2}self destructs"
        },
      },
	  j_zero_mana_tank = {
        name = "Mana Tank",
        text = {
            "Once per ante, {C:dark_edition,E:1}use{} this",
            "Joker to {C:attention}Recharge{} all other",
            "{C:dark_edition,E:1}Usable Jokers{} you own",
        }
      },
	  j_zero_smoke_bomb = {
        name = "Magic Smoke Bomb",
        text = {
            "Once per ante, {C:dark_edition,E:1}use{} this",
            "Joker to {C:attention}abort{} the current",
            "{C:attention}blind{} and return to shop",
        }
      },
	  j_zero_elemental_fuel = {
        name = "Elemental Fuel",
        text = {
            "Once per ante, {C:dark_edition,E:1}use{} this Joker",
            "to have {C:attention}Enhanced cards{} in hand",
            "spread their {C:attention}Enhancement{}",
            "onto adjacent cards "
        }
      },
	  j_zero_watering_can = {
        name = "Watering Can",
        text = {
            "Once per ante, {C:dark_edition,E:1}use{} this Joker",
            "to fill {C:attention}Joker{} and {C:attention}consumable{} slots",
            "with random {C:attention}consumables"
        }
      },
	  j_zero_fucking_nothing = {
        name = "Wow! It's Fucking Nothing",
        text = {
            "Sets all {C:attention}listed{}",
            "{C:green}probabilities{} to {C:green}0{}"
        }
      },
	  j_zero_kill_this_man = {
        name = "mods, kill this man",
        text = {
            "Gain between {C:money}$#1#{} and {C:money}$#2#",
            "every hand, Gain {C:money}$#3#",
			"when destroyed"
        }
      },
	  j_zero_wall = {
        name = "The Wall",
        text = {
			"{C:attention}+#1#{} consumable slot,",
			"face {C:cups}The Wall{} as an {C:attention}Additional",
			"{C:attention}Blind{} every ante, create a",
            "{C:cups}Cups{} card every time you",
            "play a hand against it",
        },
      },
	  j_zero_witness = {
        name = "Witness",
        text = {
			"Gives {C:green}random {C:chips}Chips{}, but does",
            "so with a bunch of needlessly",
			"complex {C:dark_edition}calculations{} to appear",
			"smarter than it actually is"
        },
      },
	  j_zero_miriam = {
        name = "MIRIAM",
        text = {
			"{C:mult}+#1#{} Mult per {C:attention}discard",
            "used this round",
			"{C:inactive}(currently {C:mult}+#2#{C:inactive} Mult)"
        },
      },
	  j_zero_lola = {
        name = "LOLA",
        text = {
			"This Joker gains {C:chips}+#1#{} Chips",
			"per {C:attention}consecutive{} hand played",
            "without discarding cards",
			"{C:inactive}(currently {C:chips}+#2#{C:inactive} Chips)"
        },
      },
	  j_zero_yixi = {
        name = "Yi Xi",
        text = {
			"{X:mult,C:white}X#1#{} Mult per {C:attention}hand",
            "played this round",
			"{C:inactive}(currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        },
      },
	  j_zero_mai = {
        name = "Mai",
        text = {
			"{X:mult,C:white}X#1#{} Mult on",
            "{C:attention}first hand{} of round"
        },
      },
	  j_zero_dandelion = {
        name = "Dandelion",
        text = {
			"Retrigger {C:attention}adjacent{} Jokers on",
            "{C:attention}first hand{} of round, a random ",
			"card played in that hand becomes",
			"a random {C:attention}non-Face {C:clubs}Club"
        },
      },
	  j_zero_majesty_colors = {
        name = "Majesty of Colors",
        text = {
			"{C:green}#2# in #1#{} chances to create",
            "a random {C:attention}Consumable",
			"if played hand contains",
			"a {C:attention}Spectrum"
        },
      },
	  j_zero_group_photo = {
        name = "Group Photo",
        text = {
			"{C:attention}Face{} cards give {C:white,X:mult}X#1#{} Mult",
            "if played hand contains",
			"a {C:attention}Spectrum"
        },
      },
	  j_zero_vonllery = {
        name = {"Zhorie von Llery",
				"{s:0.5}Sage of Resilience"},
        text = {
			"Creates {C:elemental}Air{} when {C:attention}Boss Blind{} is defeated,",
			"cards with {C:diamonds}Diamond{} suit become",
            "{C:dark_edition}Negative{} as long as you own this Joker",
        },
      },
	  j_zero_hartwell = {
        name = {"Anise Hartwell",
				"{s:0.5}Sage of Reliance"},
        text = {
			"Creates {C:elemental}Water{} when {C:attention}Boss Blind{} is defeated,",
			"retrigger cards in scoring hand {C:attention}#1#{} times if",
            "it's entirely made up of cards with {C:clubs}Club{} suit",
        },
      },
	  j_zero_eigengrau = {
        name = {"Milquetoast Eigengrau",
				"{s:0.5}Sage of Gratification"},
        text = {
			"Adds a full set of {V:1}Brights{} to deck,",
			"creates {C:elemental}Cosmos{} when {C:attention}Boss Blind{} is defeated,",
			"scales {X:chips,C:white}Chips{} and {X:mult,C:white}Mult{} to match ratio of",
			"{V:1}Brights{} and non-{V:1}Brights{} in deck",
			"{C:inactive,s:0.7}({V:1,s:0.7}Brights{C:inactive,s:0.7} count as any regular suit)",
        },
      },
	  j_zero_lovejoy = {
        name = {"Phil Lovejoy",
				"{s:0.5}Sage of Empathy"},
        text = {
			"Creates {C:elemental}Fire{} when {C:attention}Boss Blind{} is defeated",
			"and gains {X:mult,C:white} X#2# {} Mult when a card",
            "with {C:hearts}Heart{} suit is destroyed",
            "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
        },
      },
	  j_zero_skye = {
        name = {"Cottle Skye",
				"{s:0.5}Sage of Wanderlust"},
        text = {
			"Creates {C:elemental}Earth{} when {C:attention}Boss Blind{} is defeated,",
			"{C:attention}Enhanced cards{} are treated as",
            "{C:spades}Spades{} and all other {C:attention}Enhancements",
            "in hand or play",
        },
      },
	  j_zero_mizzo = {
        name = {"Mizzo, the Schwarzschild",
				"{s:0.5}Maiden of Black Holes"},
        text = {
			"Using a {C:planet}Planet{} card {C:attention}upgrades",
			"the hand an extra number of ",
			"times equal to how many times",
			"it was used while owning this"
        },
		unlock = {
            "Beat the",
            "{C:attention}Black Hole Sun",
            "challenge"
        }
      },
	  j_zero_lumistratos = {
        name = {"Lumistratos, the Vast",
				"{s:0.5}Great Lady of Space"},
        text = {
            "Creates a {X:prestige,C:white}Prestige{} card",
            "when a {C:attention}Joker{} is sold"
        },
		unlock = {
            "Beat the",
            "{C:attention}Edge of Space",
            "challenge"
        }
      },
	  j_zero_soshi = {
        name = "Soshi",
        text = {
			"Prevents Death {C:attention}#3#{} time#4#,",
			"{X:mult,C:white}X#2#{} Mult for every time",
			"previous effect activated",
			"{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
			--it also has a secret effect, random person viewing these files :)
        },
		unlock = {
            "Pet Soshi and",
            "discover the",
            "{C:secret_rare}Secret Menu"
        }
      },
	  j_zero_jericho = {
        name = {"Blossom of Jericho",
				"{s:0.5}Iev'a Quixota"},
        text = {
			"Bought cards have a",
			"{C:green}#2# in #1#{} chance of",
			"becoming {C:dark_edition}Negative"
		},
		unlock = {
            "Own all {C:attention}6",
            "{C:green}Magic Plants",
            "at once"
        }
      },
	  j_zero_oulala = {
        name = "OuLaLa",
        text = {
			"{C:mult}+#1#{} Mult before first card scores,",
			"last played card gives {X:mult,C:white}X#2#{} Mult,",
			"{X:mult,C:white}XMult{} equal to difference in {C:attention}digits {X:mult,C:white}Mult",
			"had between first and second trigger"
			
        },
		unlock = {
            "Score {C:dark_edition}Naneinf",
        }
      },
	  j_zero_darkasso = {
        name = "Darkasso",
        text = {
			"{C:attention}+#1#{} consumable slots,",
			"create an {C:dark_edition}Occult {C:tarot}Tarot",
            "card when {C:attention}Blind{} is selected",
            "{C:inactive}(Must have room)"
        },
		unlock = {
            "Find an old {C:attention}password",
			"lost to time"
        }
      },
    },
    Prestige = {
      c_zero_plasmid = {
        name = "Plasmid",
        text = {
          {
            "All future {C:red}+Mult{} triggers",
            "give {C:red}+#1#{} more {C:red}Mult{}",
            "",
            "{C:dark_edition}Scaler{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_antiplasmid = {
        name = "Anti-Plasmid",
        text = {
          {
            "All future {C:chips}+Chips{} triggers",
            "give {C:chips}+#1#{} more {C:chips}Chips{}",
            "",
            "{C:dark_edition}Scaler{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_supercoiledplasmid = {
        name = "Supercoiled Plasmid",
        text = {
          {
            "All future {X:mult,C:white}XMult{} triggers",
            "give {X:mult,C:white}X#1#{} more {X:mult,C:white}XMult{}",
            "",
            "{C:dark_edition}Scaler{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_darkenergy = {
        name = "Dark Energy",
        text = {
          {
            "{C:dark_edition}+#1#{} Joker Slot",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_darkenergy_cd = {
        name = "Dark Energy",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_aicore = {
        name = "AI Core",
        text = {
          {
            "{C:attention}+#1#{C:blue} Hand{} and",
            "{C:red}Discard{} selection limit",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_aicore_cd = {
        name = "AI Core",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_phage = {
        name = "Phage",
        text = {
          {
            "{C:attention}+#1#{} hand size",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_phage_cd = {
        name = "Phage",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_harmonycrystal = {
        name = "Harmony Crystal",
        text = {
          {
            "{C:green}+#1#{} free shop rerolls",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_harmonycrystal_cd = {
        name = "Harmony Crystal",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_artifact = {
        name = "Artifact",
        text = {
          {
            "{C:attention}+#1#{} shop slots",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_artifact_cd = {
        name = "Artifact",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
      c_zero_bloodstone = {
        name = "Blood Stone",
        text = {
          {
            "{C:attention}+#1#{} consumeable slots",
            "",
            "{C:dark_edition}Cooldown{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#2#"
          }
        },
      },
      c_zero_bloodstone_cd = {
        name = "Blood Stone",
        text = {
          {
            "{C:red}On cooldown!{}",
            "",
            "Will become functional",
            "after {C:attention}#1#{} more use#2#"
          }
        },
      },
	},
	Cups = {
	  c_zero_cups_ace = {
        name = "Ace of Cups",
        text = {
          {
          "Converts {C:attention}#1#{} selected card",
		  "to {V:1}#2#{} and creates",
		  "{C:attention}1{} random {C:cups}Cups{} card",
		  "{C:inactive,s:0.7}({V:1,s:0.7}#2#{C:inactive,s:0.7} count as any regular suit)",
          }
        },
      },
	  c_zero_cups_two = {
        name = "Two of Cups",
        text = {
          "Creates a random {X:prestige,C:white}Prestige{}",
          "and {C:planet}Planet{} card",
          "{C:inactive}(Must have room)",
        },
      },
	  c_zero_cups_three = {
        name = "Three of Cups",
        text = {
          {
          "Changes {C:attention}#1#{} enhanced",
		  "cards to {C:attention}Steel{}, {C:attention}Gold{} or",
		  "{C:attention}Sunsteel Cards{} randomly",
          }
        },
      },
	  c_zero_cups_four = {
        name = "Four of Cups",
        text = {
          "Selected card gives away",
          "{C:attention}Enhancement{}, {C:attention}Seal{} and",
          "{C:dark_edition}Edition{} to adjacent cards",
        },
      },
	  c_zero_cups_five = {
        name = "Five of Cups",
        text = {
          "Adds {C:dark_edition}Negative{} to",
          "a random {C:attention}Consumable"
        },
      },
	  c_zero_cups_six = {
        name = "Six of Cups",
        text = {
          "Adds {C:attention}Eternal{} to",
          "a selected Joker",
        },
      },
	  c_zero_cups_seven = {
        name = "Seven of Cups",
        text = {
          "Adds a random {C:attention}Seal{} to",
          "up to {C:attention}#1#{} selected cards",
        },
      },
	  c_zero_cups_eight = {
        name = "Eight of Cups",
        text = {
          "Destroys {C:attention}#1#{} random card#2#",
          "in hand and creates {C:attention}#3#{} cop#4# ",
          "of a random remaining one",
        },
      },
	  c_zero_cups_nine = {
        name = "Nine of Cups",
        text = {
          "Improves {C:attention}#1#{} card#2#",
          "{C:inactive}(determined by already",
		  "{C:inactive}applied {C:attention}modifiers{C:inactive})"
        },
      },
	  c_zero_cups_ten = {
        name = "Ten of Cups",
        text = {
          "{C:green}#2# in #1#{} chance to",
          "create a random",
          "{C:dark_edition}Negative {C:attention}Joker{} card"
        },
      },
	  c_zero_cups_page = {
        name = "Page of Cups",
        text = {
           "Creates a random {f:zero_pokemon}Glitch{C:attention} Joker{},",
           "if you already have one without an",
		   "{C:dark_edition}edition{}, adds {C:dark_edition}Gala{} to it instead",
        },
      },
	  c_zero_cups_knight = {
	    name = "Knight of Cups",
		text = {
		  "Enhances {C:attention}#1#{} selected",
		  "card#3# to {C:attention}#2##3#",
		  "and increases {C:attention}Sunsteel",
		  "{C:attention}Power{} by {X:diamonds,C:white}X#4#"
		},
	  },
	  c_zero_cups_queen = {
	    name = "Queen of Cups",
		text = {
		  "Converts all cards {C:attention}sharing",
		  "a suit with selected card to",
		  "suits that card {C:attention}doesn't have"
		},
	  },
	  c_zero_cups_king = {
	    name = "King of Cups",
		text = {
		  "Gives {C:money}$#1#{} per {C:cups}Cups",
		  "card used this run",
		  "{C:inactive}(currently {C:money}$#2#{C:inactive})"
		},
	  },
    },
	Elemental = {
	  c_zero_fire = {
        name = "Fire",
        text = {
			"Destroys up to",
			"{C:attention}#1#{} selected cards",
			"with {C:hearts}Heart{} suit"
		},
      },
	  c_zero_earth = {
        name = "Earth",
        text = {
			"Converts {C:attention}random{} cards equal",
			"to the number of cards with",
			"{C:spades}Spade{} suit in hand to {C:attention}Stone Cards"
		},
      },
	  c_zero_water = {
        name = "Water",
        text = {
			"Creates up to {C:attention}#1#{}",
            "random {C:attention}consumables",
			"{C:inactive}(Must select {C:attention}#2#{C:inactive} cards with",
            "{C:clubs}Club{C:inactive} suit and have room)",
		},
      },
	  c_zero_air = {
        name = "Air",
        text = {
			"Draws {C:attention}#1#{} cards",
			"with {C:diamonds}Diamond{} suit",
		},
      },
	  c_zero_cosmos = {
        name = "Cosmos",
        text = {
			"{C:attention}Splits{} selected card",
			"with {V:1}Bright{} suit into",
			"all suits it counts as"
		},
      },
	  c_zero_lava = {
        name = {"Lava",
				"{s:0.5}Earth + Fire"},
        text = {
			"Destroys any number of cards",
			"with {C:hearts}Heart{} or {C:spades}Spade{} suit, enhances",
			"an equal number of cards in deck",
			"to {C:attention}Steel{}, {C:attention}Gold{} or {C:attention}Sunsteel Cards"
        },
      },
	  c_zero_forest = {
        name = {"Forest",
				"{s:0.5}Earth + Water"},
        text = {
			"Removes {C:attention}Enhancements{} from up",
			"to {C:attention}#1#{} cards with {C:spades}Spade{} or {C:clubs}Club",
			"suit and creates an equal number",
			"of {C:dark_edition}Negative {C:spectral}Spectral{} cards"
        },
      },
	  c_zero_geyser = {
        name = {"Geyser",
				"{s:0.5}Fire + Water"},
        text = {
			"Destroys any number of cards",
			"with {C:hearts}Heart{} or {C:clubs}Club{} suit and",
			"creates a {C:attention}consumable{} based on",
			"those card's total {C:chips}chip value",
			"{C:inactive}({C:chips}#1#{C:inactive} Chips#2#{C:attention}#3#{C:inactive})"
        },
      },
	  c_zero_lightning = {
        name = {"Lightning",
				"{s:0.5}Air + Fire"},
        text = {
			"Destroys {C:attention}#1#{} random cards",
			"in deck with {C:hearts}Heart{} or {C:diamonds}Diamond",
			"suit, gain {C:money}${} equal to those",
			"card's total {C:chips}chip value"
        },
      },
	  c_zero_rain = {
        name = {"Rain",
				"{s:0.5}Air + Water"},
        text = {
            "Creates a copy of up to",
            "{C:attention}#1#{} selected cards with",
			"{C:diamonds}Diamond{} or {C:clubs}Club{} suit",
            "in your hand",
        },
      },
	  c_zero_tornado = {
        name = {"Tornado",
				"{s:0.5}Air + Earth"},
        text = {
            "Draws {C:attention}#1#{} cards with {C:spades}Spade{}",
			"or {C:diamonds}Diamond{} suit, gives a random",
			"{C:attention}Enhancement{} to any without one"
        },
      },
	  c_zero_star = {
        name = {"Star",
				"{s:0.5}Fire + Cosmos"},
        text = {
            "{C:dark_edition}Merges {C:attention}4{} cards with",
			"different base suits into",
			"a {V:1}Bright{} suit card"
        },
      },
	  c_zero_planets = {
        name = {"Planets",
				"{s:0.5}Earth + Cosmos"},
        text = {
            "Removes {C:attention}Enhancements{} from all",
			"cards in hand and converts",
			"their suit to {V:1}Brights"
        },
      },
	  c_zero_nebulae = {
        name = {"Nebulae",
				"{s:0.5}Water + Cosmos"},
        text = {
            "Creates {C:attention}#1#{} random {V:1}Bright",
			"suit cards with {C:blue}Blue{} and",
			"{C:purple}Purple{} Seals respectively"
        },
      },
	  c_zero_comet = {
        name = {"Comet",
				"{s:0.5}Air + Cosmos"},
        text = {
            "Adds {C:dark_edition}Gala{} effect to {C:attention}#1#",
			"selected card in hand with",
			"{V:1}Bright{} suit, shuffle it in",
			"deck and draw {C:attention}#2#{} cards"
        },
      },
	  c_zero_wild = {
        name = {"Wild",
				"{s:0.5}???"},
        text = {
            "Enhances {C:attention}#1#{} selected cards",
            "to {C:attention}Wild Cards{}, creates {C:attention}2",
            "random {C:elemental}Basic Elements{}",
			"{C:inactive}(Must have room)"
        },
      },
    },
  zero_raregem = {
      raregem = {
          name = {
              "#6#",
          },
          text = {
            {  
                "Select up to {C:attention}#2#{} cards and",
                "replace its gem(s) with {V:1}#1#{}",
                "",
                "{C:dark_edition}Scaler{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#3#",
            },
            {  
                "All cards with {V:1}#1#{}",
                "give {X:chips,C:white}+X#4#{} Chips when scored",
                "",
                "{C:dark_edition}Scaler{s:0.5,C:attention} {f:6,s:0.8}—{s:0.5,C:attention} {C:attention}#5#",
            },
          },
      },
  },
	Voucher = {
	  v_zero_homeworld = {
		name = "Homeworld",
		text = {
			"{X:prestige,C:white}Prestige{} cards may",
			"appear in any of",
			"the {C:attention}Celestial Packs",
        }
	  },
	  v_zero_cataclysm = {
		name = "Cataclysm",
		text = {
			"{X:prestige,C:white}Prestige{} cards reduce",
			"all active {C:dark_edition}Cooldowns",
			"by {C:attention}1{} when used",
        }
	  },
	  v_zero_better_dead_than_red = {
		name = {"Better Dead",
				"than Red"},
		text = {
			"Non-{C:dark_edition}Negative{} {X:prestige,C:white}Prestige{}",
			"cards create a {C:dark_edition}Negative{}",
			"copy when used",
        }
	  },
	  v_zero_overturned = {
		name = "Overturned",
		text = {
			"{C:cups}Cups{} cards can",
			"be purchased",
			"from the shop"
        }
	  },
	  v_zero_fine_wine = {
		name = "Fine Wine",
		text = {
			"Shops after clearing a {C:attention}Blind",
			"with {C:attention}double{} the required",
			"score or more contain an",
			"extra {C:cups}Cups Pack"
        }
	  },
	  v_zero_wine_cellar = {
		name = "Wine Cellar",
		text = {
			"All {C:cups}Cups{} cards and",
			"{C:cups}Cups Packs{} in the",
			"shop are {C:attention}free",
        }
	  },
    },
    Other = {
      p_zero_prestige_normal_1 = {
        name = "Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {X:prestige,C:white}Prestige{} cards",
        }
      },
      p_zero_prestige_normal_2 = {
        name = "Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {X:prestige,C:white}Prestige{} cards",
        }
      },
      p_zero_prestige_jumbo_1 = {
        name = "Jumbo Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {X:prestige,C:white}Prestige{} cards",
        }
      },
      p_zero_prestige_mega_1 = {
        name = "Mega Prestige Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2# {X:prestige,C:white}Prestige{} cards",
        }
      },
	  p_zero_cups_normal_1 = {
        name = "Cups Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:cups} Cups{} cards to",
		  "be used immediately"
        }
      },
      p_zero_cups_normal_2 = {
        name = "Cups Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:cups} Cups{} cards to",
		  "be used immediately"
        }
      },
      p_zero_cups_jumbo_1 = {
        name = "Jumbo Cups Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:cups} Cups{} cards to",
		  "be used immediately"
        }
      },
      p_zero_cups_mega_1 = {
        name = "Mega Cups Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:cups} Cups{} cards to",
		  "be used immediately"
        }
      },
	  p_zero_elemental_normal_1 = {
        name = "Element Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:elemental}Basic Element{} cards to",
		  "add to your consumables"
        }
      },
      p_zero_elemental_normal_2 = {
        name = "Element Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:elemental}Basic Element{} cards to",
		  "add to your consumables"
        }
      },
      p_zero_elemental_jumbo_1 = {
        name = "Jumbo Element Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:elemental}Basic Element{} cards and",
		  "{C:attention}#3#{C:elemental} Greater Element{} card#4# to",
		  "add to your consumables"
        }
      },
      p_zero_elemental_mega_1 = {
        name = "Mega Element Pack",
        text = {
          "Choose {C:attention}#1#{} of up to {C:attention}#2#",
          "{C:elemental}Basic Element{} cards and",
		  "{C:attention}#3#{C:elemental} Greater Element{} card#4# to",
		  "add to your consumables"
        }
      },
      p_zero_raregems_normal_1 = {
        name = "Rare Gem Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:spectral} Rare Gem{} cards to",
		      "be used immediately"
        }
      },
      p_zero_raregems_normal_2 = {
        name = "Rare Gem Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:spectral} Rare Gem{} cards to",
		      "be used immediately"
        }
      },
      p_zero_raregems_jumbo_1 = {
        name = "Jumbo Rare Gem Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:spectral} Rare Gem{} cards to",
		      "be used immediately"
        }
      },
      p_zero_raregems_mega_1 = {
        name = "Mega Rare Gem Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:spectral} Rare Gem{} cards to",
		      "be used immediately"
        }
      },
      scaler_explainer = {
        name = "Scaler",
        text = {
          "When used, increases",
          "all future {X:prestige,C:white}#1#{}'s",
          "strength by {C:attention}#2#"
        }
      },
      scaler_explainer_raregems = {
        name = "Scaler",
        text = {
          "When used, increases",
          "all future {X:zero_raregem,C:white}#1#{}'s",
          "strength by {C:attention}#2#{} and {C:attention}#3#{}",
        }
      },
      cooldown_explainer = {
        name = "Cooldown",
        text = {
          "When used, next {C:attention}#2#{} uses of",
          "{X:prestige,C:white}#1#{} do nothing, and",
          "increases next duration by {C:attention}1"
        }
      },
      phage_effect = {
        name = "Phage",
        text = {
          "{C:attention}+1{} hand size",
        }
      },
      darkenergy_effect = {
        name = "Dark Energy",
        text = {
          "{C:dark_edition}+1{} Joker Slot",
        }
      },
      aicore_effect = {
        name = "AI Core",
        text = {
          "{C:attention}+1{C:blue} Hand{} and",
          "{C:red}Discard{} selection limit",
        }
      },
      harmonycrystal_effect = {
        name = "Harmony Crystal",
        text = {
          "{C:green}+1{} free shop rerolls",
        },
      },
      artifact_effect = {
        name = "Artifact",
        text = {
          "{C:attention}+1{} shop slots",
        },
      },
      bloodstone_effect = {
        name = "Blood Stone",
        text = {
          "{C:attention}+1{} consumeable slot",
        },
      },
	  valdi_effect = {
        name = "Valdi",
        text = {
			"{C:attention}Upgrades{} if a ",
			"{X:prestige,C:white}Prestige{} card is used"
        },
      },
	  zero_brights_blurb = {
        text = {
          "Counts as each",
		  "regular suit",
        },
	  },
	  zero_gala_mult = {
		name = "Gala Mutation",
		text = {
			"{C:mult}+#1#{} Mult",
		},
	  },
	  zero_gala_chips = {
		name = "Gala Mutation",
		text = {
			"{C:chips}+#1#{} Chips",
		},
	  },
	  zero_gala_xmult = {
		name = "Gala Mutation",
		text = {
			"{X:mult,C:white}X#1#{} Mult",
		},
	  },
	  zero_gala_xchips = {
		name = "Gala Mutation",
		text = {
			"{C:white,X:chips}X#1#{} Chips",
		},
	  },
	  zero_gala_dollars = {
		name = "Gala Mutation",
		text = {
			"{C:money}+$#1#",
		},
	  },
	  zero_ond_mult = {
		name = "{f:zero_symbols}Ω{}ND Mutation",
		text = {
			"{C:mult}+#1#{} Mult",
		},
	  },
	  zero_ond_chips = {
		name = "{f:zero_symbols}Ω{}ND Mutation",
		text = {
			"{C:chips}+#1#{} Chips",
		},
	  },
	  zero_ond_xmult = {
		name = "{f:zero_symbols}Ω{}ND Mutation",
		text = {
			"{X:mult,C:white}X#1#{} Mult",
		},
	  },
	  zero_ond_xchips = {
		name = "{f:zero_symbols}Ω{}ND Mutation",
		text = {
			"{C:white,X:chips}X#1#{} Chips",
		},
	  },
	  zero_ond_dollars = {
		name = "{f:zero_symbols}Ω{}ND Mutation",
		text = {
			"{C:money}+$#1#",
		},
	  },
	  zero_lipu_suno_info = {
		name = "mi toki ala e toki pona",
		text = {
			"Scoring {V:1}#3#{} have a",
			"{C:green}#2# in #1#{} chance to",
			"change {C:attention}enhancement"
		},
	  },
	  zero_q_triangle_storage = {
		name = "{f:zero_pokemon}←",
		text = {
			"{f:zero_pokemon,C:attention}#1#"
		},
	  },
	  zero_base_elements_reminder = {
		name = "Elemental Reactions",
		text = {
			"{C:attention}2 {C:elemental}Basic Elements{} combine",
			"into a {C:elemental}Greater Element"
		},
	  },
    zero_redjewel = {
        name = "Red Gem",
        text = {
            "is Red",
        },
    },
    zero_redjewel_xchips = {
        name = "Red Gem",
        text = {
            "{C:white,X:chips}X#1#{} Chips",
        },
    },
    zero_orangejewel = {
        name = "Orange Gem",
        text = {
            "is Orange",
        },
    },
    zero_orangejewel_xchips = {
        name = "Orange Gem",
        text = {
            "{C:white,X:chips}X#1#{} Chips",
        },
    },
    zero_yellowjewel = {
        name = "Yellow Gem",
        text = {
            "is Yellow",
        },
    },
    zero_yellowjewel_xchips = {
        name = "Yellow Gem",
        text = {
            "{C:white,X:chips}X#1#{} Chips",
        },
    },
    zero_greenjewel = {
        name = "Green Gem",
        text = {
            "is Green",
        },
    },
    zero_greenjewel_xchips = {
        name = "Green Gem",
        text = {
            "{C:white,X:chips}X#1#{} Chips",
        },
    },
    zero_bluejewel = {
        name = "Blue Gem",
        text = {
            "is Blue",
        },
    },
    zero_bluejewel_xchips = {
        name = "Blue Gem",
        text = {
            "{C:white,X:chips}X#1#{} Chips",
        },
    },
    zero_violetjewel = {
        name = "Violet Gem",
        text = {
            "is Violet",
        },
    },
    zero_violetjewel_xchips = {
        name = "Violet Gem",
        text = {
            "{C:white,X:chips}X#1#{} Chips",
        },
    },
    zero_whitejewel = {
        name = "White Gem",
        text = {
            "is White",
        },
    },
    zero_whitejewel_xchips = {
        name = "White Gem",
        text = {
            "{C:white,X:chips}X#1#{} Chips",
        },
    },
	  zero_miriam_lola = {
		name = "Synergy!",
		text = {
			"{C:dark_edition}+1{} Joker slot when {C:attention}MIRIAM",
			"and {C:attention}LOLA{} are together"
		},
	  },
	  zero_yixi_mai = {
		name = "Synergy!",
		text = {
			"{C:attention}Yi Xi{} does not reset if",
			"you also own {C:attention}Mai"
		},
	  },
    },
  },
  misc = {
    dictionary = {
      b_zero_absorbed = "DESTROYED",
      k_zero_absorbed_empty = "Nothing destroyed yet",
      b_prestige = "Prestige",
      k_prestige_pack = "Prestige Pack",
	  b_cups = "Cups",
      k_cups_pack = "Cups Pack",
	  b_elemental = "Elemental",
	  k_elemental_base = "Basic Element",
	  k_elemental_mix = "Greater Element",
	  k_elemental_chaotic = "Chaotic Element",
      k_elemental_pack = "Element Pack",
    k_zero_raregem_pack = "Rare Gems Pack",
      k_plus_prestige = "+1 Prestige",
	  k_plus_cups = "+1 Cups",
	  k_plus_elemental = "+1 Element",
	  k_plus_consumeable = "+1 Consumable",
	  k_plus_suit_yourself = "+1 Suit Yourself",
	  k_plus_sunsteel_pow = "+Sunsteel Power",
      k_poisoned_ex = "Poisoned!",
      k_charged_ex = "Charged!",
	  k_pop_ex = "Pop!",
	  k_mutated_ex = "Mutated!",
	  k_new_effect_ex = "New Effect!",
	  k_lose_effect_ex = "Lost Effect!",
	  k_lose_effect_ex = "Lost Effect!",
	  k_change_effect_ex = "Changed Effect!",
	  k_gain_value_ex = "Gained Value!",
	  k_lose_value_ex = "Lost Value!",
	  k_nothing_ex = "Nothing!",
	  k_plus_mutation_ex = "+Mutation!",
	  k_minus_mutation_ex = "-Mutation!",
	  k_impossible_ex = "Impossible!",
	  k_swap_ex = "Swap!",
	  k_enhanced_ex = "Enhanced!",
	  k_discount_ex = "Discount!",
	  k_plus_blessing_ex = "+Blessing!",
	  k_plus_curse_ex = "+Curse!",
	  k_transformed_ex = "Transformed!",
	  k_bloom_ex = "Bloom!",
	  k_plus_shop_ex = "+Shop!",
	  k_sell_value = "Value",
	  k_draw_ex = "Draw!",
	  k_stage_clear_upper = "STAGE CLEAR",
	  k_consumed_ex = "Consumed!",
	  k_zero_l0ck_k3y_warning = "L0ck and K3y card must be played together",
	  k_ratioed_ex = "Ratioed!",
	  k_gift_ex = "Gift!",
	  
	  k_ankimo_nil = "No valid hands",
	  k_ankimo_one = " is in the lead",
	  k_ankimo_two_1 = " and ",
	  k_ankimo_two_2 = " are tied",
	  k_ankimo_multiple = "Multiple hands are tied",

      mult_extra = "Bonus +Mult",
      chips_extra = "Bonus +Chips",
      xmult_extra = "Bonus XMult",
      c_zero_heartstone_xchips = "Red Gem XChips",
      c_zero_citrine_xchips = "Orange Gem XChips",
      c_zero_risingstar_xchips = "Yellow Gem XChips",
      c_zero_stemerald_xchips = "Green Gem XChips",
      c_zero_bluethunder_xchips = "Blue Gem XChips",
      c_zero_highroller_xchips = "Violet Gem XChips",
      c_zero_royalflash_xchips = "White Gem XChips",

      k_no_cooldowns = "No cards are on cooldown",
      k_prestige_cooldowns = "Cards on Cooldown:",
      k_c_zero_phage = "Phage",
      k_c_zero_darkenergy = "Dark Energy",
      k_c_zero_aicore = "AI Core",
      k_c_zero_harmonycrystal = "Harmony Crystal",
      k_c_zero_artifact = "Artifact",
      k_c_zero_bloodstone = "Blood Stone",
	  k_j_zero_valdi = "Valdi",
	  
	  ph_zero_sacred_pyre = "Saved by Sacred Pyre",
	  ph_zero_soshi = "Saved by Soshi",
	  
	  zero_sc_hint_soshi = "A cat might\nhelp you",
	  zero_sc_hint_jericho = "Seek the fabled\nflora 6",
	  zero_sc_hint_oulala = "Infinity is\nsuch a fragile\nthing",
	  zero_sc_hint_ = "The password\nis found where\nAncient Magic\nmeets its end",
    },
	v_dictionary = {
	  zero_absorbed_title = "Destroyed Jokers (#1#)",
	  zero_alpine_lily_mult = "+#1# Mult",
	  zero_alpine_lily_chips = "+#1# Chips",
	  zero_alpine_lily_xmult = "X#1# Mult",
	  zero_alpine_lily_xchips = "X#1# Chips",
	  zero_alpine_lily_dollars = "+$#1#",
    zero_a_discards = "+#1# Discards",
	},
	v_text = {
	  ch_c_zero_no_shop = {"No {C:attention}shops"},
	  ch_c_zero_no_tarots = {"{C:tarot}Tarot{} cards do not appear in the shop"},
	  ch_c_zero_no_planets = {"{C:planet}Planet{} cards do not appear in the shop"},
	  ch_c_zero_level_zero = {"All hands start at level {C:attention}0"},
	  ch_c_zero_patron_unlock = {"Challenge unlocks a {C:patron}Patron Joker"},
	  ch_c_zero_win_ante = {"Beat Ante {C:attention}#1#{} to win"},
	},
	suits_singular = {
	  zero_Brights = "Bright",
	},
	suits_plural = {
	  zero_Brights = "Brights",
	},
	challenge_names = {
		c_zero_alpine_garden = "Alpine Garden",
		c_zero_self_made_fortune = "Self-Made Fortune",
		c_zero_no_man = "No Man Can Make It Fall",
		c_zero_black_hole_sun = "Black Hole Sun",
		c_zero_edge_of_space = "Edge of Space",
	},
	labels = {
		zero_gala = "Gala",
		zero_occult = "Occult",
    zero_redjewel = 'Red Gem',
    zero_orangejewel = 'Orange Gem',
    zero_yellowjewel = 'Yellow Gem',
    zero_greenjewel = 'Green Gem',
    zero_bluejewel = 'Blue Gem',
    zero_violetjewel = 'Violet Gem',
    zero_whitejewel = 'White Gem',
	},
  poker_hands = {
      zero_jewel_flush = "Gem Flush",
      zero_jewel_four = "Gem Four",
      zero_jewel_house = "Gem House",
      zero_jewel_three = "Gem Three",
      zero_jewel_twopair = "Gem Two Pair",
      zero_jewel_spectrum = "Gem Spectrum",
      zero_jewel_pair = "Gem Pair",
  },
  }
}

return loc_stuff
