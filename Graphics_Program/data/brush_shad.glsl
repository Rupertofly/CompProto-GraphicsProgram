uniform vec3 in_col;
uniform sampler2D in_brush;
uniform vec2 i_res;

void main(){
  vec2 uv = gl_FragCoord.xy/i_res.xy;
  vec4 img_a = texture2D(in_brush,uv);
  vec4 my_out_col = vec4(in_col,img_a.a);
  gl_FragColor = my_out_col;
}
