//Universal Bump Mapping shader, by TDRR.
//Most of the code comes from here:
//https://www.geeks3d.com/20130122/normal-mapping-without-precomputed-tangent-space-vectors/
//with some optimization and other code from elsewhere.

//Uncomment out this line if you don't plan on using slopes often.
//When it's present, a faster method for calculating the tangent and bitangent
//is used, but it causes grainy artifacts on certain slope angles.
//#define FAST_MODE 1

#ifdef DYNLIGHT

vec3 specularity (vec3 lightPos, vec3 viewDir, vec3 normal, vec3 color)
{	
	vec3 lightDir = normalize(lightPos - pixelpos.xyz);  
	
	vec3 reflectDir = reflect(-lightDir, normal);
	
	vec3 spec = vec3(pow(max(dot(viewDir, reflectDir), 0.0), 32));
	return spec * color;
}

vec3 getNormalFromBumpMap (vec2 tex_coord)
{
	const vec3 offset = vec3(-0.01, 0.0, 0.01);
	
    float L = desaturate(texture2D(tex, tex_coord + offset.xy)).r;
    float R = desaturate(texture2D(tex, tex_coord + offset.zy)).r;
    float T = desaturate(texture2D(tex, tex_coord + offset.yz)).r;
    float B = desaturate(texture2D(tex, tex_coord + offset.yx)).r;
	
	vec3 normal = normalize(vec3(4*(R-L), 4*(B-T), 4));
	
	return vec3(normal.x, -normal.y, normal.z);
}

mat3 cotangent_frame(vec3 N, vec2 uv, vec3 dp1, vec3 dp2)
{
	#ifdef FAST_MODE //"faster" method
		vec3 c1 = cross(N, vec3(0.0, 0.0, 1.0)); 
		vec3 c2 = cross(N, vec3(0.0, 1.0, 0.0)); 
		
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

vec4 Process(vec4 color)
{	
	vec2 UV = gl_TexCoord[0].st;
	vec4 texel = texture2D(tex, UV);
	
	//these are used later to calculate the tangents in the non-FAST_MODE
	//version, so to save some time they're stored.
	vec3 dFd_x = dFdx(pixelpos.xyz);
	vec3 dFd_y = dFdy(pixelpos.xyz);
	
	vec3 polynormal = normalize(cross(dFd_x, dFd_y));
	
	vec3 eyedir = normalize(camerapos.xyz - pixelpos.xyz);
	vec3 normal = getNormalFromBumpMap(UV);
	
	//perturb normal with generated tangent matrix
	mat3 TBN = cotangent_frame(polynormal, UV, dFd_x, dFd_y);
	normal = normalize(TBN * normal);
	
	vec3 spec = vec3(0.0);
	
	for(int i=0; i<lightrange.x; i+=2)
	{
		vec4 lightpos = lights[i];
		vec4 lightcolor = lights[i+1];
		
		lightcolor.rgb *= max(lightpos.w - distance(pixelpos.xyz, lightpos.xyz),0.0) / lightpos.w;
		spec += specularity(lightpos.xyz, eyedir, normal, lightcolor.xyz);
	}
		
	//return vec4(normal * 0.5 + 0.5, 1.0);
	return vec4( (texel.rgb * color.rgb) + spec, color.a);
}

#else

vec4 Process (vec4 color)
{
	return vec4(getTexel(gl_TexCoord[0].st) * color.rgb, color.a);
}

#endif