package com.game.country.message
{
    import com.game.country.bean.*;
    import net.*;

    public class ResCountrySiegeYuXiImmediateToClientMessage extends Message
    {
        private var _countrywarinfo:CountryWarInfo;

        public function ResCountrySiegeYuXiImmediateToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._countrywarinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._countrywarinfo = readBean(CountryWarInfo) as CountryWarInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 146104;
        }// end function

        public function get countrywarinfo() : CountryWarInfo
        {
            return this._countrywarinfo;
        }// end function

        public function set countrywarinfo(param1:CountryWarInfo) : void
        {
            this._countrywarinfo = param1;
            return;
        }// end function

    }
}
