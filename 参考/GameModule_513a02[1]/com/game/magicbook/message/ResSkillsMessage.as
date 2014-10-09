package com.game.magicbook.message
{
    import __AS3__.vec.*;
    import com.game.magicbook.bean.*;
    import net.*;

    public class ResSkillsMessage extends Message
    {
        private var _skills:Vector.<MagicSkillInfo>;

        public function ResSkillsMessage()
        {
            this._skills = new Vector.<MagicSkillInfo>;
            return;
        }// end function

        public function set skills(param1:Vector.<MagicSkillInfo>) : void
        {
            this._skills = param1;
            return;
        }// end function

        public function get skills() : Vector.<MagicSkillInfo>
        {
            return this._skills;
        }// end function

        override public function getId() : int
        {
            return 600033;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._skills.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._skills.length)
            {
                
                writeBean(this._skills[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._skills[_loc_2] = readBean(MagicSkillInfo) as MagicSkillInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
