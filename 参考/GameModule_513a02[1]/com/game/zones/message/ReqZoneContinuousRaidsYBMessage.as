package com.game.zones.message
{
    import net.*;

    public class ReqZoneContinuousRaidsYBMessage extends Message
    {

        public function ReqZoneContinuousRaidsYBMessage()
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
            return 128209;
        }// end function

    }
}
