package com.game.country.events
{
    import flash.events.*;

    public class CountryEvent extends Event
    {
        public var data:Object;
        public static const COUNTRY_INFO_CHANGE:String = "CountryStructureInfoChange";
        public static const COUNTRY_TOP_INFO_CHANGE:String = "CountryTopInfo";
        public static const COUNTRY_WAR_INFO_CHANGE:String = "CountryWarInfo";
        public static const COUNTRY_WAR_OVER:String = "CountryWarOver";
        public static const COUNTRY_CAPTURE_CHANGE:String = "CountryCaptureChange";

        public function CountryEvent(param1:String, param2, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

        override public function clone() : Event
        {
            return new CountryEvent(type, this.data, bubbles, cancelable);
        }// end function

    }
}
