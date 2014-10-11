package com.game.lostskills.bean
{
    import net.*;

    public class LostSkillInfo extends Bean
    {
        private var _skillId:int;
        private var _skillType:int;
        private var _skillLv:int;

        public function LostSkillInfo()
        {
            return;
        }// end function

        public function set skillId(param1:int) : void
        {
            this._skillId = param1;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function set skillType(param1:int) : void
        {
            this._skillType = param1;
            return;
        }// end function

        public function get skillType() : int
        {
            return this._skillType;
        }// end function

        public function set skillLv(param1:int) : void
        {
            this._skillLv = param1;
            return;
        }// end function

        public function get skillLv() : int
        {
            return this._skillLv;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skillId);
            writeInt(this._skillType);
            writeInt(this._skillLv);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillId = readInt();
            this._skillType = readInt();
            this._skillLv = readInt();
            return true;
        }// end function

    }
}
