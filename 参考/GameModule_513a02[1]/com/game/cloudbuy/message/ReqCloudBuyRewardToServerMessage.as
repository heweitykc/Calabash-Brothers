package com.game.cloudbuy.message
{
    import net.*;

    public class ReqCloudBuyRewardToServerMessage extends Message
    {

        public function ReqCloudBuyRewardToServerMessage()
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
            return 529212;
        }// end function

    }
}
