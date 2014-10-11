package com.game.toplist.bean
{
    import net.*;

    public class ChestInfo extends Bean
    {
        private var _chestid:int;
        private var _chesttype:int;
        private var _canreceive:int;

        public function ChestInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._chestid);
            writeInt(this._chesttype);
            writeByte(this._canreceive);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._chestid = readInt();
            this._chesttype = readInt();
            this._canreceive = readByte();
            return true;
        }// end function

        public function get chestid() : int
        {
            return this._chestid;
        }// end function

        public function set chestid(param1:int) : void
        {
            this._chestid = param1;
            return;
        }// end function

        public function get chesttype() : int
        {
            return this._chesttype;
        }// end function

        public function set chesttype(param1:int) : void
        {
            this._chesttype = param1;
            return;
        }// end function

        public function get canreceive() : int
        {
            return this._canreceive;
        }// end function

        public function set canreceive(param1:int) : void
        {
            this._canreceive = param1;
            return;
        }// end function

    }
}
