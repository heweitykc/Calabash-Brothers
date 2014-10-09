package com.game.skill.message
{
    import net.*;

    public class ReqCompleteMomentMessage extends Message
    {

        public function ReqCompleteMomentMessage()
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
            return 107204;
        }// end function

    }
}
