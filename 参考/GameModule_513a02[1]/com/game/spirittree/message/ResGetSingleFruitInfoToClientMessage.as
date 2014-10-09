package com.game.spirittree.message
{
    import com.game.spirittree.bean.*;
    import net.*;

    public class ResGetSingleFruitInfoToClientMessage extends Message
    {
        private var _fruitinfo:FruitInfo;
        private var _type:int;
        private var _exp:int;
        private var _num:int;

        public function ResGetSingleFruitInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._fruitinfo);
            writeByte(this._type);
            writeInt(this._exp);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fruitinfo = readBean(FruitInfo) as FruitInfo;
            this._type = readByte();
            this._exp = readInt();
            this._num = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 133102;
        }// end function

        public function get fruitinfo() : FruitInfo
        {
            return this._fruitinfo;
        }// end function

        public function set fruitinfo(param1:FruitInfo) : void
        {
            this._fruitinfo = param1;
            return;
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

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

    }
}
