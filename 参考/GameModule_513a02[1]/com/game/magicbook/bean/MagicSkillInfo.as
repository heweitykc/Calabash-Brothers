package com.game.magicbook.bean
{
    import net.*;

    public class MagicSkillInfo extends Bean
    {
        private var _skillModelId:int;
        private var _skillLv:int;

        public function MagicSkillInfo()
        {
            return;
        }// end function

        public function set skillModelId(param1:int) : void
        {
            this._skillModelId = param1;
            return;
        }// end function

        public function get skillModelId() : int
        {
            return this._skillModelId;
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
            writeInt(this._skillModelId);
            writeInt(this._skillLv);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillModelId = readInt();
            this._skillLv = readInt();
            return true;
        }// end function

    }
}
