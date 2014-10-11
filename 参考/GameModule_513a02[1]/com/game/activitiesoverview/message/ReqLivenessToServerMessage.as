package com.game.activitiesoverview.message
{
    import net.*;

    public class ReqLivenessToServerMessage extends Message
    {

        public function ReqLivenessToServerMessage()
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
            return 600100;
        }// end function

    }
}
