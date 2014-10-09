package com.game.player.message
{
    import net.*;

    public class ReqCollectionRewardMessage extends Message
    {

        public function ReqCollectionRewardMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 55002;
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
