package com.game.player.message
{
    import net.*;

    public class ReqFinishThreeChangeJobMessage extends Message
    {

        public function ReqFinishThreeChangeJobMessage()
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
            return 120220;
        }// end function

    }
}
