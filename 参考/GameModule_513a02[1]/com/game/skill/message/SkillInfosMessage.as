package com.game.skill.message
{
    import __AS3__.vec.*;
    import com.game.skill.bean.*;
    import net.*;

    public class SkillInfosMessage extends Message
    {
        private var _defaultSkill:int;
        private var _skills:Vector.<CSSkillInfo>;

        public function SkillInfosMessage()
        {
            this._skills = new Vector.<CSSkillInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._defaultSkill);
            writeShort(this._skills.length);
            _loc_1 = 0;
            while (_loc_1 < this._skills.length)
            {
                
                writeBean(this._skills[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._defaultSkill = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._skills[_loc_1] = readBean(CSSkillInfo) as CSSkillInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 107101;
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

        public function get skills() : Vector.<CSSkillInfo>
        {
            return this._skills;
        }// end function

        public function set skills(param1:Vector.<CSSkillInfo>) : void
        {
            this._skills = param1;
            return;
        }// end function

    }
}
