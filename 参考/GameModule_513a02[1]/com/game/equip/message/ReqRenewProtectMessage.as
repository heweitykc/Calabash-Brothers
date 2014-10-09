package com.game.equip.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqRenewProtectMessage extends Message
    {
        public var itemId:long;

        public function ReqRenewProtectMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 116205;
        }// end function

        override protected function reading() : Boolean
        {
            this.itemId = readLong();
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this.itemId);
            return true;
        }// end function

    }
}
