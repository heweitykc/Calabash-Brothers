package com.game.batter.message
{
    import net.*;

    public class ResMonsterBatterToClientMessage extends Message
    {
        private var _type:int;
        private var _countdowntime:int;
        private var _lev:int;
        private var _num:int;

        public function ResMonsterBatterToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._countdowntime);
            writeInt(this._lev);
            writeInt(this._num);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._countdowntime = readInt();
            this._lev = readInt();
            this._num = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 141101;
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

        public function get countdowntime() : int
        {
            return this._countdowntime;
        }// end function

        public function set countdowntime(param1:int) : void
        {
            this._countdowntime = param1;
            return;
        }// end function

        public function get lev() : int
        {
            return this._lev;
        }// end function

        public function set lev(param1:int) : void
        {
            this._lev = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

    }
}
