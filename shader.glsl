#ifdef VERTEX
vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    return transform_projection * vertex_position;
}
#endif

#ifdef PIXEL
uniform float time;

uniform bool chromatic_aberation_enabled = true;
uniform bool vignette_enabled = true;
uniform bool tint_enabled = true;
uniform bool scanlines_enabled = true;
uniform bool flickering_enabled = true;
uniform bool distortion_enabled = true;

#define r_offset vec2(0.005, 0.0)
#define g_offset vec2(0.0, 0.0)
#define b_offset vec2(-0.005, 0.0)

#define VIGNETTE_RADIUS 0.75
#define VIGNETTE_SOFTNESS 0.45

#define distortion 0.2
#define cornersize 0.02
#define cornersmooth 200
#define aspect vec2(1.0, 0.75)

float rand(vec2 co)
{
    return fract(sin(dot(co.xy, vec2(12.0909, 78.233))) * 43758.5453);
}

vec2 radial_distortion(vec2 coord)
{
    vec2 cc = coord - vec2(0.5);
    float dist = dot(cc, cc) * distortion;
    vec2 foo = coord + cc * (1.0 - dist) * dist;
    return foo;
}

float corner(vec2 coord)
{
  coord = (coord - vec2(0.5)) + vec2(0.5);
  coord = min(coord, vec2(1.0) - coord) * aspect;
  vec2 cdist = vec2(cornersize);
  coord = (cdist - min(coord, cdist));
  float dist = sqrt(dot(coord, coord));
  return clamp((cdist.x - dist) * cornersmooth, 0.0, 1.0);
}

vec4 effect(vec4 color, Image texture, vec2 uv, vec2 screen_coords)
{

    if (distortion_enabled)
    {
        uv = radial_distortion(uv);
    }

    vec4 col = Texel(texture, uv) * color;

    // chromatic aberation
    if (chromatic_aberation_enabled)
    {
        col.r = Texel(texture, uv.xy + r_offset).r;
        col.g = Texel(texture, uv.xy + g_offset).g;
        col.b = Texel(texture, uv.xy + b_offset).b;
    }

    // vignette
    if (vignette_enabled)
    {
        col *= 0.8 + 0.4 * 16.0 * uv.x * uv.y * (1.0 - uv.x) * (1.0 - uv.y);
    }

    // tint
    if (tint_enabled)
    {
        col *= vec4(1.0, 1.1, 1.2, 1.0);
    }

    // scanlines
    if (scanlines_enabled)
    {
        col *= 0.8 + 0.2 * sin(5.0 * time + uv.y * 900.0);
    }

    // flickering
    if (flickering_enabled)
    {
        col *= 1.0 - 0.1 * rand(vec2(time, tan(time)));
    }

    col.rgb *= corner(uv);

    return col;
}
#endif
