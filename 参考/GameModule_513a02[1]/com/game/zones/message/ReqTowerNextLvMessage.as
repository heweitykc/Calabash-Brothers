package com.game.zones.message
{
    import net.*;

    public class ReqTowerNextLvMessage extends Message
    {

        public function ReqTowerNextLvMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600202;
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
