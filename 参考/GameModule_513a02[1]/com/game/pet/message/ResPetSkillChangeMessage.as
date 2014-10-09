package com.game.pet.message
{
    import __AS3__.vec.*;
    import com.game.skill.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResPetSkillChangeMessage extends Message
    {
        private var _petId:long;
        private var _skillInfos:Vector.<CSSkillInfo>;

        public function ResPetSkillChangeMessage()
        {
            this._skillInfos = new Vector.<CSSkillInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._petId);
            writeShort(this._skillInfos.length);
            _loc_1 = 0;
            while (_loc_1 < this._skillInfos.length)
            {
                
                writeBean(this._skillInfos[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._petId = readLong();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._skillInfos[_loc_1] = readBean(CSSkillInfo) as CSSkillInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 110110;
        }// end function

        public function get petId() : long
        {
            return this._petId;
        }// end function

        public function set petId(param1:long) : void
        {
            this._petId = param1;
            return;
        }// end function

        public function get skillInfos() : Vector.<CSSkillInfo>
        {
            return this._skillInfos;
        }// end function

        public function set skillInfos(param1:Vector.<CSSkillInfo>) : void
        {
            this._skillInfos = param1;
            return;
        }// end function

    }
}
