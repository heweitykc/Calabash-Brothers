package com.game.guild.message
{
    import com.game.utils.*;
    import net.*;

    public class ResGuildDeleteDiplomaticToClientMessage extends Message
    {
        private var _btErrorCode:int;
        private var _diplomaticType:int;
        private var _applyGuildId:long;

        public function ResGuildDeleteDiplomaticToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._btErrorCode);
            writeByte(this._diplomaticType);
            writeLong(this._applyGuildId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._btErrorCode = readByte();
            this._diplomaticType = readByte();
            this._applyGuildId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121119;
        }// end function

        public function get btErrorCode() : int
        {
            return this._btErrorCode;
        }// end function

        public function set btErrorCode(param1:int) : void
        {
            this._btErrorCode = param1;
            return;
        }// end function

        public function get diplomaticType() : int
        {
            return this._diplomaticType;
        }// end function

        public function set diplomaticType(param1:int) : void
        {
            this._diplomaticType = param1;
            return;
        }// end function

        public function get applyGuildId() : long
        {
            return this._applyGuildId;
        }// end function

        public function set applyGuildId(param1:long) : void
        {
            this._applyGuildId = param1;
            return;
        }// end function

    }
}
