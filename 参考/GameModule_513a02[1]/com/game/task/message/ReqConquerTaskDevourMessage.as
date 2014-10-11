package com.game.task.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqConquerTaskDevourMessage extends Message
    {
        private var _devourId:long;
        private var _isfull:int;

        public function ReqConquerTaskDevourMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._devourId);
            writeByte(this._isfull);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._devourId = readLong();
            this._isfull = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120208;
        }// end function

        public function get devourId() : long
        {
            return this._devourId;
        }// end function

        public function set devourId(param1:long) : void
        {
            this._devourId = param1;
            return;
        }// end function

        public function get isfull() : int
        {
            return this._isfull;
        }// end function

        public function set isfull(param1:int) : void
        {
            this._isfull = param1;
            return;
        }// end function

    }
}
