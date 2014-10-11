package com.game.player.message
{
    import com.game.player.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResGetPlayerAppearanceInfMessage extends Message
    {
        private var _othersid:long;
        private var _type:int;
        private var _appearanceInfo:PlayerAppearanceInfo;

        public function ResGetPlayerAppearanceInfMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._othersid);
            writeByte(this._type);
            writeBean(this._appearanceInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._othersid = readLong();
            this._type = readByte();
            this._appearanceInfo = readBean(PlayerAppearanceInfo) as PlayerAppearanceInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 103126;
        }// end function

        public function get othersid() : long
        {
            return this._othersid;
        }// end function

        public function set othersid(param1:long) : void
        {
            this._othersid = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get appearanceInfo() : PlayerAppearanceInfo
        {
            return this._appearanceInfo;
        }// end function

        public function set appearanceInfo(param1:PlayerAppearanceInfo) : void
        {
            this._appearanceInfo = param1;
            return;
        }// end function

    }
}
