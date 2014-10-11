package com.game.casting.message
{
    import net.*;

    public class ReqCastingRewardToServerMessage extends Message
    {

        public function ReqCastingRewardToServerMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 529202;
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
