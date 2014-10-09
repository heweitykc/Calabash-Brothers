package com.game.vip.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.vip.control.*;
    import flash.events.*;

    public class VIPChatIcon extends BaseSprite
    {
        private var _src:String;

        public function VIPChatIcon()
        {
            return;
        }// end function

        public function set src(param1:String) : void
        {
            this._src = param1;
            try
            {
                addChild(ToolKit.getNew(this._src));
            }
            catch (e:Error)
            {
            }
            addEvtListener(MouseEvent.CLICK, this.__click);
            addEvtListener(Event.REMOVED_FROM_STAGE, this.__remove);
            return;
        }// end function

        private function __remove(event:Event) : void
        {
            removeEvtListener(MouseEvent.CLICK, this.__click);
            removeEvtListener(Event.REMOVED_FROM_STAGE, this.__remove);
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            VIPControl.getInstance().openOrCloseVip();
            return;
        }// end function

    }
}
