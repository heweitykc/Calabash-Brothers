package com.game.elementHeart.event
{
    import flash.events.*;

    public class EHeartEvent extends Event
    {
        private var _obj:Object;
        private var _locate:int;
        public static const FRESH_PlAYER:String = "freshPlayer";
        public static const FRESH_BACKPACK:String = "freshBackpack";
        public static const FRESH_HOUSE:String = "freshHouse";
        public static const ADD_PLAYER:String = "AddPlayer";
        public static const ADD_BACKPACK:String = "AddBackPack";
        public static const ADD_HOUSE:String = "AddHouse";
        public static const DELETE_PLAYER:String = "deletePlayer";
        public static const DELETE_BACKPACK:String = "deleteBackPack";
        public static const DELETE_HOUSE:String = "deleteHouse";
        public static const CHANGE_VALUE:String = "changeValue";
        public static const DRAG_FALSE:String = "dragFalse";

        public function EHeartEvent(param1:String, param2, param3:Boolean = false, param4:Boolean = false)
        {
            this._obj = param2;
            super(param1, param3, param4);
            return;
        }// end function

        public function get locate() : int
        {
            return this._locate;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

    }
}
