package com.game.offline.message
{
    import net.*;

    public class ReqRetreatInfoMessage extends Message
    {

        public function ReqRetreatInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

        override public function getId() : int
        {
            return 150201;
        }// end function

    }
}
