package com.adobe.serialization.json
{

    public class JSON extends Object
    {

        public function JSON()
        {
            return;
        }// end function

        public static function encode(param1:Object, param2:Boolean = false) : String
        {
            var _loc_3:* = new JSONEncoder(param1, param2);
            return _loc_3.getString();
        }// end function

        public static function decode(param1:String)
        {
            var _loc_2:* = new JSONDecoder(param1);
            return _loc_2.getValue();
        }// end function

    }
}
