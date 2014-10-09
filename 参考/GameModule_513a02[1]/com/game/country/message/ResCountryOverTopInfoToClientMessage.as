package com.game.country.message
{
    import __AS3__.vec.*;
    import com.game.country.bean.*;
    import net.*;

    public class ResCountryOverTopInfoToClientMessage extends Message
    {
        private var _countryOverTopInfolist:Vector.<CountryTopInfo>;

        public function ResCountryOverTopInfoToClientMessage()
        {
            this._countryOverTopInfolist = new Vector.<CountryTopInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._countryOverTopInfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._countryOverTopInfolist.length)
            {
                
                writeBean(this._countryOverTopInfolist[_loc_1]);
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
                
                this._countryOverTopInfolist[_loc_1] = readBean(CountryTopInfo) as CountryTopInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 546114;
        }// end function

        public function get countryOverTopInfolist() : Vector.<CountryTopInfo>
        {
            return this._countryOverTopInfolist;
        }// end function

        public function set countryOverTopInfolist(param1:Vector.<CountryTopInfo>) : void
        {
            this._countryOverTopInfolist = param1;
            return;
        }// end function

    }
}
