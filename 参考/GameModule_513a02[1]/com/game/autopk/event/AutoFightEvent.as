package com.game.autopk.event
{
    import flash.events.*;

    public class AutoFightEvent extends Event
    {
        public static const PICK_COMPLETE:String = "pick_complete";
        public static const AUTO_FIGHT_STOP:String = "auto_fight_stop";
        public static const CLOSE_AUTO_FIGHT_ICON:String = "close_auto_fight_icon";
        public static const PICK_ONE_ITEM:String = "pick_one_item";
        public static const BEGIN_AUTO:String = "begin_auto_event";
        public static const END_AUTO:String = "end_auto_event";
        public static const PICK_COMPLETE_ALL:String = "pick_complete_all";
        public static const AUTO_FIGHT_CONFIG_UPDATE:String = "auto_fight_config_update";

        public function AutoFightEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
