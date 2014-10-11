package com.game.cloudbuy.message
{
    import net.*;

    public class ReqOpenCloudBuyInfoToServerMessage extends Message
    {

        public function ReqOpenCloudBuyInfoToServerMessage()
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
            return 529210;
        }// end function

    }
}
