package com.game.epalace.message
{
    import com.game.player.bean.*;
    import net.*;

    public class ResEpalaceOpenToGameMessage extends Message
    {
        private var _time:int;
        private var _task:int;
        private var _pos:int;
        private var _movenum:int;
        private var _appearanceInfo:PlayerAppearanceInfo;

        public function ResEpalaceOpenToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._time);
            writeInt(this._task);
            writeByte(this._pos);
            writeByte(this._movenum);
            writeBean(this._appearanceInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._time = readInt();
            this._task = readInt();
            this._pos = readByte();
            this._movenum = readByte();
            this._appearanceInfo = readBean(PlayerAppearanceInfo) as PlayerAppearanceInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 143103;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

        public function get task() : int
        {
            return this._task;
        }// end function

        public function set task(param1:int) : void
        {
            this._task = param1;
            return;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        public function get movenum() : int
        {
            return this._movenum;
        }// end function

        public function set movenum(param1:int) : void
        {
            this._movenum = param1;
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
