package com.game.skill.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqSyncPlayerSkillMessage extends Message
    {
        private var _playerId:long;
        private var _skillId:int;
        private var _upLevel:int;
        private var _skillTime:long;

        public function ReqSyncPlayerSkillMessage()
        {
            return;
        }// end function

        public function get skillTime() : long
        {
            return this._skillTime;
        }// end function

        public function set skillTime(param1:long) : void
        {
            this._skillTime = param1;
            return;
        }// end function

        public function get upLevel() : int
        {
            return this._upLevel;
        }// end function

        public function set upLevel(param1:int) : void
        {
            this._upLevel = param1;
            return;
        }// end function

        public function get skillId() : int
        {
            return this._skillId;
        }// end function

        public function set skillId(param1:int) : void
        {
            this._skillId = param1;
            return;
        }// end function

        public function get playerId() : long
        {
            return this._playerId;
        }// end function

        public function set playerId(param1:long) : void
        {
            this._playerId = param1;
            return;
        }// end function

        override public function getId() : int
        {
            return 103321;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._playerId);
            writeInt(this._skillId);
            writeInt(this._upLevel);
            writeLong(this.skillTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._playerId = readLong();
            this._skillId = readInt();
            this._upLevel = readInt();
            this.skillTime = readLong();
            return true;
        }// end function

    }
}
