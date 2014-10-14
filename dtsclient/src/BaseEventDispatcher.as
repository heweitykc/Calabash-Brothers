package
{
    import flash.events.*;

    public class BaseEventDispatcher extends EventDispatcher implements IBaseEventDispatcher
    {

        public function BaseEventDispatcher()
        {
            return;
        }// end function

        public function addEvtListener(param1:String, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            addEventListener(param1, param2, param3, 0, param4);
            return;
        }// end function

        public function removeEvtListener(param1:String, param2:Function) : void
        {
            removeEventListener(param1, param2);
            return;
        }// end function

        public function addEvtListeners(param1:Array, param2:Function, param3:Boolean = false, param4:Boolean = true) : void
        {
            var _loc_5:* = null;
            for each (_loc_5 in param1)
            {
                
                this.addEvtListener(_loc_5, param2, param3, param4);
            }
            return;
        }// end function

        public function removeEvtListeners(param1:Array, param2:Function) : void
        {
            var _loc_3:* = null;
            for each (_loc_3 in param1)
            {
                
                this.removeEvtListener(_loc_3, param2);
            }
            return;
        }// end function

        public function getBaseEventDispatcher() : IBaseEventDispatcher
        {
            return this;
        }// end function

        public function dispatchEvt(event:Event) : void
        {
            this.dispatchEvent(event);
            return;
        }// end function

    }
}
