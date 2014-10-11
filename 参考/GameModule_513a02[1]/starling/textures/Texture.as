package starling.textures
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.utils.*;

    public class Texture extends Object
    {
        private var mFrame:Rectangle;
        private var mRepeat:Boolean;

        public function Texture()
        {
            if (Capabilities.isDebugger && getQualifiedClassName(this) == "starling.textures::Texture")
            {
                throw new AbstractClassError();
            }
            this.mRepeat = false;
            return;
        }// end function

        public function dispose() : void
        {
            return;
        }// end function

        public function adjustVertexData(param1:VertexData, param2:int, param3:int) : void
        {
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            if (this.mFrame)
            {
                if (param3 != 4)
                {
                    throw new ArgumentError("Textures with a frame can only be used on quads");
                }
                _loc_4 = this.mFrame.width + this.mFrame.x - this.width;
                _loc_5 = this.mFrame.height + this.mFrame.y - this.height;
                param1.translateVertex(param2, -this.mFrame.x, -this.mFrame.y);
                param1.translateVertex((param2 + 1), -_loc_4, -this.mFrame.y);
                param1.translateVertex(param2 + 2, -this.mFrame.x, -_loc_5);
                param1.translateVertex(param2 + 3, -_loc_4, -_loc_5);
            }
            return;
        }// end function

        public function adjustTexCoords(param1:Vector.<Number>, param2:int = 0, param3:int = 0, param4:int = -1) : void
        {
            return;
        }// end function

        public function get frame() : Rectangle
        {
            return this.mFrame ? (this.mFrame.clone()) : (new Rectangle(0, 0, this.width, this.height));
        }// end function

        public function get repeat() : Boolean
        {
            return this.mRepeat;
        }// end function

        public function set repeat(param1:Boolean) : void
        {
            this.mRepeat = param1;
            return;
        }// end function

        public function get width() : Number
        {
            return 0;
        }// end function

        public function get height() : Number
        {
            return 0;
        }// end function

        public function get nativeWidth() : Number
        {
            return 0;
        }// end function

        public function get nativeHeight() : Number
        {
            return 0;
        }// end function

        public function get scale() : Number
        {
            return 1;
        }// end function

        public function get base() : TextureBase
        {
            return null;
        }// end function

        public function get root() : ConcreteTexture
        {
            return null;
        }// end function

        public function get format() : String
        {
            return Context3DTextureFormat.BGRA;
        }// end function

        public function get mipMapping() : Boolean
        {
            return false;
        }// end function

        public function get premultipliedAlpha() : Boolean
        {
            return false;
        }// end function

        public static function fromEmbeddedAsset(param1:Class, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra") : Texture
        {
            var texture:Texture;
            var assetClass:* = param1;
            var mipMapping:* = param2;
            var optimizeForRenderToTexture:* = param3;
            var scale:* = param4;
            var format:* = param5;
            var asset:* = new assetClass;
            if (asset is Bitmap)
            {
                texture = Texture.fromBitmap(asset as Bitmap, mipMapping, false, scale, format);
                texture.root.onRestore = function () : void
            {
                texture.root.uploadBitmap(new assetClass());
                return;
            }// end function
            ;
            }
            else if (asset is ByteArray)
            {
                texture = Texture.fromAtfData(asset as ByteArray, scale, mipMapping);
                texture.root.onRestore = function () : void
            {
                texture.root.uploadAtfData(new assetClass());
                return;
            }// end function
            ;
            }
            else
            {
                throw new ArgumentError("Invalid asset type: " + getQualifiedClassName(asset));
            }
            asset;
            return texture;
        }// end function

        public static function fromBitmap(param1:Bitmap, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra") : Texture
        {
            return fromBitmapData(param1.bitmapData, param2, param3, param4, param5);
        }// end function

        public static function fromBitmapData(param1:BitmapData, param2:Boolean = true, param3:Boolean = false, param4:Number = 1, param5:String = "bgra") : Texture
        {
            var texture:Texture;
            var data:* = param1;
            var generateMipMaps:* = param2;
            var optimizeForRenderToTexture:* = param3;
            var scale:* = param4;
            var format:* = param5;
            texture = Texture.empty(data.width / scale, data.height / scale, true, generateMipMaps, optimizeForRenderToTexture, scale, format);
            texture.root.uploadBitmapData(data);
            texture.root.onRestore = function () : void
            {
                texture.root.uploadBitmapData(data);
                return;
            }// end function
            ;
            return texture;
        }// end function

        public static function fromAtfData(param1:ByteArray, param2:Number = 1, param3:Boolean = true, param4:Function = null) : Texture
        {
            var concreteTexture:ConcreteTexture;
            var data:* = param1;
            var scale:* = param2;
            var useMipMaps:* = param3;
            var async:* = param4;
            var context:* = Starling.context;
            if (context == null)
            {
                throw new MissingContextError();
            }
            var atfData:* = new AtfData(data);
            var nativeTexture:* = context.createTexture(atfData.width, atfData.height, atfData.format, false);
            concreteTexture = new ConcreteTexture(nativeTexture, atfData.format, atfData.width, atfData.height, useMipMaps && atfData.numTextures > 1, false, false, scale);
            concreteTexture.uploadAtfData(data, 0, async);
            concreteTexture.onRestore = function () : void
            {
                concreteTexture.uploadAtfData(data, 0);
                return;
            }// end function
            ;
            return concreteTexture;
        }// end function

        public static function fromColor(param1:Number, param2:Number, param3:uint = 4.29497e+009, param4:Boolean = false, param5:Number = -1, param6:String = "bgra") : Texture
        {
            var texture:Texture;
            var width:* = param1;
            var height:* = param2;
            var color:* = param3;
            var optimizeForRenderToTexture:* = param4;
            var scale:* = param5;
            var format:* = param6;
            texture = Texture.empty(width, height, true, false, optimizeForRenderToTexture, scale, format);
            texture.root.clear(color, Color.getAlpha(color) / 255);
            texture.root.onRestore = function () : void
            {
                texture.root.clear(color, Color.getAlpha(color) / 255);
                return;
            }// end function
            ;
            return texture;
        }// end function

        public static function empty(param1:Number, param2:Number, param3:Boolean = true, param4:Boolean = true, param5:Boolean = false, param6:Number = -1, param7:String = "bgra") : Texture
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            if (param6 <= 0)
            {
                param6 = Starling.contentScaleFactor;
            }
            var _loc_11:* = Starling.context;
            if (Starling.context == null)
            {
                throw new MissingContextError();
            }
            var _loc_12:* = param1 * param6;
            var _loc_13:* = param2 * param6;
            var _loc_14:* = getNextPowerOfTwo(_loc_12);
            var _loc_15:* = getNextPowerOfTwo(_loc_13);
            var _loc_16:* = _loc_12 == _loc_14 && _loc_13 == _loc_15;
            var _loc_17:* = !(_loc_12 == _loc_14 && _loc_13 == _loc_15) && !param4 && Starling.current.profile != "baselineConstrained" && "createRectangleTexture" in _loc_11 && param7.indexOf("compressed") == -1;
            if (!(_loc_12 == _loc_14 && _loc_13 == _loc_15) && !param4 && Starling.current.profile != "baselineConstrained" && "createRectangleTexture" in _loc_11 && param7.indexOf("compressed") == -1)
            {
                _loc_8 = _loc_12;
                _loc_9 = _loc_13;
                var _loc_19:* = _loc_11;
                _loc_10 = _loc_19["createRectangleTexture"](_loc_8, _loc_9, param7, param5);
            }
            else
            {
                _loc_8 = _loc_14;
                _loc_9 = _loc_15;
                _loc_10 = _loc_11.createTexture(_loc_8, _loc_9, param7, param5);
            }
            var _loc_18:* = new ConcreteTexture(_loc_10, param7, _loc_8, _loc_9, param4, param3, param5, param6);
            _loc_18.onRestore = _loc_18.clear;
            if (_loc_16 || _loc_17)
            {
                return _loc_18;
            }
            return new SubTexture(_loc_18, new Rectangle(0, 0, param1, param2), true);
        }// end function

        public static function fromTexture(param1:Texture, param2:Rectangle = null, param3:Rectangle = null) : Texture
        {
            var _loc_4:* = new SubTexture(param1, param2);
            _loc_4.mFrame = param3;
            return _loc_4;
        }// end function

    }
}
