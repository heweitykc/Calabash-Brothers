package com.game.equipstreng.message
{
    import com.game.utils.*;
    import net.*;

    public class ResStrengthEffectMessage extends Message
    {
        private var _persionId:long;
        private var _equipModelId:int;
        private var _strengthLevel:int;
        private var _wearPosition:int;

        public function ResStrengthEffectMessage()
        {
            return;
        }// end function

        public function set persionId(param1:long) : void
        {
            this._persionId = param1;
            return;
        }// end function

        public function get persionId() : long
        {
            return this._persionId;
        }// end function

        public function set equipModelId(param1:int) : void
        {
            this._equipModelId = param1;
            return;
        }// end function

        public function get equipModelId() : int
        {
            return this._equipModelId;
        }// end function

        public function set strengthLevel(param1:int) : void
        {
            this._strengthLevel = param1;
            return;
        }// end function

        public function get strengthLevel() : int
        {
            return this._strengthLevel;
        }// end function

        public function set wearPosition(param1:int) : void
        {
            this._wearPosition = param1;
            return;
        }// end function

        public function get wearPosition() : int
        {
            return this._wearPosition;
        }// end function

        override public function getId() : int
        {
            return 130205;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._persionId);
            writeInt(this._equipModelId);
            writeByte(this._strengthLevel);
            writeByte(this._wearPosition);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._persionId = readLong();
            this._equipModelId = readInt();
            this._strengthLevel = readByte();
            this._wearPosition = readByte();
            return true;
        }// end function

    }
}
