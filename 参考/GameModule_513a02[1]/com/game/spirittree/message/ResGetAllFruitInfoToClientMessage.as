package com.game.spirittree.message
{
    import __AS3__.vec.*;
    import com.game.spirittree.bean.*;
    import net.*;

    public class ResGetAllFruitInfoToClientMessage extends Message
    {
        private var _fruitinfo:Vector.<FruitInfo>;
        private var _nexttime:int;
        private var _nextdew:int;
        private var _dewnum:int;

        public function ResGetAllFruitInfoToClientMessage()
        {
            this._fruitinfo = new Vector.<FruitInfo>;
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
            writeInt(this._nexttime);
            writeInt(this._nextdew);
            writeInt(this._dewnum);
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
            this._nexttime = readInt();
            this._nextdew = readInt();
            this._dewnum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 133101;
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

        public function get nexttime() : int
        {
            return this._nexttime;
        }// end function

        public function set nexttime(param1:int) : void
        {
            this._nexttime = param1;
            return;
        }// end function

        public function get nextdew() : int
        {
            return this._nextdew;
        }// end function

        public function set nextdew(param1:int) : void
        {
            this._nextdew = param1;
            return;
        }// end function

        public function get dewnum() : int
        {
            return this._dewnum;
        }// end function

        public function set dewnum(param1:int) : void
        {
            this._dewnum = param1;
            return;
        }// end function

    }
}
