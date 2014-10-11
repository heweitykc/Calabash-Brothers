package com.game.casting.message
{
    import net.*;

    public class ReqCastingSellToServerMessage extends Message
    {

        public function ReqCastingSellToServerMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 529205;
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
