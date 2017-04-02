uniform vec4 a_col;
uniform vec4 b_col;
uniform vec2 i_res;

void main(){
  vec3 a = a_col.rgb;
  vec3 b = b_col.rgb;
  vec3 c = mix(a, b, gl_FragCoord.x/i_res.x);
  vec4 out_c = vec4(c,1.0);
  gl_FragColor = out_c;
}
