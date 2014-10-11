package com.game.bosshome.message
{
    import net.*;

    public class ResBossHomePlayerNumMessage extends Message
    {
        private var _beforenum:int;
        private var _num:int;
        private var _afternum:int;
        private var _reson:int;

        public function ResBossHomePlayerNumMessage()
        {
            return;
        }// end function

        public function set beforenum(param1:int) : void
        {
            this._beforenum = param1;
            return;
        }// end function

        public function get beforenum() : int
        {
            return this._beforenum;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set afternum(param1:int) : void
        {
            this._afternum = param1;
            return;
        }// end function

        public function get afternum() : int
        {
            return this._afternum;
        }// end function

        public function set reson(param1:int) : void
        {
            this._reson = param1;
            return;
        }// end function

        public function get reson() : int
        {
            return this._reson;
        }// end function

        override public function getId() : int
        {
            return 543003;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._beforenum);
            writeInt(this._num);
            writeInt(this._afternum);
            writeInt(this._reson);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._beforenum = readInt();
            this._num = readInt();
            this._afternum = readInt();
            this._reson = readInt();
            return true;
        }// end function

    }
}
