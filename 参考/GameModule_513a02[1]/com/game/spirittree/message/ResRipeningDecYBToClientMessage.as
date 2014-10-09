package com.game.spirittree.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRipeningDecYBToClientMessage extends Message
    {
        private var _fruitid:long;
        private var _yuanbao:int;
        private var _type:int;

        public function ResRipeningDecYBToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._fruitid);
            writeInt(this._yuanbao);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._fruitid = readLong();
            this._yuanbao = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 133106;
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

        public function get yuanbao() : int
        {
            return this._yuanbao;
        }// end function

        public function set yuanbao(param1:int) : void
        {
            this._yuanbao = param1;
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

    }
}
