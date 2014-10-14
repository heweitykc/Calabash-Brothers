package
{
    import flash.events.*;

    public interface IBaseEventDispatcher
    {

        public function IBaseEventDispatcher();

        function addEvtListener(param1:String, param2:Function, param3:Boolean = false, param4:Boolean = true) : void;

        function addEvtListeners(param1:Array, param2:Function, param3:Boolean = false, param4:Boolean = true) : void;

        function removeEvtListener(param1:String, param2:Function) : void;

        function getBaseEventDispatcher() : IBaseEventDispatcher;

        function hasEventListener(param1:String) : Boolean;

        function dispatchEvt(event:Event) : void;

    }
}
