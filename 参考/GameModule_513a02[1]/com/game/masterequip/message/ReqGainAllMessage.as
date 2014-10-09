package com.game.masterequip.message
{
    import net.*;

    public class ReqGainAllMessage extends Message
    {

        public function ReqGainAllMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600219;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
