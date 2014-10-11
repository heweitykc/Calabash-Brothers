package com.game.protect.message
{
    import net.*;

    public class ResPointToClientMessage extends Message
    {
        public var type:int;

        public function ResPointToClientMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 164102;
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
