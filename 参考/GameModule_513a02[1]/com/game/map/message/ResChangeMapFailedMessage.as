package com.game.map.message
{
    import net.*;

    public class ResChangeMapFailedMessage extends Message
    {

        public function ResChangeMapFailedMessage()
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
            return 101126;
        }// end function

    }
}
