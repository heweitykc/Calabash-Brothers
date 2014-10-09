package com.game.masterskill.message
{
    import net.*;

    public class ResResetAllSkillCDTime extends Message
    {

        public function ResResetAllSkillCDTime()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 504107;
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
