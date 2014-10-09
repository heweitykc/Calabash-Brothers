package com.game.protect.message
{
    import net.*;

    public class ResProtectStateMessage extends Message
    {
        public var type:int;

        public function ResProtectStateMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600022;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.type = readByte();
            return true;
        }// end function

    }
}
