package com.game.team.message
{
    import net.*;

    public class ReqCreateateamGameMessage extends Message
    {

        public function ReqCreateateamGameMessage()
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
            return 118201;
        }// end function

    }
}
