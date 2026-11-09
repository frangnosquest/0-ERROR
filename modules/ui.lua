local function zero_credit_sections()
  return {
    {
      title = "Developers",
      colour = G.C.GREEN,
      text = G.C.WHITE,
      shader = "zero_matrix_badge",
      people = {
        { name = "Notmario" },
        { name = "AutumMood" },
        { name = "YouhWithAnH" },
        { name = "Freh" },
      }
    },
    {
      title = "Bejeweled Mode",
      colour = G.C.RAINBOW,
      text = G.C.UI.TEXT_DARK,
      people = {
        { name = "pi_cubed" },
      }
    },
    {
      title = "Artists",
      colour = G.C.PATRON,
      text = G.C.WHITE,
      people = {
        { name = "missingnumber", role = "lead artist" },
        { name = "cassknows", role = "edition shaders" },
      }
    },
    {
      title = localize('b_music'),
      colour = G.C.BLUE,
      text = G.C.WHITE,
      people = {
        { name = "missingnumber", role = "lead composer" },
      }
    },
  }
end

local function zero_credit_chip(person)
  local nodes = {
    { n = G.UIT.R, config = { align = 'cm' }, nodes = {
      { n = G.UIT.T, config = { text = person.name, colour = G.C.WHITE, scale = 0.42, shadow = true } }
    } }
  }
  if person.role then
    nodes[#nodes + 1] = { n = G.UIT.R, config = { align = 'cm' }, nodes = {
      { n = G.UIT.T, config = { text = person.role, colour = G.C.UI.TEXT_INACTIVE, scale = 0.28 } }
    } }
  end
  return {
    n = G.UIT.C,
    config = { align = 'cm', padding = 0.07, minw = 2.2, r = 0.08, colour = darken(G.C.BLACK, 0.2), emboss = 0.04, outline = 1, outline_colour = G.C.JOKER_GREY },
    nodes = nodes
  }
end

local function zero_credit_card(section)
  local rows = {}
  local row
  for i, person in ipairs(section.people) do
    if i % 2 == 1 then
      row = { n = G.UIT.R, config = { align = 'cm', padding = 0.05 }, nodes = {} }
      rows[#rows + 1] = row
    end
    row.nodes[#row.nodes + 1] = { n = G.UIT.C, config = { padding = 0.04 }, nodes = { zero_credit_chip(person) } }
  end
  return {
    n = G.UIT.C,
    config = { align = 'tm', padding = 0.08, r = 0.12, minw = 5.2, minh = 2.3, colour = G.C.L_BLACK, emboss = 0.05 },
    nodes = {
      {
        n = G.UIT.R,
        config = { align = 'cm', padding = 0.07, r = 0.08, minw = 5, colour = section.colour, emboss = 0.04, shader = section.shader },
        nodes = { { n = G.UIT.T, config = { text = section.title, colour = section.text, scale = 0.55, shadow = section.text == G.C.WHITE } } }
      },
      { n = G.UIT.R, config = { align = 'cm', padding = 0.06 }, nodes = rows }
    }
  }
end

local function zero_credits_tab()
  local sections = zero_credit_sections()
  local nodes = {
    {
      n = G.UIT.R,
      config = { align = 'cm', padding = 0.1 },
      nodes = {
        { n = G.UIT.O, config = { object = DynaText({
          string = { "0 ERROR" },
          colours = { G.C.GREEN },
          scale = 0.9,
          float = true,
          shadow = true,
          bump = true,
          silent = true,
          pop_in = 0.4,
          pop_in_rate = 6
        }) } }
      }
    }
  }
  for i = 1, #sections, 2 do
    local pair = { zero_credit_card(sections[i]) }
    if sections[i + 1] then
      pair[#pair + 1] = zero_credit_card(sections[i + 1])
    end
    nodes[#nodes + 1] = { n = G.UIT.R, config = { align = 'cm', padding = 0.08 }, nodes = pair }
  end
  nodes[#nodes + 1] = {
    n = G.UIT.R,
    config = { align = 'cm', padding = 0.05 },
    nodes = { { n = G.UIT.T, config = { text = "Thank you for playing!", colour = G.C.UI.TEXT_INACTIVE, scale = 0.32 } } }
  }
  return {
    n = G.UIT.ROOT,
    config = { align = 'cm', padding = 0.1, emboss = 0.05, r = 0.1, colour = G.C.BLACK },
    nodes = nodes
  }
end

SMODS.current_mod.extra_tabs = function()
  return {
    {
      label = localize('b_credits'),
      tab_definition_function = zero_credits_tab
    },
    {
      label = '???',
      tab_definition_function = function()
        G.zero_soshi_page = 1
        G.zero_soshi_condition_met = false
        return G.UIDEF.zero_soshi_wrapper()
      end
    },
  }
end
