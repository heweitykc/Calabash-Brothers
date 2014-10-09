package com.game.collect.bean
{
    import net.*;

    public class FragInfo extends Bean
    {
        private var _modelid:int;
        private var _num:int;
        private var _neednum:int;

        public function FragInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._modelid);
            writeInt(this._num);
            writeInt(this._neednum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._modelid = readInt();
            this._num = readInt();
            this._neednum = readInt();
            return true;
        }// end function

        public function get modelid() : int
        {
            return this._modelid;
        }// end function

        public function set modelid(param1:int) : void
        {
            this._modelid = param1;
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

        public function get neednum() : int
        {
            return this._neednum;
        }// end function

        public function set neednum(param1:int) : void
        {
            this._neednum = param1;
            return;
        }// end function

    }
}
