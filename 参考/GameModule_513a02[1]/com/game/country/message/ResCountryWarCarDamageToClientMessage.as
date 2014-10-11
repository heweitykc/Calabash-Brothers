package com.game.country.message
{
    import __AS3__.vec.*;
    import com.game.country.bean.*;
    import net.*;

    public class ResCountryWarCarDamageToClientMessage extends Message
    {
        private var _x:int;
        private var _y:int;
        private var _damageinfo:Vector.<PlayerDamageInfo>;

        public function ResCountryWarCarDamageToClientMessage()
        {
            this._damageinfo = new Vector.<PlayerDamageInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._x);
            writeShort(this._y);
            writeShort(this._damageinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._damageinfo.length)
            {
                
                writeBean(this._damageinfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._x = readShort();
            this._y = readShort();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._damageinfo[_loc_1] = readBean(PlayerDamageInfo) as PlayerDamageInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 146112;
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

        public function get damageinfo() : Vector.<PlayerDamageInfo>
        {
            return this._damageinfo;
        }// end function

        public function set damageinfo(param1:Vector.<PlayerDamageInfo>) : void
        {
            this._damageinfo = param1;
            return;
        }// end function

    }
}
