package com.game.player.message
{
    import net.*;

    public class ReqGetActivatedStarInfo extends Message
    {

        public function ReqGetActivatedStarInfo()
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
            return 575201;
        }// end function

    }
}
