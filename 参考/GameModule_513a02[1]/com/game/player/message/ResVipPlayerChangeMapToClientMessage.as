package com.game.player.message
{
    import net.*;

    public class ResVipPlayerChangeMapToClientMessage extends Message
    {
        private var _curnum:int;
        private var _maxnum:int;
        private var _viplv:int;

        public function ResVipPlayerChangeMapToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._curnum);
            writeInt(this._maxnum);
            writeInt(this._viplv);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._curnum = readInt();
            this._maxnum = readInt();
            this._viplv = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103132;
        }// end function

        public function get curnum() : int
        {
            return this._curnum;
        }// end function

        public function set curnum(param1:int) : void
        {
            this._curnum = param1;
            return;
        }// end function

        public function get maxnum() : int
        {
            return this._maxnum;
        }// end function

        public function set maxnum(param1:int) : void
        {
            this._maxnum = param1;
            return;
        }// end function

        public function get viplv() : int
        {
            return this._viplv;
        }// end function

        public function set viplv(param1:int) : void
        {
            this._viplv = param1;
            return;
        }// end function

    }
}
