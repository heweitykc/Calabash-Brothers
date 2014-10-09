package com.game.player.message
{
    import net.*;

    public class ReqActivateStar extends Message
    {

        public function ReqActivateStar()
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
            return 575202;
        }// end function

    }
}
