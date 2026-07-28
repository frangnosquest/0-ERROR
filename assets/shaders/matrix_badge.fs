#if defined(VERTEX) || __VERSION__ > 100 || defined(GL_FRAGMENT_PRECISION_HIGH)
    #define PRECISION highp
#else
    #define PRECISION mediump
#endif

extern PRECISION vec2 matrix_badge;
extern PRECISION number dissolve;
extern PRECISION number time;
extern PRECISION vec4 uie_details;
extern PRECISION number uie_scale;
extern PRECISION number uie_rot;
extern bool shadow;
extern PRECISION vec2 badge_pos;
extern PRECISION vec2 badge_size;

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
    vec2 uv = (screen_coords - badge_pos) / badge_size;
    uv += (uie_details.xy + vec2(uie_scale, uie_rot)) * 0.000001;

    vec2 grid = vec2(10.0, 3.0);
    vec2 grid_uv = uv * grid + vec2(matrix_badge.x * 0.1, 0.0);
    vec2 id = floor(grid_uv);
    vec2 f = fract(grid_uv);

    float speed = hash(vec2(id.x, 8.12)) * 6.0 + 6.0;
    float loop_range = grid.y + 8.0;
    float phase = hash(vec2(id.x, 23.45)) * loop_range;
    float offset = time * speed + phase + matrix_badge.y * 0.5 + dissolve * 0.0;
    
    float head = mod(offset, loop_range) - 4.0;
    float dist = head - id.y;
    
    float trail_len = 2.0;
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

    if (shadow) {
        return vec4(0.0, 0.0, 0.0, colour.a * 0.3);
    }

    vec3 base_color = colour.rgb * 0.1;
    vec3 green_tint = vec3(0.05, 0.65, 0.1);
    vec3 bright_head = vec3(0.6, 0.95, 0.65);

    float is_head = smoothstep(1.0, 0.0, dist);
    vec3 matrix_badge_color = mix(base_color, green_tint, sym * drop);
    matrix_badge_color = mix(matrix_badge_color, bright_head, sym * is_head * 0.75);

    return vec4(matrix_badge_color, colour.a);
}

vec4 dissolve_mask(vec4 tex, vec2 texture_coords, vec2 uv)
{
    return tex;
}