package justTrianglesDemo;
import js.Browser;
import khaMath.Matrix4;
import justTrianglesWebGL.Drawing;
import justTriangles.Triangle;
import justTriangles.Draw;
import justTriangles.Point;
import justTriangles.PathContext;
import justTriangles.ShapePoints;
import justTriangles.QuickPaths;
import htmlHelper.tools.CSSEnterFrame;
import justTriangles.SvgPath;
import justTriangles.PathContextTrace;
import justTrianglesDemo.DroidSans;

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
        var webgl = Drawing.create( 570*2 );
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
        var thick = 4;
        
        
        var ctx = new PathContext( 1, 1000, 100, 100 );
        ctx.setColor( 2, 2 );
        ctx.setThickness( thick );
        ctx.lineType = TriangleJoinCurve; // - default
        var pathTrace = new PathContextTrace();
        var p = new SvgPath( ctx );
        p.parse( bird_d, 0, 0 );
        p.parse( cubictest_d, 300, 300 );
        p.parse( quadtest_d, 600, 300 );
        ctx.render( thick, false ); 
        
        var ctx2 = new PathContext( 1, 1000, 100, 100 );
        
        //var ctx2 = new PathContext( 1, 500, 0, 0 );
        ctx2.setColor( 5, 5 );
        ctx2.setThickness( 4 );
        ctx2.lineType = TriangleJoinCurve; // - default
        var p2 = new SvgPath( ctx2 );
        var c: Int;
        var pos = 0;
        var str = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"+'"'+";#$%&'()*+,-./:;<>?";
        var letterPath: String;
        var glyph: Glyph;
        var letterScale = 0.05;
        var deltaX: Float = 600;
        var deltaY: Float = 150;
        var count = 0;
        while( true ){
            c = StringTools.fastCodeAt( str, pos++ );
            if( c == null ) {
                break;
            } else {
                if( count == 10 ) {
                    deltaY += 100;
                    deltaX = 0;
                }
                if( count == ( 26 + 10 ) ){
                    deltaY += 100;
                    deltaX = 0;
                }
                if( count == ( 26 + 26 + 10 ) ){
                    deltaY += 100;
                    deltaX = 0;
                }
                glyph = DroidSans.getSymbol( c );
                if( glyph == null ) break;
                letterPath = glyph.d;
                deltaX += glyph.ax*letterScale + 10;
                count++;
                if( letterPath == null ) break;
                p2.parse( letterPath, deltaX, deltaY, letterScale, -letterScale );
            }
        }
        
        
        ctx.moveTo( 50, 50 );
        var up = 0;
        var down = 100;
        var direction = up;
        var p = [ 60, 50, 70, 50, 80, 50, 90, 50, 90, direction, 80, direction - 10 ];
        var l = p.length;
        for( i in 0...l ){
            if( (i & 1) == 0 ){
                ctx.lineTo( p[i], p[i+1] );
            }
        }
        
        ctx.moveTo( 50, 70 );

        var direction = down;
        var p = [ 60, 70, 70, 70, 80, 70, 90, 70, 90, direction, 100, direction - 10 ];
        var l = p.length;
        for( i in 0...l ){
            if( (i & 1) == 0 ){
                ctx.lineTo( p[i], p[i+1] );
            }
        }
        
        
        //ctx.lineType = TriangleJoinCurve; // arc- Default seems to work quite well, but WIP.
        //ctx.lineType = TriangleJoinStraight; // straight 
        //ctx.lineType = Poly; // polygons
        //ctx.lineType = Round;
        //ctx.lineType = Isolated;  // okish lines
        //ctx.lineType = Quad;
        //ctx.lineType = Curves; // curves
        
        //ctx2.speechBubble( 3.5, 3.5, 500, -100 );
        ctx.speechBubble( 1, 1, 0, 0 );
        
        ctx.heart( 1, 1, 200, 0 );
        ctx.roundedRectangle( 100, 300, 150, 60, 5 );
        linesTest();
        ctx.regularPoly( PathContext.circleSides, 100, 100, 100, 0 );
        
        ctx.arc_move( 300, 200, 50, 0, Math.PI, counterClockwise, hexacontagon );
        
        ctx.moveTo( 50 + 200*Math.random(), 50+ 200*Math.random() );
        for( i in 0...10 ) ctx.lineTo( 50 + 200*Math.random(), 200+ 90*Math.random() ); 
        
        
        ctx.render( thick, false ); 
        
        
        ctx2.render( thick, false );
    }
    
    public function linesTest(){
        var thick: Float = (Math.random()*20)/800;
        var rndEnds = [ true, false ];
        for( i in 0...12 ){
            var aCol =  Math.round( Math.random()*(rainbow.length-1));
            Draw.colorId = aCol;
            var roundEnd = rndEnds[ Math.round( Math.random() ) ];
            thick = ( Math.random()*20 )/800;
            Draw.isolatedLine( 0, { x: (300 + Math.random()*800)/800 - 0.5, y: ( -200 + Math.random()*800 )/800 }, { x: ( 300 + Math.random()*800 )/800 - 0.5,y: (-200 + Math.random()*800)/800 }, thick, roundEnd  );
        }
    }
    var quadtest_d = "M200,300 Q400,50 600,300 T1000,300";
    var cubictest_d = "M100,200 C100,100 250,100 250,200S400,300 400,200";
    var bird_d = "M210.333,65.331C104.367,66.105-12.349,150.637,1.056,276.449c4.303,40.393,18.533,63.704,52.171,79.03c36.307,16.544,57.022,54.556,50.406,112.954c-9.935,4.88-17.405,11.031-19.132,20.015c7.531-0.17,14.943-0.312,22.59,4.341c20.333,12.375,31.296,27.363,42.979,51.72c1.714,3.572,8.192,2.849,8.312-3.078c0.17-8.467-1.856-17.454-5.226-26.933c-2.955-8.313,3.059-7.985,6.917-6.106c6.399,3.115,16.334,9.43,30.39,13.098c5.392,1.407,5.995-3.877,5.224-6.991c-1.864-7.522-11.009-10.862-24.519-19.229c-4.82-2.984-0.927-9.736,5.168-8.351l20.234,2.415c3.359,0.763,4.555-6.114,0.882-7.875c-14.198-6.804-28.897-10.098-53.864-7.799c-11.617-29.265-29.811-61.617-15.674-81.681c12.639-17.938,31.216-20.74,39.147,43.489c-5.002,3.107-11.215,5.031-11.332,13.024c7.201-2.845,11.207-1.399,14.791,0c17.912,6.998,35.462,21.826,52.982,37.309c3.739,3.303,8.413-1.718,6.991-6.034c-2.138-6.494-8.053-10.659-14.791-20.016c-3.239-4.495,5.03-7.045,10.886-6.876c13.849,0.396,22.886,8.268,35.177,11.218c4.483,1.076,9.741-1.964,6.917-6.917c-3.472-6.085-13.015-9.124-19.18-13.413c-4.357-3.029-3.025-7.132,2.697-6.602c3.905,0.361,8.478,2.271,13.908,1.767c9.946-0.925,7.717-7.169-0.883-9.566c-19.036-5.304-39.891-6.311-61.665-5.225c-43.837-8.358-31.554-84.887,0-90.363c29.571-5.132,62.966-13.339,99.928-32.156c32.668-5.429,64.835-12.446,92.939-33.85c48.106-14.469,111.903,16.113,204.241,149.695c3.926,5.681,15.819,9.94,9.524-6.351c-15.893-41.125-68.176-93.328-92.13-132.085c-24.581-39.774-14.34-61.243-39.957-91.247c-21.326-24.978-47.502-25.803-77.339-17.365c-23.461,6.634-39.234-7.117-52.98-31.273C318.42,87.525,265.838,64.927,210.333,65.331zM445.731,203.01c6.12,0,11.112,4.919,11.112,11.038c0,6.119-4.994,11.111-11.112,11.111s-11.038-4.994-11.038-11.111C434.693,207.929,439.613,203.01,445.731,203.01z";
}
