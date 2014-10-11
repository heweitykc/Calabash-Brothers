package com.game.zones.message
{
    import net.*;

    public class ReqZoneAutoAwardToGameMessage extends Message
    {

        public function ReqZoneAutoAwardToGameMessage()
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
            return 128214;
        }// end function

    }
}
