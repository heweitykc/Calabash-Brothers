package com.game.skill.message
{
    import com.game.skill.bean.*;
    import net.*;

    public class SkillAddMessage extends Message
    {
        private var _skill:CSSkillInfo;

        public function SkillAddMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._skill);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skill = readBean(CSSkillInfo) as CSSkillInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 107102;
        }// end function

        public function get skill() : CSSkillInfo
        {
            return this._skill;
        }// end function

        public function set skill(param1:CSSkillInfo) : void
        {
            this._skill = param1;
            return;
        }// end function

    }
}
