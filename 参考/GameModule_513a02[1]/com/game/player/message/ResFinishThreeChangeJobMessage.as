package com.game.player.message
{
    import net.*;

    public class ResFinishThreeChangeJobMessage extends Message
    {
        public var result:int;

        public function ResFinishThreeChangeJobMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this.result);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.result = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 120020;
        }// end function

    }
}
