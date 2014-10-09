package com.game.zones.message
{
    import net.*;

    public class ReqZoneContinuousRaidsMessage extends Message
    {

        public function ReqZoneContinuousRaidsMessage()
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
            return 128208;
        }// end function

    }
}
