uniform vec3 iResolution;
uniform sampler2D tex;
out vec4 fragColor;

void main(){
  vec2 uv = gl_FragCoord.xy / iResolution.xy;
  vec4 samTex = texture2D(tex,uv);
  fragColor = vec4(uv.x,uv.y,0.0,samTex.a);
}
