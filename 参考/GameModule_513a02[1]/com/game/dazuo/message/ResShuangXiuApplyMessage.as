package com.game.dazuo.message
{
    import com.game.utils.*;
    import net.*;

    public class ResShuangXiuApplyMessage extends Message
    {
        private var _role:long;

        public function ResShuangXiuApplyMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._role);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._role = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 136104;
        }// end function

        public function get role() : long
        {
            return this._role;
        }// end function

        public function set role(param1:long) : void
        {
            this._role = param1;
            return;
        }// end function

    }
}
