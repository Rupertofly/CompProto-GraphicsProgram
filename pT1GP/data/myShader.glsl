uniform vec4 iResolution;
uniform sampler2D tex;

void main(){
  vec2 uv = gl_FragCoord.xy / iResolution.xy;
  vec4 samTex = texture2D(tex,uv);
  gl_FragColor.xyzw = vec4(sin(uv.x*10),sin(uv.y*12),sin((uv.x*10)+1),samTex.a);
}
