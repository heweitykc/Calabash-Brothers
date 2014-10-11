package com.game.signwage.message
{
    import net.*;

    public class ReqClickSignToClientMessage extends Message
    {

        public function ReqClickSignToClientMessage()
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
            return 152206;
        }// end function

    }
}
