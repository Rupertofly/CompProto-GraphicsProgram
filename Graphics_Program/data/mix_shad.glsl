uniform vec4 a_col;
uniform vec4 b_col;
uniform vec2 i_res;

void main(){
  vec4 out_c = mix(a_col, b_col, gl_FragCoord.x/i_res.x);
  gl_FragColor = out_c;
}
