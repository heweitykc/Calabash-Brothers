package com.game.zones.message
{
    import net.*;

    public class ReqZoneOutMessage extends Message
    {

        public function ReqZoneOutMessage()
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
            return 128204;
        }// end function

    }
}
