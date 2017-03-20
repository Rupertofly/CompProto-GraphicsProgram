uniform vec3 iResolution;
uniform sampler2D tex;
out vec4 fragColor;

void main(){
  vec2 uv = gl_FragCoord.xy / iResolution.xy;
  vec4 samTex = texture2D(tex,uv);
  fragColor = vec4(sin(radians(uv.x*1000.0)),sin(radians(uv.x*1000.0+100)),128.0,samTex.a);
}
