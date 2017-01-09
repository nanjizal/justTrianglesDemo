package justTrianglesDemo;
import js.Browser;
import khaMath.Matrix4;
import justTrianglesDemo.WebGLDrawing;
import justTriangles.Triangle;
import justTriangles.Draw;
import justTriangles.Point;
import justTriangles.PathContext;
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
        Draw.colorLine_id = 3;
        Draw.extraFill_id = 1;
        var ctx = new PathContext( 1, 200 );
        var thick = Math.random()*20;
        ctx.moveTo(75,40);
        ctx.curveTo(75,37,70,25,50,25);
        ctx.curveTo(20,25,20,62.5,20,62.5);
        ctx.curveTo(20,80,40,102,75,120);
        ctx.curveTo(110,102,130,80,130,62.5);
        ctx.curveTo(130,62.5,130,25,100,25);
        ctx.curveTo(85,25,75,37,75,40);
        ctx.render( 1);
        ctx.clear();
        ctx = new PathContext( 1, 200, 200, 100 );
        ctx.moveTo(75,25);
        ctx.quadTo(25,25,25,62.5);
        ctx.quadTo(25,100,50,100);
        ctx.quadTo(50,120,30,125);
        ctx.quadTo(60,120,65,100);
        ctx.quadTo(125,100,125,62.5);
        ctx.quadTo(125,25,75,25);
        ctx.render( 1 );
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
        var thick = Math.random()*20;
        ctx.roundedRectangle( 100, 75, 150, 60, 5 );
        var ctx = new PathContext( 1, 200 );
        ctx.roundedRectangle( 100, 75, 150, 60, 5 );
        ctx.moveTo(75,40);
        ctx.curveTo(75,37,70,25,50,25);
        ctx.curveTo(20,25,20,62.5,20,62.5);
        ctx.curveTo(20,80,40,102,75,120);
        ctx.curveTo(110,102,130,80,130,62.5);
        ctx.curveTo(130,62.5,130,25,100,25);
        ctx.curveTo(85,25,75,37,75,40);
        ctx.render( thick, false );
        ctx.clear();
        ctx = new PathContext( 1, 200, 200, 100 );
        ctx.moveTo(75,25);
        ctx.quadTo(25,25,25,62.5);
        ctx.quadTo(25,100,50,100);
        ctx.quadTo(50,120,30,125);
        ctx.quadTo(60,120,65,100);
        ctx.quadTo(125,100,125,62.5);
        ctx.quadTo(125,25,75,25);
        ctx.regularPoly( PathContext.circleSides, 100, 100, 100, 0 );
        ctx.arc_move( 100, 75, 50, 0, Math.PI, clockwise, hexacontagon );
        ctx.render( thick, false ); 
    }
}
