package com.game.challenge.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class BossKillInfo extends Bean
    {
        private var _bossId:int;
        private var _events:Vector.<BossKillEventInfo>;
        private var _isDead:int;

        public function BossKillInfo()
        {
            this._events = new Vector.<BossKillEventInfo>;
            return;
        }// end function

        public function set bossId(param1:int) : void
        {
            this._bossId = param1;
            return;
        }// end function

        public function get bossId() : int
        {
            return this._bossId;
        }// end function

        public function set events(param1:Vector.<BossKillEventInfo>) : void
        {
            this._events = param1;
            return;
        }// end function

        public function get events() : Vector.<BossKillEventInfo>
        {
            return this._events;
        }// end function

        public function set isDead(param1:int) : void
        {
            this._isDead = param1;
            return;
        }// end function

        public function get isDead() : int
        {
            return this._isDead;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._bossId);
            writeShort(this._events.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._events.length)
            {
                
                writeBean(this._events[_loc_1]);
                _loc_1++;
            }
            writeByte(this._isDead);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._bossId = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._events[_loc_2] = readBean(BossKillEventInfo) as BossKillEventInfo;
                _loc_2++;
            }
            this._isDead = readByte();
            return true;
        }// end function

    }
}
