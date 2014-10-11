package com.game.activitiesoverview.message
{
    import net.*;

    public class ReqLivenessEventsToServerMessage extends Message
    {

        public function ReqLivenessEventsToServerMessage()
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
            return 600102;
        }// end function

    }
}
