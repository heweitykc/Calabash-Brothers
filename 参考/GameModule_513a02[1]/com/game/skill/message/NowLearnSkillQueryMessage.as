package com.game.skill.message
{
    import net.*;

    public class NowLearnSkillQueryMessage extends Message
    {

        public function NowLearnSkillQueryMessage()
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
            return 107205;
        }// end function

    }
}
