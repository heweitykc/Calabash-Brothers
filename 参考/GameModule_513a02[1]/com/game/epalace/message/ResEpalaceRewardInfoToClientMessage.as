package com.game.epalace.message
{
    import __AS3__.vec.*;
    import com.game.spirittree.bean.*;
    import net.*;

    public class ResEpalaceRewardInfoToClientMessage extends Message
    {
        private var _type:int;
        private var _fruitrewardinfo:Vector.<FruitRewardinfo>;
        private var _buffid:int;

        public function ResEpalaceRewardInfoToClientMessage()
        {
            this._fruitrewardinfo = new Vector.<FruitRewardinfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._type);
            writeShort(this._fruitrewardinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._fruitrewardinfo.length)
            {
                
                writeBean(this._fruitrewardinfo[_loc_1]);
                _loc_1++;
            }
            writeInt(this._buffid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._type = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._fruitrewardinfo[_loc_1] = readBean(FruitRewardinfo) as FruitRewardinfo;
                _loc_1++;
            }
            this._buffid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 143106;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get fruitrewardinfo() : Vector.<FruitRewardinfo>
        {
            return this._fruitrewardinfo;
        }// end function

        public function set fruitrewardinfo(param1:Vector.<FruitRewardinfo>) : void
        {
            this._fruitrewardinfo = param1;
            return;
        }// end function

        public function get buffid() : int
        {
            return this._buffid;
        }// end function

        public function set buffid(param1:int) : void
        {
            this._buffid = param1;
            return;
        }// end function

    }
}
