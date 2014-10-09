package com.game.goldRaffle.message
{
    import net.*;

    public class ReqOpenGoldRaffleBoxInfoToServerMessage extends Message
    {

        public function ReqOpenGoldRaffleBoxInfoToServerMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 528203;
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
