package starling.textures
{
    import flash.display3D.*;
    import flash.utils.*;

    public class AtfData extends Object
    {
        private var mFormat:String;
        private var mWidth:int;
        private var mHeight:int;
        private var mNumTextures:int;
        private var mData:ByteArray;

        public function AtfData(param1:ByteArray)
        {
            if (!isAtfData(param1))
            {
                throw new ArgumentError("Invalid ATF data");
            }
            if (param1[6] == 255)
            {
                param1.position = 12;
            }
            else
            {
                param1.position = 6;
            }
            switch(param1.readUnsignedByte())
            {
                case 0:
                case 1:
                {
                    this.mFormat = Context3DTextureFormat.BGRA;
                    break;
                }
                case 2:
                case 3:
                {
                    this.mFormat = Context3DTextureFormat.COMPRESSED;
                    break;
                }
                case 4:
                case 5:
                {
                    this.mFormat = "compressedAlpha";
                    break;
                }
                default:
                {
                    throw new Error("Invalid ATF format");
                    break;
                }
            }
            this.mWidth = Math.pow(2, param1.readUnsignedByte());
            this.mHeight = Math.pow(2, param1.readUnsignedByte());
            this.mNumTextures = param1.readUnsignedByte();
            this.mData = param1;
            return;
        }// end function

        public function get format() : String
        {
            return this.mFormat;
        }// end function

        public function get width() : int
        {
            return this.mWidth;
        }// end function

        public function get height() : int
        {
            return this.mHeight;
        }// end function

        public function get numTextures() : int
        {
            return this.mNumTextures;
        }// end function

        public function get data() : ByteArray
        {
            return this.mData;
        }// end function

        public static function isAtfData(param1:ByteArray) : Boolean
        {
            var _loc_2:* = null;
            if (param1.length < 3)
            {
                return false;
            }
            _loc_2 = String.fromCharCode(param1[0], param1[1], param1[2]);
            return _loc_2 == "ATF";
        }// end function

    }
}
