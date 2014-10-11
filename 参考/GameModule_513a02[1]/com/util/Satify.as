package com.util
{
    import flash.utils.*;

    public class Satify extends Object
    {
        private static const arr0:Array = [174, 191, 86, 120, 171, 205, 239, 241];

        public function Satify()
        {
            return;
        }// end function

        public static function write(param1:ByteArray) : ByteArray
        {
            var _loc_2:* = arr0.concat();
            var _loc_3:* = param1.length;
            var _loc_4:* = new ByteArray();
            var _loc_5:* = (param1[0] ^ _loc_2[0]) & 255;
            _loc_4.writeByte(_loc_5);
            var _loc_6:* = 0;
            var _loc_7:* = 1;
            while (_loc_7 < _loc_3)
            {
                
                _loc_6 = _loc_7 & 7;
                _loc_2[_loc_6] = (_loc_2[_loc_6] + _loc_5 ^ _loc_7) & 255;
                _loc_5 = ((param1[_loc_7] ^ _loc_2[_loc_6]) & 255) + _loc_5 & 255;
                _loc_4.writeByte(_loc_5);
                _loc_7++;
            }
            return _loc_4;
        }// end function

    }
}
