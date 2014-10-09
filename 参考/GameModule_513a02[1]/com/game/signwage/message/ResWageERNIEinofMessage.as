package com.game.signwage.message
{
    import __AS3__.vec.*;
    import com.game.spirittree.bean.*;
    import net.*;

    public class ResWageERNIEinofMessage extends Message
    {
        private var _pos:Vector.<int>;
        private var _fruitRewardinfo:Vector.<FruitRewardinfo>;

        public function ResWageERNIEinofMessage()
        {
            this._pos = new Vector.<int>;
            this._fruitRewardinfo = new Vector.<FruitRewardinfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._pos.length);
            _loc_1 = 0;
            while (_loc_1 < this._pos.length)
            {
                
                writeInt(this._pos[_loc_1]);
                _loc_1++;
            }
            writeShort(this._fruitRewardinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._fruitRewardinfo.length)
            {
                
                writeBean(this._fruitRewardinfo[_loc_1]);
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
                
                this._pos[_loc_1] = readInt();
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._fruitRewardinfo[_loc_1] = readBean(FruitRewardinfo) as FruitRewardinfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 152103;
        }// end function

        public function get pos() : Vector.<int>
        {
            return this._pos;
        }// end function

        public function set pos(param1:Vector.<int>) : void
        {
            this._pos = param1;
            return;
        }// end function

        public function get fruitRewardinfo() : Vector.<FruitRewardinfo>
        {
            return this._fruitRewardinfo;
        }// end function

        public function set fruitRewardinfo(param1:Vector.<FruitRewardinfo>) : void
        {
            this._fruitRewardinfo = param1;
            return;
        }// end function

    }
}
