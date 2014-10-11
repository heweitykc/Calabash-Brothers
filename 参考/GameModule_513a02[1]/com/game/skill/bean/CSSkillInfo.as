package com.game.skill.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class CSSkillInfo extends Bean
    {
        private var _skillId:long;
        private var _skillModelId:int;
        private var _skillLevel:int;
        public var skillCDTime:int;
        private var _skillAddLevels:Vector.<SkillLevelInfo>;

        public function CSSkillInfo()
        {
            this._skillAddLevels = new Vector.<SkillLevelInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._skillId);
            writeInt(this._skillModelId);
            writeInt(this._skillLevel);
            writeShort(this._skillAddLevels.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._skillAddLevels.length)
            {
                
                writeBean(this._skillAddLevels[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skillId = readLong();
            this._skillModelId = readInt();
            this._skillLevel = readInt();
            this.skillCDTime = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._skillAddLevels[_loc_2] = readBean(SkillLevelInfo) as SkillLevelInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get skillId() : long
        {
            return this._skillId;
        }// end function

        public function set skillId(param1:long) : void
        {
            this._skillId = param1;
            return;
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

        public function get skillLevel() : int
        {
            return this._skillLevel;
        }// end function

        public function set skillLevel(param1:int) : void
        {
            this._skillLevel = param1;
            return;
        }// end function

        public function get skillAddLevels() : Vector.<SkillLevelInfo>
        {
            return this._skillAddLevels;
        }// end function

        public function set skillAddLevels(param1:Vector.<SkillLevelInfo>) : void
        {
            this._skillAddLevels = param1;
            return;
        }// end function

    }
}
