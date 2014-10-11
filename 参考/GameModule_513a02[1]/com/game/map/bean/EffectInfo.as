package com.game.map.bean
{
    import com.game.utils.*;
    import net.*;

    public class EffectInfo extends Bean
    {
        private var _effectId:long;
        private var _effectModelId:int;
        private var _type:int;
        private var _x:int;
        private var _y:int;
        private var _play:int;
        private var _target:long;

        public function EffectInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._effectId);
            writeInt(this._effectModelId);
            writeByte(this._type);
            writeShort(this._x);
            writeShort(this._y);
            writeInt(this._play);
            writeLong(this._target);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._effectId = readLong();
            this._effectModelId = readInt();
            this._type = readByte();
            this._x = readShort();
            this._y = readShort();
            this._play = readInt();
            this._target = readLong();
            return true;
        }// end function

        public function get effectId() : long
        {
            return this._effectId;
        }// end function

        public function set effectId(param1:long) : void
        {
            this._effectId = param1;
            return;
        }// end function

        public function get effectModelId() : int
        {
            return this._effectModelId;
        }// end function

        public function set effectModelId(param1:int) : void
        {
            this._effectModelId = param1;
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

        public function get play() : int
        {
            return this._play;
        }// end function

        public function set play(param1:int) : void
        {
            this._play = param1;
            return;
        }// end function

        public function get target() : long
        {
            return this._target;
        }// end function

        public function set target(param1:long) : void
        {
            this._target = param1;
            return;
        }// end function

    }
}
