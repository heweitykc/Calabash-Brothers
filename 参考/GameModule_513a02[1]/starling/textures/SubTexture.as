package starling.textures
{
    import __AS3__.vec.*;
    import flash.display3D.textures.*;
    import flash.geom.*;
    import starling.utils.*;

    public class SubTexture extends Texture
    {
        private var mParent:Texture;
        private var mClipping:Rectangle;
        private var mRootClipping:Rectangle;
        private var mOwnsParent:Boolean;
        private static var sTexCoords:Point = new Point();

        public function SubTexture(param1:Texture, param2:Rectangle, param3:Boolean = false)
        {
            this.mParent = param1;
            this.mOwnsParent = param3;
            if (param2 == null)
            {
                this.setClipping(new Rectangle(0, 0, 1, 1));
            }
            else
            {
                this.setClipping(new Rectangle(param2.x / param1.width, param2.y / param1.height, param2.width / param1.width, param2.height / param1.height));
            }
            return;
        }// end function

        override public function dispose() : void
        {
            if (this.mOwnsParent)
            {
                this.mParent.dispose();
            }
            super.dispose();
            return;
        }// end function

        private function setClipping(param1:Rectangle) : void
        {
            var _loc_3:* = null;
            this.mClipping = param1;
            this.mRootClipping = param1.clone();
            var _loc_2:* = this.mParent as SubTexture;
            while (_loc_2)
            {
                
                _loc_3 = _loc_2.mClipping;
                this.mRootClipping.x = _loc_3.x + this.mRootClipping.x * _loc_3.width;
                this.mRootClipping.y = _loc_3.y + this.mRootClipping.y * _loc_3.height;
                this.mRootClipping.width = this.mRootClipping.width * _loc_3.width;
                this.mRootClipping.height = this.mRootClipping.height * _loc_3.height;
                _loc_2 = _loc_2.mParent as SubTexture;
            }
            return;
        }// end function

        override public function adjustVertexData(param1:VertexData, param2:int, param3:int) : void
        {
            super.adjustVertexData(param1, param2, param3);
            var _loc_4:* = this.mRootClipping.x;
            var _loc_5:* = this.mRootClipping.y;
            var _loc_6:* = this.mRootClipping.width;
            var _loc_7:* = this.mRootClipping.height;
            var _loc_8:* = param2 + param3;
            var _loc_9:* = param2;
            while (_loc_9 < _loc_8)
            {
                
                param1.getTexCoords(_loc_9, sTexCoords);
                param1.setTexCoords(_loc_9, _loc_4 + sTexCoords.x * _loc_6, _loc_5 + sTexCoords.y * _loc_7);
                _loc_9++;
            }
            return;
        }// end function

        override public function adjustTexCoords(param1:Vector.<Number>, param2:int = 0, param3:int = 0, param4:int = -1) : void
        {
            if (param4 < 0)
            {
                param4 = (param1.length - param2 - 2) / (param3 + 2) + 1;
            }
            var _loc_5:* = param2;
            var _loc_6:* = 0;
            while (_loc_6 < param4)
            {
                
                param1[_loc_5] = this.mRootClipping.x + param1[_loc_5] * this.mRootClipping.width;
                _loc_5 = _loc_5 + 1;
                param1[_loc_5] = this.mRootClipping.y + param1[_loc_5] * this.mRootClipping.height;
                _loc_5 = _loc_5 + (1 + param3);
                _loc_6++;
            }
            return;
        }// end function

        public function get parent() : Texture
        {
            return this.mParent;
        }// end function

        public function get ownsParent() : Boolean
        {
            return this.mOwnsParent;
        }// end function

        public function get clipping() : Rectangle
        {
            return this.mClipping.clone();
        }// end function

        override public function get base() : TextureBase
        {
            return this.mParent.base;
        }// end function

        override public function get root() : ConcreteTexture
        {
            return this.mParent.root;
        }// end function

        override public function get format() : String
        {
            return this.mParent.format;
        }// end function

        override public function get width() : Number
        {
            return this.mParent.width * this.mClipping.width;
        }// end function

        override public function get height() : Number
        {
            return this.mParent.height * this.mClipping.height;
        }// end function

        override public function get nativeWidth() : Number
        {
            return this.mParent.nativeWidth * this.mClipping.width;
        }// end function

        override public function get nativeHeight() : Number
        {
            return this.mParent.nativeHeight * this.mClipping.height;
        }// end function

        override public function get mipMapping() : Boolean
        {
            return this.mParent.mipMapping;
        }// end function

        override public function get premultipliedAlpha() : Boolean
        {
            return this.mParent.premultipliedAlpha;
        }// end function

        override public function get scale() : Number
        {
            return this.mParent.scale;
        }// end function

    }
}
