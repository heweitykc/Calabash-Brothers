package com.game.signwage.message
{
    import net.*;

    public class ReqSignToClientMessage extends Message
    {

        public function ReqSignToClientMessage()
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
            return 152201;
        }// end function

    }
}
