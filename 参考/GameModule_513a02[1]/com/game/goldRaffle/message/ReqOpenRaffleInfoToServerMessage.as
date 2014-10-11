package com.game.goldRaffle.message
{
    import net.*;

    public class ReqOpenRaffleInfoToServerMessage extends Message
    {

        public function ReqOpenRaffleInfoToServerMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 528201;
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
