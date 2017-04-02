uniform vec3 in_col;
uniform sampler2D in_brush;
uniform vec2 i_res;

void main(){
  vec2 uv = gl_FragCoord.xy/i_res.xy
  vec4 transp = texture2D(in_brush,uv);
  gl_FragColor = vec4(in_col,transp.a);
}
