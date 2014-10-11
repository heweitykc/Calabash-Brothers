package com.game.country.message
{
    import __AS3__.vec.*;
    import com.game.country.bean.*;
    import net.*;

    public class ResCountryTopInfoToClientMessage extends Message
    {
        private var _countryTopInfolist:Vector.<CountryTopInfo>;

        public function ResCountryTopInfoToClientMessage()
        {
            this._countryTopInfolist = new Vector.<CountryTopInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._countryTopInfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._countryTopInfolist.length)
            {
                
                writeBean(this._countryTopInfolist[_loc_1]);
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
                
                this._countryTopInfolist[_loc_1] = readBean(CountryTopInfo) as CountryTopInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 146114;
        }// end function

        public function get countryTopInfolist() : Vector.<CountryTopInfo>
        {
            return this._countryTopInfolist;
        }// end function

        public function set countryTopInfolist(param1:Vector.<CountryTopInfo>) : void
        {
            this._countryTopInfolist = param1;
            return;
        }// end function

    }
}
