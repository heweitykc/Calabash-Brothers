package com.game.backpack.message
{
    import net.*;

    public class ResOpenCellInfoMessage extends Message
    {
        private var _cellId:int;
        private var _timeRemaining:int;
        private var _gold:int;
        private var _exp:int;
        private var _maxhp:int;

        public function ResOpenCellInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._cellId);
            writeInt(this._timeRemaining);
            writeInt(this._gold);
            writeInt(this._exp);
            writeInt(this._maxhp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._cellId = readInt();
            this._timeRemaining = readInt();
            this._gold = readInt();
            this._exp = readInt();
            this._maxhp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 104108;
        }// end function

        public function get cellId() : int
        {
            return this._cellId;
        }// end function

        public function set cellId(param1:int) : void
        {
            this._cellId = param1;
            return;
        }// end function

        public function get timeRemaining() : int
        {
            return this._timeRemaining;
        }// end function

        public function set timeRemaining(param1:int) : void
        {
            this._timeRemaining = param1;
            return;
        }// end function

        public function get gold() : int
        {
            return this._gold;
        }// end function

        public function set gold(param1:int) : void
        {
            this._gold = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get maxhp() : int
        {
            return this._maxhp;
        }// end function

        public function set maxhp(param1:int) : void
        {
            this._maxhp = param1;
            return;
        }// end function

    }
}
