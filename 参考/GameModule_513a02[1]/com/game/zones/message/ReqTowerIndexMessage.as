package com.game.zones.message
{
    import net.*;

    public class ReqTowerIndexMessage extends Message
    {

        public function ReqTowerIndexMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600200;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
