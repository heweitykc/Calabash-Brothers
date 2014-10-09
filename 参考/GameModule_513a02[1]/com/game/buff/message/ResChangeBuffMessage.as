package com.game.buff.message
{
    import com.game.buff.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResChangeBuffMessage extends Message
    {
        private var _personId:long;
        private var _sourceId:long;
        private var _fightState:int;
        private var _buff:CSBuffInfo;

        public function ResChangeBuffMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeLong(this._sourceId);
            writeInt(this._fightState);
            writeBean(this._buff);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._sourceId = readLong();
            this._fightState = readInt();
            this._buff = readBean(CSBuffInfo) as CSBuffInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 113105;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get sourceId() : long
        {
            return this._sourceId;
        }// end function

        public function set sourceId(param1:long) : void
        {
            this._sourceId = param1;
            return;
        }// end function

        public function get fightState() : int
        {
            return this._fightState;
        }// end function

        public function set fightState(param1:int) : void
        {
            this._fightState = param1;
            return;
        }// end function

        public function get buff() : CSBuffInfo
        {
            return this._buff;
        }// end function

        public function set buff(param1:CSBuffInfo) : void
        {
            this._buff = param1;
            return;
        }// end function

    }
}
