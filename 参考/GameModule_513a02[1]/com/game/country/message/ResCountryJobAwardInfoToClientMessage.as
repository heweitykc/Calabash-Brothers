package com.game.country.message
{
    import __AS3__.vec.*;
    import com.game.country.bean.*;
    import net.*;

    public class ResCountryJobAwardInfoToClientMessage extends Message
    {
        private var _damageinfo:Vector.<JobAwardInfo>;

        public function ResCountryJobAwardInfoToClientMessage()
        {
            this._damageinfo = new Vector.<JobAwardInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
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
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._damageinfo[_loc_1] = readBean(JobAwardInfo) as JobAwardInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 146113;
        }// end function

        public function get damageinfo() : Vector.<JobAwardInfo>
        {
            return this._damageinfo;
        }// end function

        public function set damageinfo(param1:Vector.<JobAwardInfo>) : void
        {
            this._damageinfo = param1;
            return;
        }// end function

    }
}
