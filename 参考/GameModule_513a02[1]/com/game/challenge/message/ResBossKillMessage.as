package com.game.challenge.message
{
    import __AS3__.vec.*;
    import com.game.challenge.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResBossKillMessage extends Message
    {
        private var _bossInfos:Vector.<BossKillInfo>;
        private var _serverTime:long;

        public function ResBossKillMessage()
        {
            this._bossInfos = new Vector.<BossKillInfo>;
            return;
        }// end function

        public function set bossInfos(param1:Vector.<BossKillInfo>) : void
        {
            this._bossInfos = param1;
            return;
        }// end function

        public function get bossInfos() : Vector.<BossKillInfo>
        {
            return this._bossInfos;
        }// end function

        public function set serverTime(param1:long) : void
        {
            this._serverTime = param1;
            return;
        }// end function

        public function get serverTime() : long
        {
            return this._serverTime;
        }// end function

        override public function getId() : int
        {
            return 510021;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._bossInfos.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._bossInfos.length)
            {
                
                writeBean(this._bossInfos[_loc_1]);
                _loc_1++;
            }
            writeLong(this._serverTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._bossInfos[_loc_2] = readBean(BossKillInfo) as BossKillInfo;
                _loc_2++;
            }
            this._serverTime = readLong();
            return true;
        }// end function

    }
}
