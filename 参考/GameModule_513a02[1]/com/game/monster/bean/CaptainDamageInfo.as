package com.game.monster.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class CaptainDamageInfo extends Bean
    {
        private var _captainId:long;
        private var _captainName:String;
        private var _damage:int;
        private var _teamInfo:Vector.<TeamMemberDamage>;

        public function CaptainDamageInfo()
        {
            this._teamInfo = new Vector.<TeamMemberDamage>;
            return;
        }// end function

        public function set captainId(param1:long) : void
        {
            this._captainId = param1;
            return;
        }// end function

        public function get captainId() : long
        {
            return this._captainId;
        }// end function

        public function set captainName(param1:String) : void
        {
            this._captainName = param1;
            return;
        }// end function

        public function get captainName() : String
        {
            return this._captainName;
        }// end function

        public function set damage(param1:int) : void
        {
            this._damage = param1;
            return;
        }// end function

        public function get damage() : int
        {
            return this._damage;
        }// end function

        public function set teamInfo(param1:Vector.<TeamMemberDamage>) : void
        {
            this._teamInfo = param1;
            return;
        }// end function

        public function get teamInfo() : Vector.<TeamMemberDamage>
        {
            return this._teamInfo;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._captainId);
            writeString(this._captainName);
            writeInt(this._damage);
            writeShort(this._teamInfo.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._teamInfo.length)
            {
                
                writeBean(this._teamInfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._captainId = readLong();
            this._captainName = readString();
            this._damage = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._teamInfo[_loc_2] = readBean(TeamMemberDamage) as TeamMemberDamage;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
