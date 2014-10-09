package com.game.masterskill.message
{
    import __AS3__.vec.*;
    import com.game.masterskill.bean.*;
    import net.*;

    public class ResMasterSkillInfosMessage extends Message
    {
        private var _attackTreePoint:int;
        private var _defenseTreePoint:int;
        private var _treatTreePoint:int;
        private var _masterSkillPoint:int;
        private var _masterSkills:Vector.<MasterSkillInfo>;

        public function ResMasterSkillInfosMessage()
        {
            this._masterSkills = new Vector.<MasterSkillInfo>;
            return;
        }// end function

        public function set attackTreePoint(param1:int) : void
        {
            this._attackTreePoint = param1;
            return;
        }// end function

        public function get attackTreePoint() : int
        {
            return this._attackTreePoint;
        }// end function

        public function set defenseTreePoint(param1:int) : void
        {
            this._defenseTreePoint = param1;
            return;
        }// end function

        public function get defenseTreePoint() : int
        {
            return this._defenseTreePoint;
        }// end function

        public function set treatTreePoint(param1:int) : void
        {
            this._treatTreePoint = param1;
            return;
        }// end function

        public function get treatTreePoint() : int
        {
            return this._treatTreePoint;
        }// end function

        public function set masterSkillPoint(param1:int) : void
        {
            this._masterSkillPoint = param1;
            return;
        }// end function

        public function get masterSkillPoint() : int
        {
            return this._masterSkillPoint;
        }// end function

        public function set masterSkills(param1:Vector.<MasterSkillInfo>) : void
        {
            this._masterSkills = param1;
            return;
        }// end function

        public function get masterSkills() : Vector.<MasterSkillInfo>
        {
            return this._masterSkills;
        }// end function

        override public function getId() : int
        {
            return 504100;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._attackTreePoint);
            writeInt(this._defenseTreePoint);
            writeInt(this._treatTreePoint);
            writeInt(this._masterSkillPoint);
            writeShort(this._masterSkills.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._masterSkills.length)
            {
                
                writeBean(this._masterSkills[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._attackTreePoint = readInt();
            this._defenseTreePoint = readInt();
            this._treatTreePoint = readInt();
            this._masterSkillPoint = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._masterSkills[_loc_2] = readBean(MasterSkillInfo) as MasterSkillInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
