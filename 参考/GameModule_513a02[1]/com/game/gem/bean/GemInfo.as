package com.game.gem.bean
{
    import com.game.utils.*;
    import net.*;

    public class GemInfo extends Bean
    {
        private var _id:long;
        private var _level:int;
        private var _type:int;
        private var _exp:int;
        private var _grid:int;
        private var _isact:int;

        public function GemInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._id);
            writeByte(this._level);
            writeByte(this._type);
            writeInt(this._exp);
            writeByte(this._grid);
            writeByte(this._isact);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._id = readLong();
            this._level = readByte();
            this._type = readByte();
            this._exp = readInt();
            this._grid = readByte();
            this._isact = readByte();
            return true;
        }// end function

        public function get id() : long
        {
            return this._id;
        }// end function

        public function set id(param1:long) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
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

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get grid() : int
        {
            return this._grid;
        }// end function

        public function set grid(param1:int) : void
        {
            this._grid = param1;
            return;
        }// end function

        public function get isact() : int
        {
            return this._isact;
        }// end function

        public function set isact(param1:int) : void
        {
            this._isact = param1;
            return;
        }// end function

    }
}
