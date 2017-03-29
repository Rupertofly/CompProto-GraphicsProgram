uniform vec4 aCol;
uniform vec4 bCol;
uniform vec2 pos;
uniform vec2 size;
uniform float time;

void main(){
  float u = (gl_FragCoord.x) / (size.x);
  gl_FragColor.g= mix(aCol.g, bCol.g, u);
  gl_FragColor.r= mix(aCol.r, bCol.r, u);
  gl_FragColor.b= mix(aCol.b, bCol.b, u);
  gl_FragColor.a = 1.0;
}
