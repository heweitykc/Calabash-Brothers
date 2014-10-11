package com.game.zones.message
{
    import net.*;

    public class ResTowerNextLvMessage extends Message
    {

        public function ResTowerNextLvMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600002;
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
