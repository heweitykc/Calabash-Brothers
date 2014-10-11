package com.game.chat.events
{
    import flash.events.*;

    public class ChatEvent extends Event
    {
        public var data:Object;
        public static const OPEN_PRIVATE_LIST:String = "open_private_list";
        public static const RISIZE_CHAT:String = "resize_chat";
        public static const NAME_CHANGE:String = "name_change";
        public static const PLAYER_SELECTED:String = "player_selected";

        public function ChatEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new ChatEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
