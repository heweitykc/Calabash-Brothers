package com.game.monster.message
{
    import __AS3__.vec.*;
    import com.game.monster.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResResponseBossDamageMessage extends Message
    {
        private var _monsterId:long;
        private var _damageInfos:Vector.<CaptainDamageInfo>;

        public function ResResponseBossDamageMessage()
        {
            this._damageInfos = new Vector.<CaptainDamageInfo>;
            return;
        }// end function

        public function set monsterId(param1:long) : void
        {
            this._monsterId = param1;
            return;
        }// end function

        public function get monsterId() : long
        {
            return this._monsterId;
        }// end function

        public function set damageInfos(param1:Vector.<CaptainDamageInfo>) : void
        {
            this._damageInfos = param1;
            return;
        }// end function

        public function get damageInfos() : Vector.<CaptainDamageInfo>
        {
            return this._damageInfos;
        }// end function

        override public function getId() : int
        {
            return 505010;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._monsterId);
            writeShort(this._damageInfos.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._damageInfos.length)
            {
                
                writeBean(this._damageInfos[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterId = readLong();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._damageInfos[_loc_2] = readBean(CaptainDamageInfo) as CaptainDamageInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
