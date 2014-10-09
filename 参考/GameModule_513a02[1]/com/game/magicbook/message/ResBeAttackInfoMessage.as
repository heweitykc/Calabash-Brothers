package com.game.magicbook.message
{
    import __AS3__.vec.*;
    import com.game.magicbook.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResBeAttackInfoMessage extends Message
    {
        private var _sourceId:long;
        private var _beAttacks:Vector.<MagicBeAttackInfo>;

        public function ResBeAttackInfoMessage()
        {
            this._beAttacks = new Vector.<MagicBeAttackInfo>;
            return;
        }// end function

        public function set sourceId(param1:long) : void
        {
            this._sourceId = param1;
            return;
        }// end function

        public function get sourceId() : long
        {
            return this._sourceId;
        }// end function

        public function set beAttacks(param1:Vector.<MagicBeAttackInfo>) : void
        {
            this._beAttacks = param1;
            return;
        }// end function

        public function get beAttacks() : Vector.<MagicBeAttackInfo>
        {
            return this._beAttacks;
        }// end function

        override public function getId() : int
        {
            return 600035;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._sourceId);
            writeShort(this._beAttacks.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._beAttacks.length)
            {
                
                writeBean(this._beAttacks[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._sourceId = readLong();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._beAttacks[_loc_2] = readBean(MagicBeAttackInfo) as MagicBeAttackInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
