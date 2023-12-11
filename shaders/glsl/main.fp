//A faster approximation of the tangent space transformation.
//Causes some grainy artifacts on slopes, and possibly other angles, but is
//a bit faster. Default 0 (off, more precise).
#define FAST_MODE 0

//Allows cutting off a light completely if the angle between it and the surface
//is too shallow. Gives a bumpier edge to lights, but also makes them shrink
//the closer they get to a surface (sorta like attenuated lights in GZDoom).
//No idea which is faster, while it does involve branching when enabled, this
//also skips quite a few calculations per light.
//Default 1, (off, shrinking and bumpier diffuse lighting)
#define ENABLE_CUTOFF 0

//Changes the cutoff amount used by the above option, as a value from 0.0 to 1.0
//Higher means more cutoff, lower means less.
//Default 0.25
#define CUTOFF_VALUE 0.25

//Size of the texture to be sampled as a bump map. Not necessary, mostly just to
//help with nearest neighbor filtering and nasty "banding" artifacts.
#define BTEX_SIZE 64

//end of bump map settings!


// Changing this constant gives results very similar to changing r_visibility.
// Default is 232, it seems to give exactly the same light bands as software renderer.
#define DOOMLIGHTFACTOR 232.0


#ifdef DYNLIGHT

// ATI does not like this inside an #ifdef so it will be prepended by the compiling code inside the .EXE now.
//#version 120
//#extension GL_EXT_gpu_shader4 : enable

uniform ivec3 lightrange;
#ifndef MAXLIGHTS128
uniform vec4 lights[256];
#else
uniform vec4 lights[128];
#endif

#endif



uniform int fogenabled;
uniform vec4 fogcolor;
uniform vec3 dlightcolor;
uniform vec3 camerapos;
varying vec4 pixelpos;
varying vec4 fogparm;
//uniform vec2 lightparms;
uniform float desaturation_factor;

uniform vec4 topglowcolor;
uniform vec4 bottomglowcolor;
varying vec2 glowdist;

uniform int texturemode;
uniform sampler2D tex;

vec4 Process(vec4 color);


varying float lightlevel;
varying float customarg;

#ifdef SOFTLIGHT
// Doom lighting equation ripped from EDGE.
// Big thanks to EDGE developers for making the only port
// that actually replicates software renderer's lighting in OpenGL.
// Float version.
// Basically replace int with float and divide all constants by 31.
float R_DoomLightingEquation(float light, float dist)
{
	/* L in the range 0 to 63 */
	float L = light * 63.0/31.0;

	float min_L = clamp(36.0/31.0 - L, 0.0, 1.0);

	// Fix objects getting totally black when close.
	if (dist < 0.0001)
		dist = 0.0001;

	float scale = 1.0 / dist;
	float index = (59.0/31.0 - L) - (scale * DOOMLIGHTFACTOR/31.0 - DOOMLIGHTFACTOR/31.0);

	/* result is colormap index (0 bright .. 31 dark) */
	return clamp(index, min_L, 1.0);
}
#endif

#ifdef DYNLIGHT

float desat(vec4 texel)
{
	return (texel.r * 0.3 + texel.g * 0.56 + texel.b * 0.14);
}

vec3 specularity (vec3 lightPos, vec3 viewDir, vec3 normal, vec3 color, vec3 lightDir)
{
	vec3 reflectDir = reflect(-lightDir, normal);

	vec3 spec = vec3(pow(max(dot(viewDir, reflectDir), 0.0), 128)) * 2;
	return spec * (color*2);
}

vec3 getNormalFromBumpMap (vec2 tex_coord)
{
	const vec3 offset = vec3(-1.0/BTEX_SIZE, 0.0, 1.0/BTEX_SIZE);

    float L = desat(texture2D(tex, tex_coord + offset.xy));
    float R = desat(texture2D(tex, tex_coord + offset.zy));
    float T = desat(texture2D(tex, tex_coord + offset.yz));
    float B = desat(texture2D(tex, tex_coord + offset.yx));

	vec3 normal = normalize(vec3(4*(R-L), 4*(B-T), 4));

	return vec3(normal.x, -normal.y, normal.z);
}

mat3 cotangent_frame(vec3 N, vec2 uv, vec3 dp1, vec3 dp2)
{
	#ifdef FAST_MODE //"faster" method
		vec3 c1 = cross(N, vec3(0.0, 0.0, 1.0));
		vec3 c2 = cross(N, vec3(0.0, -1.0, 0.0));

		vec3 t;

		if (length(c1) > length(c2))
			t = c1;
		else
			t = c2;

		t = normalize(t);
		vec3 b = normalize(cross(N, t));
	#else //"slower" method
		// get edge vectors of the pixel triangle
		vec2 duv1 = dFdx( uv );
		vec2 duv2 = dFdy( uv );

		// solve the linear system
		vec3 dp2perp = cross( dp2, N );
		vec3 dp1perp = cross( N, dp1 );
		vec3 t = dp2perp * duv1.x + dp1perp * duv2.x;
		vec3 b = dp2perp * duv1.y + dp1perp * duv2.y;
	#endif

    // construct a scale-invariant frame
    float invmax = inversesqrt( max( dot(t,t), dot(b,b) ) );
    return mat3( t * invmax, b * invmax, N );
}

#endif

//===========================================================================
//
// Desaturate a color
//
//===========================================================================

vec4 desaturate(vec4 texel)
{
	#ifndef NO_DESATURATE
		float gray = (texel.r * 0.3 + texel.g * 0.56 + texel.b * 0.14);
		return mix (vec4(gray,gray,gray,texel.a), texel, desaturation_factor);
	#else
		return texel;
	#endif
}

//===========================================================================
//
// Calculate light
//
//===========================================================================

vec4 getLightColor(float fogdist, float fogfactor)
{
	vec4 color = gl_Color;
	#ifdef SOFTLIGHT
		float newlightlevel = 1.0 - R_DoomLightingEquation(lightlevel, gl_FragCoord.z);
		color.rgb *= clamp(vec3(newlightlevel) + dlightcolor, 0.0, 1.0);
	#endif
	#ifndef NO_FOG
	//
	// apply light diminishing
	//
	if (fogenabled > 0)
	{
		#if (!defined(NO_SM4) || defined(DOOMLIGHT)) && !defined SOFTLIGHT
			// special lighting mode 'Doom' not available on older cards for performance reasons.
			if (fogdist < fogparm.y)
			{
				color.rgb *= fogparm.x - (fogdist / fogparm.y) * (fogparm.x - 1.0);
			}
		#endif

		//color = vec4(color.rgb * (1.0 - fogfactor), color.a);
		color.rgb = mix(vec3(0.0, 0.0, 0.0), color.rgb, fogfactor);
	}
	#endif

	#ifndef NO_GLOW
	//
	// handle glowing walls
	//
	if (topglowcolor.a > 0.0 && glowdist.x < topglowcolor.a)
	{
		color.rgb += desaturate(topglowcolor * (1.0 - glowdist.x / topglowcolor.a)).rgb;
	}
	if (bottomglowcolor.a > 0.0 && glowdist.y < bottomglowcolor.a)
	{
		color.rgb += desaturate(bottomglowcolor * (1.0 - glowdist.y / bottomglowcolor.a)).rgb;
	}
	color = min(color, 1.0);
	#endif

	// calculation of actual light color is complete.
	return color;
}

//===========================================================================
//
// Gets a texel and performs common manipulations
//
//===========================================================================

vec4 getTexel(vec2 st)
{
	vec4 texel = texture2D(tex, st);

	#ifndef NO_TEXTUREMODE
	//
	// Apply texture modes
	//
	if (texturemode == 2)
	{
		texel.a = 1.0;
	}
	else if (texturemode == 1)
	{
		texel.rgb = vec3(1.0,1.0,1.0);
	}
	#endif

	return desaturate(texel);
}

//===========================================================================
//
// Applies colored fog
//
//===========================================================================

#ifndef NO_FOG
vec4 applyFog(vec4 frag, float fogfactor)
{
	return vec4(mix(fogcolor.rgb, frag.rgb, fogfactor), frag.a);
}
#endif


//===========================================================================
//
// Main shader routine
//
//===========================================================================

vec3 getNormal ()
{
	return normalize(cross(dFdx(pixelpos.xyz), dFdy(pixelpos.xyz)));
}

void main()
{
	float fogdist = 0.0;
	float fogfactor = 0.0;

	#ifdef DYNLIGHT
		vec4 dynlight = vec4(0.0,0.0,0.0,0.0);
		vec4 addlight = vec4(0.0,0.0,0.0,0.0);

		vec3 eyedir = normalize(camerapos.xyz - pixelpos.xyz);
		vec3 normal = vec3(0.0);
		vec3 spec = vec3(0.0);

		if (customarg != 0)
		{
			vec2 UV = gl_TexCoord[0].st;

			//these are used later to calculate the tangents in the non-FAST_MODE
			//version, so to save some time they're stored.
			vec3 dFd_x = dFdx(pixelpos.xyz);
			vec3 dFd_y = dFdy(pixelpos.xyz);

			vec3 polynormal = normalize(cross(dFd_x, dFd_y));

			normal = getNormalFromBumpMap(UV);

			//perturb normal with generated tangent matrix
			mat3 TBN = cotangent_frame(polynormal, UV, dFd_x, dFd_y);
			normal = normalize(TBN * normal);
		}

	#endif

	#ifndef NO_FOG
	//
	// calculate fog factor
	//
	if (fogenabled != 0)
	{
		#ifndef NO_SM4
			if (fogenabled == 1 || fogenabled == -1)
			{
				fogdist = pixelpos.w;
			}
			else
			{
				fogdist = max(16.0, distance(pixelpos.xyz, camerapos));
			}
		#elif !defined(FOG_RADIAL)
			fogdist = pixelpos.w;
		#else
			fogdist = max(16.0, distance(pixelpos.xyz, camerapos));
		#endif
		fogfactor = exp2 (fogparm.z * fogdist);
	}
	#endif

	vec4 frag = getLightColor(fogdist, fogfactor);

	#ifdef DYNLIGHT
		if (customarg != 0)
		{
			for(int i=0; i<lightrange.x; i+=2)
			{
				vec4 lightpos = lights[i];
				lightpos.y += 8.0;
				vec4 lightcolor = lights[i+1];

				vec3 lightDir = normalize(lightpos.xyz - pixelpos.xyz);
				float lightIntensity = (-clamp(dot(normal, lightDir), -1.0, 0.0));

				#if ENABLE_CUTOFF
				if(lightIntensity >= CUTOFF_VALUE)
				{
				#endif
					vec3 extendedpos = (lightcolor.rgb) * (max((lightpos.w*2) - distance(pixelpos.xyz, lightpos.xyz),0.0) / (lightpos.w*2));

					lightcolor.rgb *= (max(lightpos.w - distance(pixelpos.xyz, lightpos.xyz),0.0) / lightpos.w) * lightIntensity;
					dynlight += lightcolor;

					spec += specularity(lightpos.xyz, eyedir, normal, extendedpos.xyz, lightDir);
				#if ENABLE_CUTOFF
				}
				#endif
			}
		}
		else
		{
			for(int i=0; i<lightrange.x; i+=2)
			{
				vec4 lightpos = lights[i];
				vec4 lightcolor = lights[i+1];

				lightcolor.rgb *= max(lightpos.w - distance(pixelpos.xyz, lightpos.xyz),0.0) / lightpos.w;
				dynlight += lightcolor;
			}
		}
		for(int i=lightrange.x; i<lightrange.y; i+=2)
		{
			vec4 lightpos = lights[i];
			vec4 lightcolor = lights[i+1];

			lightcolor.rgb *= max(lightpos.w - distance(pixelpos.xyz, lightpos.xyz),0.0) / lightpos.w;
			dynlight -= lightcolor;
		}
		for(int i=lightrange.y; i<lightrange.z; i+=2)
		{
			vec4 lightpos = lights[i];
			vec4 lightcolor = lights[i+1];

			lightcolor.rgb *= max(lightpos.w - distance(pixelpos.xyz, lightpos.xyz),0.0) / lightpos.w;
			addlight += lightcolor;
		}
		frag.rgb = clamp( (frag.rgb + dynlight.rgb) + spec, 0.0, 1.4);
	#endif
	
	frag = Process(frag);
	
	#ifdef DYNLIGHT
		frag.rgb += addlight.rgb;
	#endif

	#ifndef NO_FOG
		if (fogenabled < 0) 
		{
			frag = applyFog(frag, fogfactor);
		}
	#endif
	gl_FragColor = frag;
}
