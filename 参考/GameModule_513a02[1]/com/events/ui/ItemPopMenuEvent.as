package com.events.ui
{
    import flash.events.*;

    public class ItemPopMenuEvent extends Event
    {
        public var itemDate:String;
        public static const SELECT_MENU:String = "SELECT_MENU";

        public function ItemPopMenuEvent(param1:String, param2:String)
        {
            this.itemDate = param2;
            super(param1);
            return;
        }// end function

    }
}
