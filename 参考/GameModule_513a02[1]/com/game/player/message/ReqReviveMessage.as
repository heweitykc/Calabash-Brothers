package com.game.player.message
{
    import net.*;

    public class ReqReviveMessage extends Message
    {

        public function ReqReviveMessage()
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
            return 103201;
        }// end function

    }
}
