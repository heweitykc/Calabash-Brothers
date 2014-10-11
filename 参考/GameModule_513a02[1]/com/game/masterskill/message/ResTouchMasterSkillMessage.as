package com.game.masterskill.message
{
    import com.game.utils.*;
    import net.*;

    public class ResTouchMasterSkillMessage extends Message
    {
        private var _sourceId:long;
        private var _targetId:long;
        private var _masterSkillID:int;
        private var _masterSkillLevel:int;

        public function ResTouchMasterSkillMessage()
        {
            return;
        }// end function

        public function set sourceId(param1:long) : void
        {
            this._sourceId = param1;
            return;
        }// end function

        public function get sourceId() : long
        {
            return this._sourceId;
        }// end function

        public function set targetId(param1:long) : void
        {
            this._targetId = param1;
            return;
        }// end function

        public function get targetId() : long
        {
            return this._targetId;
        }// end function

        public function set masterSkillID(param1:int) : void
        {
            this._masterSkillID = param1;
            return;
        }// end function

        public function get masterSkillID() : int
        {
            return this._masterSkillID;
        }// end function

        public function set masterSkillLevel(param1:int) : void
        {
            this._masterSkillLevel = param1;
            return;
        }// end function

        public function get masterSkillLevel() : int
        {
            return this._masterSkillLevel;
        }// end function

        override public function getId() : int
        {
            return 504108;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._sourceId);
            writeLong(this._targetId);
            writeInt(this._masterSkillID);
            writeInt(this._masterSkillLevel);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._sourceId = readLong();
            this._targetId = readLong();
            this._masterSkillID = readInt();
            this._masterSkillLevel = readInt();
            return true;
        }// end function

    }
}
