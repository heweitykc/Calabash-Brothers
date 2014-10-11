package com.game.store.message
{
    import net.*;

    public class ReqOpenStoreMessage extends Message
    {

        public function ReqOpenStoreMessage()
        {
            return;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override public function getId() : int
        {
            return 112208;
        }// end function

    }
}
