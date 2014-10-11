package com.game.country.message
{
    import com.game.country.bean.*;
    import net.*;

    public class ResCountryStructureInfoToClientMessage extends Message
    {
        private var _countrystructureInfo:CountryStructureInfo;

        public function ResCountryStructureInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._countrystructureInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._countrystructureInfo = readBean(CountryStructureInfo) as CountryStructureInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 146105;
        }// end function

        public function get countrystructureInfo() : CountryStructureInfo
        {
            return this._countrystructureInfo;
        }// end function

        public function set countrystructureInfo(param1:CountryStructureInfo) : void
        {
            this._countrystructureInfo = param1;
            return;
        }// end function

    }
}
