package com.game.player.message
{
    import net.*;

    public class ResAttributeChangeMessage extends Message
    {
        public var param:String;

        public function ResAttributeChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this.param);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.param = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 511010;
        }// end function

    }
}
