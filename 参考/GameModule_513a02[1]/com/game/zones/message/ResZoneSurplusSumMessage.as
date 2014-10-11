package com.game.zones.message
{
    import net.*;

    public class ResZoneSurplusSumMessage extends Message
    {
        private var _num:int;
        private var _qiyaonum:int;
        private var _qiyaozoneid:int;

        public function ResZoneSurplusSumMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._num);
            writeInt(this._qiyaonum);
            writeInt(this._qiyaozoneid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._num = readInt();
            this._qiyaonum = readInt();
            this._qiyaozoneid = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128113;
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

        public function get qiyaonum() : int
        {
            return this._qiyaonum;
        }// end function

        public function set qiyaonum(param1:int) : void
        {
            this._qiyaonum = param1;
            return;
        }// end function

        public function get qiyaozoneid() : int
        {
            return this._qiyaozoneid;
        }// end function

        public function set qiyaozoneid(param1:int) : void
        {
            this._qiyaozoneid = param1;
            return;
        }// end function

    }
}
