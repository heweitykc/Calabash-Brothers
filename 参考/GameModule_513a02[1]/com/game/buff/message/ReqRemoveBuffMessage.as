package com.game.buff.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqRemoveBuffMessage extends Message
    {
        private var _buffId:long;

        public function ReqRemoveBuffMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._buffId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._buffId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 113201;
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

    }
}
