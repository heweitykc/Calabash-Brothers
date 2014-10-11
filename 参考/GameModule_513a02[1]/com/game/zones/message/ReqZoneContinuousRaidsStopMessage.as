package com.game.zones.message
{
    import net.*;

    public class ReqZoneContinuousRaidsStopMessage extends Message
    {

        public function ReqZoneContinuousRaidsStopMessage()
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
            return 128210;
        }// end function

    }
}
