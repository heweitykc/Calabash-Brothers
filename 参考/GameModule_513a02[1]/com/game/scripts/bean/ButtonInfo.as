package com.game.scripts.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class ButtonInfo extends Bean
    {
        private var _name:String;
        private var _scriptId:int;
        private var _method:String;
        private var _isclose:int;
        private var _paras:Vector.<String>;

        public function ButtonInfo()
        {
            this._paras = new Vector.<String>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._name);
            writeInt(this._scriptId);
            writeString(this._method);
            writeByte(this._isclose);
            writeShort(this._paras.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._paras.length)
            {
                
                writeString(this._paras[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._name = readString();
            this._scriptId = readInt();
            this._method = readString();
            this._isclose = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._paras[_loc_2] = readString();
                _loc_2++;
            }
            return true;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get scriptId() : int
        {
            return this._scriptId;
        }// end function

        public function set scriptId(param1:int) : void
        {
            this._scriptId = param1;
            return;
        }// end function

        public function get method() : String
        {
            return this._method;
        }// end function

        public function set method(param1:String) : void
        {
            this._method = param1;
            return;
        }// end function

        public function get isclose() : int
        {
            return this._isclose;
        }// end function

        public function set isclose(param1:int) : void
        {
            this._isclose = param1;
            return;
        }// end function

        public function get paras() : Vector.<String>
        {
            return this._paras;
        }// end function

        public function set paras(param1:Vector.<String>) : void
        {
            this._paras = param1;
            return;
        }// end function

    }
}
