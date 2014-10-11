package com.f1.net
{
    import flash.utils.*;

    public class ByteArrayUtil extends Object
    {

        public function ByteArrayUtil()
        {
            return;
        }// end function

        public static function add0(param1:String) : String
        {
            if (param1.length == 1)
            {
                return "0" + param1;
            }
            return param1;
        }// end function

        public static function show16Int(param1:ByteArray) : String
        {
            var _loc_3:* = 0;
            var _loc_2:* = param1.position;
            param1.position = 0;
            var _loc_4:* = param1.length;
            var _loc_5:* = "";
            while (_loc_3++ < _loc_4)
            {
                
                _loc_5 = _loc_5 + (add0(param1.readUnsignedByte().toString(16)) + " ");
            }
            param1.position = _loc_2;
            return _loc_5;
        }// end function

        public static function directWriteInt(param1:ByteArray, param2:uint, param3:int) : void
        {
            var _loc_4:* = param1.position;
            param1.position = param2;
            param1.writeInt(param3);
            param1.position = _loc_4;
            return;
        }// end function

        public static function directWriteUint(param1:ByteArray, param2:uint, param3:uint) : void
        {
            var _loc_4:* = param1.position;
            param1.position = param2;
            param1.writeUnsignedInt(param3);
            param1.position = _loc_4;
            return;
        }// end function

        public static function directWriteSmallint(param1:ByteArray, param2:uint, param3:int) : void
        {
            var _loc_4:* = param1.position;
            param1.position = param2;
            param1.writeShort(param3);
            param1.position = _loc_4;
            return;
        }// end function

        public static function directWriteSmalluint(param1:ByteArray, param2:uint, param3:int) : void
        {
            var _loc_4:* = param1.position;
            param1.position = param2;
            param1.writeShort(param3);
            param1.position = _loc_4;
            return;
        }// end function

        public static function directWriteTinyint(param1:ByteArray, param2:uint, param3:uint) : void
        {
            var _loc_4:* = param1.position;
            param1.position = param2;
            param1.writeByte(param3);
            param1.position = _loc_4;
            return;
        }// end function

        public static function directWriteTinyuint(param1:ByteArray, param2:uint, param3:uint) : void
        {
            var _loc_4:* = param1.position;
            param1.position = param2;
            param1.writeByte(param3);
            param1.position = _loc_4;
            return;
        }// end function

        public static function directReadInt(param1:ByteArray, param2:uint) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = param1.position;
            param1.position = param2;
            _loc_3 = param1.readInt();
            param1.position = _loc_4;
            return _loc_3;
        }// end function

        public static function directReadUint(param1:ByteArray, param2:uint) : uint
        {
            var _loc_3:* = 0;
            var _loc_4:* = param1.position;
            param1.position = param2;
            _loc_3 = param1.readUnsignedInt();
            param1.position = _loc_4;
            return _loc_3;
        }// end function

        public static function directReadSmallint(param1:ByteArray, param2:uint) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = param1.position;
            param1.position = param2;
            _loc_3 = param1.readShort();
            param1.position = _loc_4;
            return _loc_3;
        }// end function

        public static function directReadSmalluint(param1:ByteArray, param2:uint) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = param1.position;
            param1.position = param2;
            _loc_3 = param1.readUnsignedShort();
            param1.position = _loc_4;
            return _loc_3;
        }// end function

        public static function directReadTinyint(param1:ByteArray, param2:uint) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = param1.position;
            param1.position = param2;
            _loc_3 = param1.readByte();
            param1.position = _loc_4;
            return _loc_3;
        }// end function

        public static function directReadTinyuint(param1:ByteArray, param2:uint) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = param1.position;
            param1.position = param2;
            _loc_3 = param1.readUnsignedByte();
            param1.position = _loc_4;
            return _loc_3;
        }// end function

    }
}
