#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 matrix;
extern PRECISION number dissolve;
extern PRECISION number time;
extern PRECISION vec4 texture_details;
extern PRECISION vec2 image_details;
extern bool shadow;
extern PRECISION vec4 burn_colour_1;
extern PRECISION vec4 burn_colour_2;

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv);

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

float get_digit(float n, float b) {
    float v = 0.0;
    if(n < 0.5) v = 31599.0;
    else if(n < 1.5) v = 11415.0;
    else if(n < 2.5) v = 29671.0;
    else if(n < 3.5) v = 29647.0;
    else if(n < 4.5) v = 23497.0;
    else if(n < 5.5) v = 31183.0;
    else if(n < 6.5) v = 31215.0;
    else if(n < 7.5) v = 29330.0;
    else if(n < 8.5) v = 31727.0;
    else v = 31695.0;
    return mod(floor(v / pow(2.0, b)), 2.0);
}

vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 tex = Texel(texture, texture_coords);
    vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;

    vec2 grid = vec2(10.0, 15.0);
    vec2 grid_uv = uv * grid + vec2(matrix.x * 1.5, 0.0);
    vec2 id = floor(grid_uv);
    vec2 f = fract(grid_uv);

    float speed = hash(vec2(id.x, 0.0)) * 3.0 + 1.5;
    float offset = time * speed + matrix.y * 2.0;
    
    float loop_range = grid.y + 12.0;
    float head = mod(offset, loop_range) - 6.0;
    float dist = head - id.y;
    
    float trail_len = hash(vec2(id.x, 7.84)) * 3.0 + 5.0;
    float drop = 0.0;
    if (dist >= 0.0 && dist < trail_len) {
        drop = 1.0 - (dist / trail_len);
    }

    vec2 f_inner = (f - vec2(0.15, 0.1)) / vec2(0.7, 0.8);
    float bounds = step(0.0, f_inner.x) * step(f_inner.x, 1.0) * step(0.0, f_inner.y) * step(f_inner.y, 1.0);
    vec2 sub = floor(f_inner * vec2(3.0, 5.0));
    float b = (4.0 - sub.y) * 3.0 + (2.0 - sub.x);

    float loop_id = floor(offset / loop_range);
    vec2 char_id = vec2(id.x, id.y + loop_id * 37.0);
    float change_tick = floor(time * 3.0);
    
    float num = floor(mod(hash(char_id + change_tick) * 10.0, 10.0));
    float sym = get_digit(num, b) * bounds * step(0.01, drop);

    vec3 dark_green = vec3(0.0, 0.12, 0.03);
    vec3 green_tint = vec3(0.15, 0.95, 0.25);
    vec3 bright_head = vec3(0.85, 1.0, 0.85);

    float is_head = smoothstep(1.0, 0.0, dist);
    vec3 matrix_color = mix(green_tint * drop, bright_head, is_head * 0.75) * sym;

    float lum = dot(tex.rgb, vec3(0.299, 0.587, 0.114));
    vec3 base_art = vec3(lum) * dark_green * (0.3 + abs(matrix.x) * 0.5);

    tex.rgb = mix(base_art, matrix_color, drop * 0.9 + 0.1);
    tex.rgb = clamp(tex.rgb, 0.0, 1.0);

    return dissolve_mask(tex * colour, texture_coords, uv);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    if (dissolve < 0.001) {
        return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, shadow ? tex.a*0.3: tex.a);
    }

    float adjusted_dissolve = (dissolve*dissolve*(3.-2.*dissolve))*1.02 - 0.01;

    float t = time * 10.0 + 2003.;
    vec2 floored_uv = (floor((uv*texture_details.ba)))/max(texture_details.b, texture_details.a);
    vec2 uv_scaled_centered = (floored_uv - 0.5) * 2.3 * max(texture_details.b, texture_details.a);
    
    vec2 field_part1 = uv_scaled_centered + 50.*vec2(sin(-t / 143.6340), cos(-t / 99.4324));
    vec2 field_part2 = uv_scaled_centered + 50.*vec2(cos( t / 53.1532),  cos( t / 61.4532));
    vec2 field_part3 = uv_scaled_centered + 50.*vec2(sin(-t / 87.53218), sin(-t / 49.0000));

    float field = (1.+ (
        cos(length(field_part1) / 19.483) + sin(length(field_part2) / 33.155) * cos(field_part2.y / 15.73) +
        cos(length(field_part3) / 27.193) * sin(field_part3.x / 21.92) ))/2.;
    vec2 borders = vec2(0.2, 0.8);

    float res = (.5 + .5* cos( (adjusted_dissolve) / 82.612 + ( field + -.5 ) *3.14))
    - (floored_uv.x > borders.y ? (floored_uv.x - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y > borders.y ? (floored_uv.y - borders.y)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.x < borders.x ? (borders.x - floored_uv.x)*(5. + 5.*dissolve) : 0.)*(dissolve)
    - (floored_uv.y < borders.x ? (borders.x - floored_uv.y)*(5. + 5.*dissolve) : 0.)*(dissolve);

    if (tex.a > 0.01 && burn_colour_1.a > 0.01 && !shadow && res < adjusted_dissolve + 0.8*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
        if (!shadow && res < adjusted_dissolve + 0.5*(0.5-abs(adjusted_dissolve-0.5)) && res > adjusted_dissolve) {
            tex.rgba = burn_colour_1.rgba;
        } else if (burn_colour_2.a > 0.01) {
            tex.rgba = burn_colour_2.rgba;
        }
    }

    return vec4(shadow ? vec3(0.,0.,0.) : tex.xyz, res > adjusted_dissolve ? (shadow ? tex.a*0.3: tex.a) : .0);
}

extern PRECISION vec2 mouse_screen_pos;
extern PRECISION float hovering;
extern PRECISION float screen_scale;

#ifdef VERTEX
vec4 position( mat4 transform_projection, vec4 vertex_position )
{
    if (hovering <= 0.){
        return transform_projection * vertex_position;
    }
    float mid_dist = length(vertex_position.xy - 0.5*love_ScreenSize.xy)/length(love_ScreenSize.xy);
    vec2 mouse_offset = (vertex_position.xy - mouse_screen_pos.xy)/screen_scale;
    float scale = 0.2*(-0.03 - 0.3*max(0., 0.3-mid_dist))
                *hovering*(length(mouse_offset)*length(mouse_offset))/(2. -mid_dist);

    return transform_projection * vertex_position + vec4(0,0,0,scale);
}
#endif