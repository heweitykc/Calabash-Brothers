package com.game.activitiesoverview.message
{
    import __AS3__.vec.*;
    import com.game.activitiesoverview.bean.*;
    import net.*;

    public class ResLivenessEventsToClientMessage extends Message
    {
        private var _event:Vector.<LivenessEventInfo>;

        public function ResLivenessEventsToClientMessage()
        {
            this._event = new Vector.<LivenessEventInfo>;
            return;
        }// end function

        public function get event() : Vector.<LivenessEventInfo>
        {
            return this._event;
        }// end function

        public function set event(param1:Vector.<LivenessEventInfo>) : void
        {
            this._event = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._event.length);
            _loc_1 = 0;
            while (_loc_1 < this._event.length)
            {
                
                writeBean(this._event[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._event[_loc_1] = readBean(LivenessEventInfo) as LivenessEventInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 600103;
        }// end function

    }
}
