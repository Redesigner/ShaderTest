shader_type spatial;

render_mode specular_toon;

uniform vec3 matColor;

void vertex() {
}

void fragment() {
	ALBEDO = matColor / 255.0;
}

void light() {
	
	vec3 lightColor = ALBEDO * ATTENUATION * LIGHT_COLOR;
	
	float diffuseStrength = clamp(dot(NORMAL, LIGHT), 0.0, 1.0);
	float rampedDiffuse = smoothstep(0.0, 0.01, diffuseStrength);
	DIFFUSE_LIGHT += lightColor * rampedDiffuse;
	
	vec3 reflectedLight = reflect(LIGHT, NORMAL);
	float specularDot = clamp(dot(-VIEW, reflectedLight), 0.0, 1.0);
	float specularIntensity = smoothstep(0.89, 0.9, pow(specularDot, 10));
	
	SPECULAR_LIGHT += lightColor * specularIntensity;

}
