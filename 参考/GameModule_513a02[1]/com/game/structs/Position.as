package com.game.structs
{
    import net.*;

    public class Position extends Bean
    {
        private var _x:int;
        private var _y:int;

        public function Position()
        {
            return;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function set x(param1:int) : void
        {
            this._x = param1;
            return;
        }// end function

        override protected function reading() : Boolean
        {
            this._x = readShort();
            this._y = readShort();
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._x);
            writeShort(this._y);
            return true;
        }// end function

    }
}
