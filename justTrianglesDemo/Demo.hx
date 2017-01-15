package justTrianglesDemo;
import js.Browser;
import khaMath.Matrix4;
import justTrianglesDemo.WebGLDrawing;
import justTriangles.Triangle;
import justTriangles.Draw;
import justTriangles.Point;
import justTriangles.PathContext;
import justTriangles.ShapePoints;
import justTriangles.QuickPaths;
import htmlHelper.tools.CSSEnterFrame;
using justTriangles.QuickPaths;
@:enum
abstract RainbowColors( Int ){
    var Violet = 0x9400D3;
    var Indigo = 0x4b0082;
    var Blue   = 0x0000FF;
    var Green  = 0x00ff00;
    var Yellow = 0xFFFF00;
    var Orange = 0xFF7F00;
    var Red    = 0xFF0000;
    var Black  = 0x000000;
}
class Demo {
    var rainbow = [ Black, Red, Orange, Yellow, Green, Blue, Indigo, Violet ];   
    public function new(){
        var webgl = WebGLDrawing.create( 570*2 );
        draw();
        webgl.setTriangles( Triangle.triangles, cast rainbow );
        //webgl.modelViewProjection = Matrix4.rotationZ( Math.PI / 4 );
        //webgl.transformationFunc = spin;
    }
    var theta: Float = 0;
    inline function spin(): Matrix4{
        return Matrix4.rotationZ( theta += Math.PI/100 ).multmat( Matrix4.rotationY( theta ) );
    }
    public function draw(){
        Draw.colorFill_id = 1;
        Draw.colorLine_id = 0;
        Draw.colorLine_id = 7;
        Draw.extraFill_id = 2;
        var ctx;
        var thick = 20;
        ctx = new PathContext( 30, 200, 30, 30 );
        ctx.lineType = TriangleJoin; // arc, straight - default
        //ctx.lineType = Poly; // polygons
        //ctx.lineType = Round;
        //ctx.lineType = Isolated;  // okish lines
        //ctx.lineType = Quad;
        //ctx.lineType = Curves; // curves
        ctx.speechBubble( 1, 1, 0, 0 );
        ctx.heart( 1, 1, 200, 0 );
        ctx.roundedRectangle( 100, 300, 150, 60, 5 );
        //linesTest();
        ctx.regularPoly( PathContext.circleSides, 100, 100, 100, 0 );
        ctx.arc_move( 300, 200, 50, 0, Math.PI, clockwise, hexacontagon );
        ctx.moveTo( 50 + 200*Math.random(), 50+ 200*Math.random() );
        for( i in 0...10 ) ctx.lineTo( 50 + 200*Math.random(), 200+ 90*Math.random() ); 
        ctx.render( thick, false ); 
    }
    
    
    public function linesTest(){
        var thick: Float = (Math.random()*20)/800;
        var rndEnds = [ true, false ];
        for( i in 0...12 ){
            var aCol =  Math.round( Math.random()*(rainbow.length-1));
            Draw.colorFill_id = aCol;
            Draw.colorLine_id = aCol;
            Draw.extraFill_id = aCol;
            var roundEnd = rndEnds[ Math.round( Math.random() ) ];
            thick = ( Math.random()*20 )/800;
            Draw.isolatedLine( 0, { x: (300 + Math.random()*800)/800 - 0.5, y: ( -200 + Math.random()*800 )/800 }, { x: ( 300 + Math.random()*800 )/800 - 0.5,y: (-200 + Math.random()*800)/800 }, thick, roundEnd  );
        }
    }
}
