package com.game.spirittree.message
{
    import com.game.utils.*;
    import net.*;

    public class ResShowToRewardListToClientMessage extends Message
    {
        private var _fruitid:long;
        private var _type:int;
        private var _index:int;

        public function ResShowToRewardListToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._fruitid);
            writeByte(this._type);
            writeInt(this._index);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fruitid = readLong();
            this._type = readByte();
            this._index = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 133104;
        }// end function

        public function get fruitid() : long
        {
            return this._fruitid;
        }// end function

        public function set fruitid(param1:long) : void
        {
            this._fruitid = param1;
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

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

    }
}
