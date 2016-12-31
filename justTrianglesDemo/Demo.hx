package justTrianglesDemo;
import js.Browser;
import khaMath.Matrix4;
import justTrianglesDemo.WebGLDrawing;
import justTriangles.Triangle;
import justTriangles.Draw;
import justTriangles.Point;
import justTriangles.ShapePoints;
import htmlHelper.tools.CSSEnterFrame;
@:enum
abstract RainbowColors( Int ){
    var Violet = 0x9400D3;
    var Indigo = 0x4b0082;
    var Blue   = 0x0000FF;
    var Green  = 0x00ff00;
    var Yellow = 0xFFFF00;
    var Orange = 0xFF7F00;
    var Red    = 0xFF0000;
}
class Demo {
    var rainbow = [ Red, Orange, Yellow, Green, Blue, Indigo, Violet ];    
    public function new(){
        var webgl = WebGLDrawing.create( 570*2 );
        draw();
        webgl.setTriangles( Triangle.triangles, cast rainbow );
        webgl.modelViewProjection = Matrix4.rotationZ( Math.PI / 4 );
        webgl.transformationFunc = spin;
    }
    var theta: Float = 0;
    inline function spin(): Matrix4{
        return Matrix4.rotationZ( theta += Math.PI/100 ).multmat( Matrix4.rotationY( theta ) );
    }
    public function draw(){
        Draw.colorFill_id = 1; 
        Draw.colorLine_id = 1;
        Draw.extraFill_id = 2;
        Draw.thickness = 25/1000;
        var rndEnds = [ true, false ];
        for( i in 0...12 ){
            var aCol =  Math.round( Math.random()*(rainbow.length-1));
            Draw.colorFill_id = aCol; 
            Draw.colorLine_id = aCol;
            Draw.extraFill_id = aCol;
            var roundEnd = rndEnds[ Math.round( Math.random() ) ];
            Draw.isolatedLine( 0, { x: (300 + Math.random()*800)/800 - 0.5, y: ( -200 + Math.random()*800 )/800 }, { x: ( 300 + Math.random()*800 )/800 - 0.5,y: (-200 + Math.random()*800)/800 }, ( 10+Math.random()*20 )/800, roundEnd  );
        }   
    }
}
