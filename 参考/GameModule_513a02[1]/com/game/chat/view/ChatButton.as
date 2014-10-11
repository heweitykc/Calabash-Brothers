package com.game.chat.view
{
    import com.f1.ui.btn.*;
    import com.game.chat.control.*;
    import flash.events.*;

    public class ChatButton extends BaseButton
    {

        public function ChatButton(param1 = null, param2:Boolean = false, param3 = null)
        {
            super(param1, param2, param3);
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
            ChatController.getInstance().openHorn();
            return;
        }// end function

    }
}
