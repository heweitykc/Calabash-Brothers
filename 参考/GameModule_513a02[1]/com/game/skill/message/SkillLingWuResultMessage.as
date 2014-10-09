package com.game.skill.message
{
    import net.*;

    public class SkillLingWuResultMessage extends Message
    {
        private var _skillModelId:int;
        private var _grade:int;
        private var _issuccess:int;

        public function SkillLingWuResultMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skillModelId);
            writeInt(this._grade);
            writeByte(this._issuccess);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillModelId = readInt();
            this._grade = readInt();
            this._issuccess = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 107105;
        }// end function

        public function get skillModelId() : int
        {
            return this._skillModelId;
        }// end function

        public function set skillModelId(param1:int) : void
        {
            this._skillModelId = param1;
            return;
        }// end function

        public function get grade() : int
        {
            return this._grade;
        }// end function

        public function set grade(param1:int) : void
        {
            this._grade = param1;
            return;
        }// end function

        public function get issuccess() : int
        {
            return this._issuccess;
        }// end function

        public function set issuccess(param1:int) : void
        {
            this._issuccess = param1;
            return;
        }// end function

    }
}
