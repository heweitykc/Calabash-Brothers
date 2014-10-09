package com.f1.ui.image
{
    import com.f1.*;

    public class ImageSP extends BaseSprite
    {
        private var _img:Image;

        public function ImageSP()
        {
            this._img = new Image();
            addChild(this._img);
            return;
        }// end function

        public function load(param1:String, param2:Function = null, param3:Function = null, param4:Function = null, param5:Boolean = false) : void
        {
            this._img.load(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function get url() : String
        {
            return this._img.url;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._img.width = param1;
            return;
        }// end function

        override public function get width() : Number
        {
            return this._img.width;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._img.height = param1;
            return;
        }// end function

        override public function get height() : Number
        {
            return this._img.height;
        }// end function

        public function set smoothing(param1:Boolean) : void
        {
            this._img.smoothing = param1;
            return;
        }// end function

        public function get smoothing() : Boolean
        {
            return this._img.smoothing;
        }// end function

        public function dispose() : void
        {
            this._img.dispose();
            return;
        }// end function

    }
}
