package com.game.clickstream
{
    import com.*;
    import com.util.smallglobal.*;

    public class ClickStream extends Object
    {
        public static var host:String = "admin.yolk7.com";
        private static var msgs:Array = new Array();
        private static var msgCallbacks:Array = new Array();

        public function ClickStream()
        {
            return;
        }// end function

        public static function add(param1:ClickStreamId) : void
        {
            return;
        }// end function

        private static function addArged(param1:ClickStreamTriggerType, param2) : void
        {
            var _loc_3:* = param1.getCfg(param2);
            if (!_loc_3)
            {
                return;
            }
            var _loc_4:* = SmallGlobal.instance.playerLevel;
            if (SmallGlobal.instance.playerLevel != 0)
            {
                if (_loc_3.q_min_player_level != 0 && _loc_3.q_min_player_level > _loc_4 || _loc_3.q_max_player_level != 0 && _loc_3.q_max_player_level < _loc_4)
                {
                    return;
                }
            }
            add(new ClickStreamId(_loc_3.q_id, param1.name + "：" + param2));
            return;
        }// end function

        public static function finishTask(param1:int) : void
        {
            addArged(ClickStreamTriggerType.FINISH_TASK, param1);
            return;
        }// end function

        public static function quickUseEquip(param1:int) : void
        {
            addArged(ClickStreamTriggerType.QUICK_USE_EQUIP, param1);
            return;
        }// end function

        public static function quickUseItem(param1:int) : void
        {
            addArged(ClickStreamTriggerType.QUICK_USE_ITEM, param1);
            return;
        }// end function

        public static function openFunction(param1:int) : void
        {
            addArged(ClickStreamTriggerType.OPEN_FUNCTION, param1);
            return;
        }// end function

        public static function enterZone(param1:int) : void
        {
            addArged(ClickStreamTriggerType.ENTER_ZONE, param1);
            return;
        }// end function

        public static function exitZone(param1:int) : void
        {
            addArged(ClickStreamTriggerType.EXIT_ZONE, param1);
            return;
        }// end function

        public static function transferGuide(param1:int) : void
        {
            addArged(ClickStreamTriggerType.TRANSFER_GUIDE, param1);
            return;
        }// end function

        private static function addMsg(param1:String) : void
        {
            if (!BasicGlobal.jinhui.clickStream)
            {
                return;
            }
            if (msgCallbacks.length == 0)
            {
                msgs.push(param1);
            }
            else
            {
                showMsg(param1);
            }
            return;
        }// end function

        public static function setMsgCallback(param1:Function) : void
        {
            var _loc_2:* = null;
            if (!BasicGlobal.jinhui.clickStream)
            {
                return;
            }
            msgCallbacks.push(param1);
            if (msgs.length > 0)
            {
                for each (_loc_2 in msgs)
                {
                    
                    showMsg(_loc_2);
                }
                msgs = new Array();
            }
            return;
        }// end function

        private static function showMsg(param1:String) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in msgCallbacks)
            {
                
                ClickStream._loc_2(param1);
            }
            return;
        }// end function

    }
}
