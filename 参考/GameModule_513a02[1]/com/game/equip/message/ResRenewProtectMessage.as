package com.game.equip.message
{
    import net.*;

    public class ResRenewProtectMessage extends Message
    {
        public var result:int;

        public function ResRenewProtectMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 116005;
        }// end function

        override protected function reading() : Boolean
        {
            this.result = readByte();
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this.result);
            return true;
        }// end function

    }
}
