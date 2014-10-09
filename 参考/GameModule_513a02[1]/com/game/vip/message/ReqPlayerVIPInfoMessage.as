package com.game.vip.message
{
    import net.*;

    public class ReqPlayerVIPInfoMessage extends Message
    {

        public function ReqPlayerVIPInfoMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 147202;
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
