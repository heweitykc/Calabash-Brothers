package starling.textures
{
    import flash.display.*;
    import flash.display3D.*;
    import flash.display3D.textures.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.errors.*;
    import starling.events.*;
    import starling.utils.*;

    public class ConcreteTexture extends Texture
    {
        private var mBase:TextureBase;
        private var mFormat:String;
        private var mWidth:int;
        private var mHeight:int;
        private var mMipMapping:Boolean;
        private var mPremultipliedAlpha:Boolean;
        private var mOptimizedForRenderTexture:Boolean;
        private var mScale:Number;
        private var mOnRestore:Function;
        private var mDataUploaded:Boolean;
        private static var sOrigin:Point = new Point();

        public function ConcreteTexture(param1:TextureBase, param2:String, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean = false, param8:Number = 1)
        {
            this.mScale = param8 <= 0 ? (1) : (param8);
            this.mBase = param1;
            this.mFormat = param2;
            this.mWidth = param3;
            this.mHeight = param4;
            this.mMipMapping = param5;
            this.mPremultipliedAlpha = param6;
            this.mOptimizedForRenderTexture = param7;
            this.mOnRestore = null;
            this.mDataUploaded = false;
            return;
        }// end function

        override public function dispose() : void
        {
            if (this.mBase)
            {
                this.mBase.dispose();
            }
            this.onRestore = null;
            super.dispose();
            return;
        }// end function

        public function uploadBitmap(param1:Bitmap) : void
        {
            this.uploadBitmapData(param1.bitmapData);
            return;
        }// end function

        public function uploadBitmapData(param1:BitmapData) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (param1.width != this.mWidth || param1.height != this.mHeight)
            {
                _loc_2 = new BitmapData(this.mWidth, this.mHeight, true, 0);
                _loc_2.copyPixels(param1, param1.rect, sOrigin);
                param1 = _loc_2;
            }
            if (this.mBase is Texture)
            {
                _loc_3 = this.mBase as Texture;
                _loc_3.uploadFromBitmapData(param1);
                if (this.mMipMapping && param1.width > 1 && param1.height > 1)
                {
                    _loc_4 = param1.width >> 1;
                    _loc_5 = param1.height >> 1;
                    _loc_6 = 1;
                    _loc_7 = new BitmapData(_loc_4, _loc_5, true, 0);
                    _loc_8 = new Matrix(0.5, 0, 0, 0.5);
                    _loc_9 = new Rectangle();
                    while (_loc_4 >= 1 || _loc_5 >= 1)
                    {
                        
                        _loc_9.width = _loc_4;
                        _loc_9.height = _loc_5;
                        _loc_7.fillRect(_loc_9, 0);
                        _loc_7.draw(param1, _loc_8, null, null, null, true);
                        _loc_3.uploadFromBitmapData(_loc_7, _loc_6++);
                        _loc_8.scale(0.5, 0.5);
                        _loc_4 = _loc_4 >> 1;
                        _loc_5 = _loc_5 >> 1;
                    }
                    _loc_7.dispose();
                }
            }
            else
            {
                var _loc_10:* = this.mBase;
                _loc_10["uploadFromBitmapData"](param1);
            }
            if (_loc_2)
            {
                _loc_2.dispose();
            }
            this.mDataUploaded = true;
            return;
        }// end function

        public function uploadAtfData(param1:ByteArray, param2:int = 0, param3 = null) : void
        {
            var eventType:String;
            var self:ConcreteTexture;
            var potTexture:Texture;
            var onTextureReady:Function;
            var data:* = param1;
            var offset:* = param2;
            var async:* = param3;
            onTextureReady = function (param1:Object) : void
            {
                potTexture.removeEventListener(eventType, onTextureReady);
                var _loc_2:* = async as Function;
                if (_loc_2 != null)
                {
                    if (_loc_2.length == 1)
                    {
                        null._loc_2(self);
                    }
                    else
                    {
                        null._loc_2();
                    }
                }
                return;
            }// end function
            ;
            eventType;
            self;
            var isAsync:* = async is Function || async === true;
            potTexture = this.mBase as Texture;
            if (async is Function)
            {
                potTexture.addEventListener(eventType, onTextureReady);
            }
            potTexture.uploadCompressedTextureFromByteArray(data, offset, isAsync);
            this.mDataUploaded = true;
            return;
        }// end function

        private function onContextCreated() : void
        {
            this.createBase();
            this.mOnRestore();
            if (!this.mDataUploaded)
            {
                this.clear();
            }
            return;
        }// end function

        function createBase() : void
        {
            var _loc_1:* = Starling.context;
            var _loc_2:* = this.mWidth == getNextPowerOfTwo(this.mWidth) && this.mHeight == getNextPowerOfTwo(this.mHeight);
            if (_loc_2)
            {
                this.mBase = _loc_1.createTexture(this.mWidth, this.mHeight, this.mFormat, this.mOptimizedForRenderTexture);
            }
            else
            {
                var _loc_3:* = _loc_1;
                this.mBase = _loc_3["createRectangleTexture"](this.mWidth, this.mHeight, this.mFormat, this.mOptimizedForRenderTexture);
            }
            this.mDataUploaded = false;
            return;
        }// end function

        public function clear(param1:uint = 0, param2:Number = 0) : void
        {
            var _loc_3:* = Starling.context;
            if (_loc_3 == null)
            {
                throw new MissingContextError();
            }
            if (this.mPremultipliedAlpha && param2 < 1)
            {
                param1 = Color.rgb(Color.getRed(param1) * param2, Color.getGreen(param1) * param2, Color.getBlue(param1) * param2);
            }
            _loc_3.setRenderToTexture(this.mBase);
            try
            {
                RenderSupport.clear(param1, param2);
            }
            catch (e:Error)
            {
            }
            _loc_3.setRenderToBackBuffer();
            this.mDataUploaded = true;
            return;
        }// end function

        public function get optimizedForRenderTexture() : Boolean
        {
            return this.mOptimizedForRenderTexture;
        }// end function

        public function get onRestore() : Function
        {
            return this.mOnRestore;
        }// end function

        public function set onRestore(param1:Function) : void
        {
            Starling.current.removeEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated);
            if (Starling.handleLostContext && param1 != null)
            {
                this.mOnRestore = param1;
                Starling.current.addEventListener(Event.CONTEXT3D_CREATE, this.onContextCreated);
            }
            else
            {
                this.mOnRestore = null;
            }
            return;
        }// end function

        override public function get base() : TextureBase
        {
            return this.mBase;
        }// end function

        override public function get root() : ConcreteTexture
        {
            return this;
        }// end function

        override public function get format() : String
        {
            return this.mFormat;
        }// end function

        override public function get width() : Number
        {
            return this.mWidth / this.mScale;
        }// end function

        override public function get height() : Number
        {
            return this.mHeight / this.mScale;
        }// end function

        override public function get nativeWidth() : Number
        {
            return this.mWidth;
        }// end function

        override public function get nativeHeight() : Number
        {
            return this.mHeight;
        }// end function

        override public function get scale() : Number
        {
            return this.mScale;
        }// end function

        override public function get mipMapping() : Boolean
        {
            return this.mMipMapping;
        }// end function

        override public function get premultipliedAlpha() : Boolean
        {
            return this.mPremultipliedAlpha;
        }// end function

    }
}
