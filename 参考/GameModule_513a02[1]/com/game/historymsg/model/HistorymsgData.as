package com.game.historymsg.model
{
    import __AS3__.vec.*;
    import com.game.historymsg.bean.*;
    import com.game.historymsg.event.*;
    import flash.events.*;

    public class HistorymsgData extends EventDispatcher
    {
        public var msgs:Vector.<HistorymsgMsg>;
        private static var instance:HistorymsgData;

        public function HistorymsgData()
        {
            this.msgs = new Vector.<HistorymsgMsg>;
            return;
        }// end function

        public function hasMsgs() : Boolean
        {
            return this.msgs.length > 0;
        }// end function

        public function addMsg(param1:HistorymsgMsg) : void
        {
            this.msgs.push(param1);
            dispatchEvent(new HistorymsgEvent(HistorymsgEvent.HISTORYMSG_DATA_CHANGE));
            return;
        }// end function

        public function removeMsg(param1:HistorymsgMsg) : void
        {
            var _loc_2:* = this.msgs.indexOf(param1);
            if (_loc_2 >= 0)
            {
                this.msgs.splice(_loc_2, 1);
                dispatchEvent(new HistorymsgEvent(HistorymsgEvent.HISTORYMSG_DATA_CHANGE));
            }
            return;
        }// end function

        public function clearMsgs() : void
        {
            if (this.msgs.length > 0)
            {
                this.msgs.length = 0;
                dispatchEvent(new HistorymsgEvent(HistorymsgEvent.HISTORYMSG_DATA_CHANGE));
            }
            return;
        }// end function

        public static function getInstance() : HistorymsgData
        {
            var _loc_1:* = new HistorymsgData;
            instance = new HistorymsgData;
            return instance || _loc_1;
        }// end function

    }
}
