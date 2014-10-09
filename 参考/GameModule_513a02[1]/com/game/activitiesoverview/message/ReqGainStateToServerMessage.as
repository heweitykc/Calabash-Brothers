package com.game.activitiesoverview.message
{
    import net.*;

    public class ReqGainStateToServerMessage extends Message
    {

        public function ReqGainStateToServerMessage()
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
            return 600106;
        }// end function

    }
}
