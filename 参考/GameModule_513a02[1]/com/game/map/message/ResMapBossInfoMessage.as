package com.game.map.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResMapBossInfoMessage extends Message
    {
        private var _bossIds:Vector.<int>;
        private var _bossReviveTime:Vector.<int>;

        public function ResMapBossInfoMessage()
        {
            this._bossIds = new Vector.<int>;
            this._bossReviveTime = new Vector.<int>;
            return;
        }// end function

        public function set bossIds(param1:Vector.<int>) : void
        {
            this._bossIds = param1;
            return;
        }// end function

        public function get bossIds() : Vector.<int>
        {
            return this._bossIds;
        }// end function

        public function set bossReviveTime(param1:Vector.<int>) : void
        {
            this._bossReviveTime = param1;
            return;
        }// end function

        public function get bossReviveTime() : Vector.<int>
        {
            return this._bossReviveTime;
        }// end function

        override public function getId() : int
        {
            return 504000;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._bossIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._bossIds.length)
            {
                
                writeInt(this._bossIds[_loc_1]);
                _loc_1++;
            }
            writeShort(this._bossReviveTime.length);
            _loc_1 = 0;
            while (_loc_1 < this._bossReviveTime.length)
            {
                
                writeInt(this._bossReviveTime[_loc_1]);
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
                
                this._bossIds[_loc_1] = readInt();
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._bossReviveTime[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

    }
}
