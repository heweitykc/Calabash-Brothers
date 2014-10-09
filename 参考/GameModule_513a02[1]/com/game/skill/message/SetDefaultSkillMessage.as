package com.game.skill.message
{
    import net.*;

    public class SetDefaultSkillMessage extends Message
    {
        private var _defaultSkill:int;

        public function SetDefaultSkillMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._defaultSkill);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._defaultSkill = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 107203;
        }// end function

        public function get defaultSkill() : int
        {
            return this._defaultSkill;
        }// end function

        public function set defaultSkill(param1:int) : void
        {
            this._defaultSkill = param1;
            return;
        }// end function

    }
}
