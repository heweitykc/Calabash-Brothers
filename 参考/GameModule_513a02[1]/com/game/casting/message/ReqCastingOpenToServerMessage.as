package com.game.casting.message
{
    import net.*;

    public class ReqCastingOpenToServerMessage extends Message
    {

        public function ReqCastingOpenToServerMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 529201;
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
