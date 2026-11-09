SMODS.Sound {
	vol = 1.0,
	pitch = 1.0,
	key = "withered_foxy_jumpscare",
	path = "withered_foxy_jumpscare.ogg",
}

local jumpscare_source = SMODS.current_mod.path .. "assets/video/withered_foxy_jumpscare.ogv"
local jumpscare_copy = "zero_withered_foxy_jumpscare.ogv"
local presses_needed = 10
local press_window = 1

local video, canvas, keyer
local failed = false
local playing = false
local presses = 0
local last_press = 0

local function load_jumpscare()
	if video then return true end
	if failed then return false end
	local ok = pcall(function()
		local data = NFS.read(jumpscare_source)
		local info = love.filesystem.getInfo(jumpscare_copy)
		if not info or info.size ~= #data then
			love.filesystem.write(jumpscare_copy, data)
		end
		video = love.graphics.newVideo(jumpscare_copy, { audio = false })
		canvas = love.graphics.newCanvas(video:getWidth(), video:getHeight())
		keyer = love.graphics.newShader([[
			vec4 effect(vec4 color, Image tex, vec2 uv, vec2 sc) {
				vec4 p = Texel(tex, uv);
				float key = p.g - max(p.r, p.b);
				float a = 1.0 - smoothstep(0.1, 0.3, key);
				vec3 rgb = vec3(p.r, min(p.g, max(p.r, p.b)), p.b);
				return vec4(rgb * a, a);
			}
		]])
	end)
	if not ok then
		failed = true
		video = nil
	end
	return ok
end

local function play_jumpscare()
	if playing or not load_jumpscare() then return end
	playing = true
	video:seek(0)
	video:play()
	play_sound('zero_withered_foxy_jumpscare')
end

local old_draw = love.draw
function love.draw(...)
	old_draw(...)
	if not playing then return end
	if not video:isPlaying() then
		playing = false
		video:pause()
		video:seek(0)
		return
	end
	local vw, vh = video:getWidth(), video:getHeight()
	love.graphics.push('all')
	love.graphics.setCanvas(canvas)
	love.graphics.clear(0, 0, 0, 1)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.draw(video, 0, 0)
	love.graphics.setCanvas()
	local w, h = love.graphics.getDimensions()
	local scale = math.max(w / vw, h / vh)
	love.graphics.setShader(keyer)
	love.graphics.setBlendMode('alpha', 'premultiplied')
	love.graphics.draw(canvas, (w - vw * scale) / 2, (h - vh * scale) / 2, 0, scale, scale)
	love.graphics.pop()
end

local old_submit_zs_text = G.FUNCS.submit_zs_text
G.FUNCS.submit_zs_text = function(e)
	local now = love.timer.getTime()
	presses = (now - last_press <= press_window) and presses + 1 or 1
	last_press = now
	if presses >= presses_needed then
		presses = 0
		play_jumpscare()
	end
	old_submit_zs_text(e)
end
