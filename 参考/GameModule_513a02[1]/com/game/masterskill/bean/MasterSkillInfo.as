package com.game.masterskill.bean
{
    import net.*;

    public class MasterSkillInfo extends Bean
    {
        private var _skillID:int;
        private var _level:int;

        public function MasterSkillInfo()
        {
            return;
        }// end function

        public function set skillID(param1:int) : void
        {
            this._skillID = param1;
            return;
        }// end function

        public function get skillID() : int
        {
            return this._skillID;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skillID);
            writeInt(this._level);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillID = readInt();
            this._level = readInt();
            return true;
        }// end function

    }
}
