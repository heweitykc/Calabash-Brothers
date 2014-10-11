package com.game.country.message
{
    import __AS3__.vec.*;
    import com.game.country.bean.*;
    import net.*;

    public class ResAwardInfoToClientMessage extends Message
    {
        private var _damageinfo:Vector.<AwardInfo>;

        public function ResAwardInfoToClientMessage()
        {
            this._damageinfo = new Vector.<AwardInfo>;
            return;
        }// end function

        public function set damageinfo(param1:Vector.<AwardInfo>) : void
        {
            this._damageinfo = param1;
            return;
        }// end function

        public function get damageinfo() : Vector.<AwardInfo>
        {
            return this._damageinfo;
        }// end function

        override public function getId() : int
        {
            return 146113;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._damageinfo.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._damageinfo.length)
            {
                
                writeBean(this._damageinfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._damageinfo[_loc_2] = readBean(AwardInfo) as AwardInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
