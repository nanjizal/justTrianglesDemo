package justTrianglesDemo;
import khaMath.Matrix4;
import htmlHelper.tools.CSSEnterFrame;
import justTriangles.Triangle;
import htmlHelper.webgl.WebGLSetup;
import justTriangles.Draw;
using htmlHelper.webgl.WebGLSetup;
class WebGLDrawing extends WebGLSetup {
    public var transformationFunc: Void -> Matrix4;
    public inline static function create( dim_ ): WebGLDrawing{
        Draw.drawTri = Triangle.drawTri;
        var webgl = new WebGLDrawing( dim_, dim_ ); 
        webgl.setupProgram( Shader.vertex, Shader.fragment );
        ( new CSSEnterFrame() ).onFrame = webgl.render;
        return webgl;
    }
    override public function render(){
        if( transformationFunc != null ) modelViewProjection = transformationFunc();
        super.render();
    }
    public function setTriangles( triangles: Array<Triangle>, triangleColors:Array<UInt> ) {
        var rgb: RGB;
        var colorAlpha = 1.0;
        var tri: Triangle;
        var count = 0;
        for( i in 0...triangles.length ){
            tri = triangles[ i ];
            vertices.push( tri.ax - 0.5 );
            vertices.push( -tri.ay + 0.5 );
            vertices.push( tri.depth );
            vertices.push( tri.bx - 0.5 );
            vertices.push( -tri.by + 0.5 );
            vertices.push( tri.depth );
            vertices.push( tri.cx - 0.5 );
            vertices.push( -tri.cy + 0.5 );
            vertices.push( tri.depth );
            rgb = WebGLSetup.toRGB( triangleColors[ tri.colorID ] );
            for( k in 0...3 ){
                colors.push( rgb.r );
                colors.push( rgb.g );
                colors.push( rgb.b );
                colors.push( colorAlpha );
                indices.push( count++ );
            }
        } 
        gl.uploadDataToBuffers( program, vertices, colors, indices );
    }
}
