package com.game.challenge.message
{
    import __AS3__.vec.*;
    import com.game.challenge.bean.*;
    import net.*;

    public class ResBossEventMessage extends Message
    {
        private var _type:int;
        private var _events:Vector.<BossEventInfo>;
        private var _pandoraEvents:Vector.<PandoraEventInfo>;

        public function ResBossEventMessage()
        {
            this._events = new Vector.<BossEventInfo>;
            this._pandoraEvents = new Vector.<PandoraEventInfo>;
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set events(param1:Vector.<BossEventInfo>) : void
        {
            this._events = param1;
            return;
        }// end function

        public function get events() : Vector.<BossEventInfo>
        {
            return this._events;
        }// end function

        public function set pandoraEvents(param1:Vector.<PandoraEventInfo>) : void
        {
            this._pandoraEvents = param1;
            return;
        }// end function

        public function get pandoraEvents() : Vector.<PandoraEventInfo>
        {
            return this._pandoraEvents;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._type);
            writeShort(this._events.length);
            _loc_1 = 0;
            while (_loc_1 < this._events.length)
            {
                
                writeBean(this._events[_loc_1]);
                _loc_1++;
            }
            writeShort(this._pandoraEvents.length);
            _loc_1 = 0;
            while (_loc_1 < this._pandoraEvents.length)
            {
                
                writeBean(this._pandoraEvents[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._type = readByte();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._events[_loc_2] = readBean(BossEventInfo) as BossEventInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._pandoraEvents[_loc_2] = readBean(PandoraEventInfo) as PandoraEventInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
