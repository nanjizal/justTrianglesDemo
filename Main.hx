package;
import js.Browser;
import justTrianglesDemo.Demo;
class Main {
    static function main() { new Main(); } public function new(){
        js.Browser.window.onload = onload;
    }
    function onload( e ) {
        new Demo();
    }
}
