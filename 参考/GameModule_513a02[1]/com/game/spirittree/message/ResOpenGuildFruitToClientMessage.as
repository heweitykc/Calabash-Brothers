package com.game.spirittree.message
{
    import __AS3__.vec.*;
    import com.game.spirittree.bean.*;
    import net.*;

    public class ResOpenGuildFruitToClientMessage extends Message
    {
        private var _fruitinfo:Vector.<FruitInfo>;
        private var _aridfruitinfo:Vector.<FruitInfo>;
        private var _theftnum:int;

        public function ResOpenGuildFruitToClientMessage()
        {
            this._fruitinfo = new Vector.<FruitInfo>;
            this._aridfruitinfo = new Vector.<FruitInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._fruitinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._fruitinfo.length)
            {
                
                writeBean(this._fruitinfo[_loc_1]);
                _loc_1++;
            }
            writeShort(this._aridfruitinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._aridfruitinfo.length)
            {
                
                writeBean(this._aridfruitinfo[_loc_1]);
                _loc_1++;
            }
            writeInt(this._theftnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._fruitinfo[_loc_1] = readBean(FruitInfo) as FruitInfo;
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._aridfruitinfo[_loc_1] = readBean(FruitInfo) as FruitInfo;
                _loc_1++;
            }
            this._theftnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 133103;
        }// end function

        public function get fruitinfo() : Vector.<FruitInfo>
        {
            return this._fruitinfo;
        }// end function

        public function set fruitinfo(param1:Vector.<FruitInfo>) : void
        {
            this._fruitinfo = param1;
            return;
        }// end function

        public function get aridfruitinfo() : Vector.<FruitInfo>
        {
            return this._aridfruitinfo;
        }// end function

        public function set aridfruitinfo(param1:Vector.<FruitInfo>) : void
        {
            this._aridfruitinfo = param1;
            return;
        }// end function

        public function get theftnum() : int
        {
            return this._theftnum;
        }// end function

        public function set theftnum(param1:int) : void
        {
            this._theftnum = param1;
            return;
        }// end function

    }
}
