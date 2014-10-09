package com.game.skill.message
{
    import com.game.skill.bean.*;
    import net.*;

    public class SkillChangeMessage extends Message
    {
        private var _skills:CSSkillInfo;

        public function SkillChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._skills);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skills = readBean(CSSkillInfo) as CSSkillInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 107107;
        }// end function

        public function get skills() : CSSkillInfo
        {
            return this._skills;
        }// end function

        public function set skills(param1:CSSkillInfo) : void
        {
            this._skills = param1;
            return;
        }// end function

    }
}
