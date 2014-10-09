package com.game.plugset.bean
{
    import net.*;

    public class PlugSetInfo extends Bean
    {
        private var _parameter:int;
        private var _hpper:int;
        private var _mpper:int;
        private var _spper:int;
        private var _itemcolor:int;
        private var _itemlv:int;
        private var _skillid:int;
        private var _range:int;
        private var _pickup:int;
        private var _time:int;

        public function PlugSetInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._parameter);
            writeByte(this._hpper);
            writeByte(this._mpper);
            writeByte(this._spper);
            writeByte(this._itemcolor);
            writeByte(this._itemlv);
            writeInt(this._skillid);
            writeByte(this._range);
            writeByte(this._pickup);
            writeInt(this._time);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._parameter = readInt();
            this._hpper = readByte();
            this._mpper = readByte();
            this._spper = readByte();
            this._itemcolor = readByte();
            this._itemlv = readByte();
            this._skillid = readInt();
            this._range = readByte();
            this._pickup = readByte();
            this._time = readInt();
            return true;
        }// end function

        public function get parameter() : int
        {
            return this._parameter;
        }// end function

        public function set parameter(param1:int) : void
        {
            this._parameter = param1;
            return;
        }// end function

        public function get hpper() : int
        {
            return this._hpper;
        }// end function

        public function set hpper(param1:int) : void
        {
            this._hpper = param1;
            return;
        }// end function

        public function get mpper() : int
        {
            return this._mpper;
        }// end function

        public function set mpper(param1:int) : void
        {
            this._mpper = param1;
            return;
        }// end function

        public function get spper() : int
        {
            return this._spper;
        }// end function

        public function set spper(param1:int) : void
        {
            this._spper = param1;
            return;
        }// end function

        public function get itemcolor() : int
        {
            return this._itemcolor;
        }// end function

        public function set itemcolor(param1:int) : void
        {
            this._itemcolor = param1;
            return;
        }// end function

        public function get itemlv() : int
        {
            return this._itemlv;
        }// end function

        public function set itemlv(param1:int) : void
        {
            this._itemlv = param1;
            return;
        }// end function

        public function get skillid() : int
        {
            return this._skillid;
        }// end function

        public function set skillid(param1:int) : void
        {
            this._skillid = param1;
            return;
        }// end function

        public function get range() : int
        {
            return this._range;
        }// end function

        public function set range(param1:int) : void
        {
            this._range = param1;
            return;
        }// end function

        public function get pickup() : int
        {
            return this._pickup;
        }// end function

        public function set pickup(param1:int) : void
        {
            this._pickup = param1;
            return;
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

    }
}
