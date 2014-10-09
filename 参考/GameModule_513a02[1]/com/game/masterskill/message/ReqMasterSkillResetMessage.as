package com.game.masterskill.message
{
    import net.*;

    public class ReqMasterSkillResetMessage extends Message
    {

        public function ReqMasterSkillResetMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 504103;
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
