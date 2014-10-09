﻿package com.game.buff.bean
{
    import net.*;

    public class BuffPara extends Bean
    {
        private var _type:int;
        private var _value:int;

        public function BuffPara()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeInt(this._value);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._value = readInt();
            return true;
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

        public function get value() : int
        {
            return this._value;
        }// end function

        public function set value(param1:int) : void
        {
            this._value = param1;
            return;
        }// end function

    }
}
