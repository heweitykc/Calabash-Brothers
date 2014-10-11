package com.game.zones.message
{
    import net.*;

    public class ReqTowerRewardMessage extends Message
    {

        public function ReqTowerRewardMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600201;
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
