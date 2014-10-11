package com.game.lostskills.message
{
    import net.*;

    public class ReqLostSkillInfosMessage extends Message
    {

        public function ReqLostSkillInfosMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600205;
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
