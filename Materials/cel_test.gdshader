shader_type spatial;

render_mode specular_toon;
render_mode cull_disabled;

uniform vec3 matColor;

uniform float fresnelBias;
uniform float fresnelScale;
uniform float fresnelPower;

void vertex() {
}

void fragment() {
	float gamma = 1.0;
	ALBEDO = pow(matColor / 255.0, vec3(gamma, gamma, gamma));
}

void light() {
	
	vec3 resultColor = ALBEDO * smoothstep(0.0, 0.1, ATTENUATION) * LIGHT_COLOR;
	
	float diffuseStrength = clamp(dot(NORMAL, LIGHT), 0.0, 1.0);
	float rampedDiffuse = smoothstep(0.0, 0.01, diffuseStrength);
	
	float fresnelStrength =  pow((1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0)), 10);
	DIFFUSE_LIGHT += (resultColor * rampedDiffuse) + fresnelStrength * LIGHT_COLOR;
	
	vec3 reflectedLight = reflect(LIGHT, NORMAL);
	float specularDot = clamp(dot(-VIEW, reflectedLight), 0.0, 1.0);
	float specularIntensity = smoothstep(0.89, 0.9, pow(specularDot, 10));
	
	SPECULAR_LIGHT += resultColor * specularIntensity;

}
