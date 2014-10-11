package com.game.zones.message
{
    import net.*;

    public class ReqZoneOpenPanelMessage extends Message
    {

        public function ReqZoneOpenPanelMessage()
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
            return 128206;
        }// end function

    }
}
