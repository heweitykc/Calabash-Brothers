package interfaces.chat
{
    import com.f1.*;
    import com.f1.interfaces.*;

    public interface IChatModule extends IModule
    {

        public function IChatModule();

        function sendLink(param1:String, param2:String, param3:String, param4) : void;

        function resize(param1:BaseSprite = null) : void;

        function setOffset(param1:int, param2:int) : void;

        function show() : void;

        function hide() : void;

    }
}
