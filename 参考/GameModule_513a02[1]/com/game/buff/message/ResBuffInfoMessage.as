package com.game.buff.message
{
    import com.game.utils.*;
    import net.*;

    public class ResBuffInfoMessage extends Message
    {
        private var _buffId:long;
        private var _value:int;
        private var _remain:int;

        public function ResBuffInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._buffId);
            writeInt(this._value);
            writeInt(this._remain);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._buffId = readLong();
            this._value = readInt();
            this._remain = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 113104;
        }// end function

        public function get buffId() : long
        {
            return this._buffId;
        }// end function

        public function set buffId(param1:long) : void
        {
            this._buffId = param1;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        public function set value(param1:int) : void
        {
            this._value = param1;
            return;
        }// end function

        public function get remain() : int
        {
            return this._remain;
        }// end function

        public function set remain(param1:int) : void
        {
            this._remain = param1;
            return;
        }// end function

    }
}
