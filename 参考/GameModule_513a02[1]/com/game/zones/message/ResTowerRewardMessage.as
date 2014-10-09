package com.game.zones.message
{
    import net.*;

    public class ResTowerRewardMessage extends Message
    {

        public function ResTowerRewardMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600203;
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
