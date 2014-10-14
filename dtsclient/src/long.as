package
{

    final public class long extends Binary64
    {

        public function long(param1:uint = 0, param2:uint = 0)
        {
            super(param1, param2);
            return;
        }// end function

        final public function set high(param1:uint) : void
        {
            internalHigh = param1;
            return;
        }// end function

        final public function get high() : uint
        {
            return internalHigh;
        }// end function

        public function equal(param1:long) : Boolean
        {
            if (param1)
            {
                return param1.high == this.high && param1.low == low;
            }
            return false;
        }// end function

        final public function toNumber() : Number
        {
            return this.high * 4294967296 + low;
        }// end function

        final public function toString(param1:uint = 10) : String
        {
            var _loc_4:* = 0;
            if (param1 < 2 || param1 > 36)
            {
                throw new ArgumentError();
            }
            if (this.high == 0)
            {
                return low.toString(param1);
            }
            var _loc_2:* = [];
            var _loc_3:* = new long(low, this.high);
            do
            {
                
                _loc_4 = _loc_3.div(param1);
                if (_loc_4 < 10)
                {
                    _loc_2.push(_loc_4 + CHAR_CODE_0);
                    continue;
                }
                _loc_2.push(_loc_4 - 10 + CHAR_CODE_A);
            }while (_loc_3.high != 0)
            return _loc_3.low.toString(param1) + String.fromCharCode.apply(String, _loc_2.reverse());
        }// end function

        public static function fromNumber(param1:Number) : long
        {
            return new long(param1, Math.floor(param1 / 4294967296));
        }// end function

        public static function isZero(param1:long) : Boolean
        {
            if (param1 == null)
            {
                return true;
            }
            if (param1.equal(long.fromNumber(0)))
            {
                return true;
            }
            return false;
        }// end function

        public static function parselong(param1:String, param2:uint = 0) : long
        {
            var _loc_5:* = 0;
            if (param1.substr(0, 1) == "-")
            {
                return fromNumber(Number(param1));
            }
            var _loc_3:* = 0;
            if (param2 == 0)
            {
                if (param1.search(/^0x/) == 0)
                {
                    param2 = 16;
                    _loc_3 = 2;
                }
                else
                {
                    param2 = 10;
                }
            }
            if (param2 < 2 || param2 > 36)
            {
                throw new ArgumentError();
            }
            param1 = param1.toLowerCase();
            var _loc_4:* = new long;
            while (_loc_3 < param1.length)
            {
                
                _loc_5 = param1.charCodeAt(_loc_3);
                if (_loc_5 >= CHAR_CODE_0 && _loc_5 <= CHAR_CODE_9)
                {
                    _loc_5 = _loc_5 - CHAR_CODE_0;
                }
                else if (_loc_5 >= CHAR_CODE_A && _loc_5 <= CHAR_CODE_Z)
                {
                    _loc_5 = _loc_5 - CHAR_CODE_A;
                    _loc_5 = _loc_5 + 10;
                }
                else
                {
                    throw new ArgumentError();
                }
                if (_loc_5 >= param2)
                {
                    throw new ArgumentError();
                }
                _loc_4.mul(param2);
                _loc_4.add(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return _loc_4;
        }// end function

    }
}
