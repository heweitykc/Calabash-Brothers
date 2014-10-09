package com.game.task.message
{
    import net.*;

    public class ReqRankTaskQuckFinshAllMessage extends Message
    {

        public function ReqRankTaskQuckFinshAllMessage()
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
            return 120215;
        }// end function

    }
}
