package com.game.player.message
{
    import net.*;

    public class ReqCollectImproveRewardMessage extends Message
    {

        public function ReqCollectImproveRewardMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 529215;
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
