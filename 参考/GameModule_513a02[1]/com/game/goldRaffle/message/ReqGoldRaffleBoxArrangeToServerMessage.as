package com.game.goldRaffle.message
{
    import net.*;

    public class ReqGoldRaffleBoxArrangeToServerMessage extends Message
    {

        public function ReqGoldRaffleBoxArrangeToServerMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 528206;
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
