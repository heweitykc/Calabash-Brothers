package com.game.longyuan.bean
{
    import com.game.utils.*;
    import net.*;

    public class ShowEffectInfo extends Bean
    {
        private var _type:int;
        private var _id:long;
        private var _effectid:int;
        private var _x:int;
        private var _y:int;

        public function ShowEffectInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeLong(this._id);
            writeInt(this._effectid);
            writeShort(this._x);
            writeShort(this._y);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._id = readLong();
            this._effectid = readInt();
            this._x = readShort();
            this._y = readShort();
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

        public function get id() : long
        {
            return this._id;
        }// end function

        public function set id(param1:long) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get effectid() : int
        {
            return this._effectid;
        }// end function

        public function set effectid(param1:int) : void
        {
            this._effectid = param1;
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

        public function get y() : int
        {
            return this._y;
        }// end function

        public function set y(param1:int) : void
        {
            this._y = param1;
            return;
        }// end function

    }
}
