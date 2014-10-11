package com.game.buff.bean
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class CSBuffInfo extends Bean
    {
        private var _buffId:long;
        private var _modelId:int;
        private var _total:int;
        private var _remain:int;
        private var _overlay:int;
        private var _value:int;
        private var _percent:int;
        private var _buffparas:Vector.<BuffPara>;

        public function CSBuffInfo()
        {
            this._buffparas = new Vector.<BuffPara>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._buffId);
            writeInt(this._modelId);
            writeInt(this._total);
            writeInt(this._remain);
            writeInt(this._overlay);
            writeInt(this._value);
            writeInt(this._percent);
            writeShort(this._buffparas.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._buffparas.length)
            {
                
                writeBean(this._buffparas[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._buffId = readLong();
            this._modelId = readInt();
            this._total = readInt();
            this._remain = readInt();
            this._overlay = readInt();
            this._value = readInt();
            this._percent = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._buffparas[_loc_2] = readBean(BuffPara) as BuffPara;
                _loc_2++;
            }
            return true;
        }// end function

        public function get buffId() : long
        {
            return this._buffId;
        }// end function

        public function set buffId(param1:long) : void
        {
            this._buffId = param1;
            return;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get total() : int
        {
            return this._total;
        }// end function

        public function set total(param1:int) : void
        {
            this._total = param1;
            return;
        }// end function

        public function get remain() : int
        {
            return this._remain;
        }// end function

        public function set remain(param1:int) : void
        {
            this._remain = param1;
            return;
        }// end function

        public function get overlay() : int
        {
            return this._overlay;
        }// end function

        public function set overlay(param1:int) : void
        {
            this._overlay = param1;
            return;
        }// end function

        public function get value() : int
        {
            return this._value;
        }// end function

        public function set value(param1:int) : void
        {
            this._value = param1;
            return;
        }// end function

        public function get percent() : int
        {
            return this._percent;
        }// end function

        public function set percent(param1:int) : void
        {
            this._percent = param1;
            return;
        }// end function

        public function get buffparas() : Vector.<BuffPara>
        {
            return this._buffparas;
        }// end function

        public function set buffparas(param1:Vector.<BuffPara>) : void
        {
            this._buffparas = param1;
            return;
        }// end function

    }
}
