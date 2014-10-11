package com.f1.ui.image
{
    import com.f1.manager.resource.*;
    import flash.display.*;

    public class Image extends Bitmap
    {
        private var _url:String;
        private var bmWidth:Number = 0;
        private var bmHeight:Number = 0;
        private var bmSmoothing:Boolean = false;
        private var bmScaleX:Number = 1;
        private var bmScaleY:Number = 1;
        private var completeFunc:Function;

        public function Image()
        {
            return;
        }// end function

        public function get url() : String
        {
            return this._url;
        }// end function

        public function load(param1:String, param2:Function = null, param3:Function = null, param4:Function = null, param5:Boolean = false, param6:Boolean = false) : void
        {
            if (this.bitmapData != null && this._url == param1 && this.bmWidth != 0)
            {
                if (param2 != null)
                {
                    this.param2(this.bitmapData);
                }
                return;
            }
            this.completeFunc = param2;
            this.disposeBm(this._url);
            this._url = param1;
            if (param1 != null && param1 != "")
            {
                VResManager.load(param1, this.completeHandler, [param1], param3, param4, param5, false, param6);
            }
            return;
        }// end function

        public function dispose() : void
        {
            this.disposeBm(this._url);
            this._url = null;
            this.bmSmoothing = false;
            this.completeFunc = null;
            return;
        }// end function

        private function disposeBm(param1:String) : void
        {
            if (this.bitmapData != null)
            {
                this.bitmapData = null;
                this.bmWidth = 0;
                this.bmHeight = 0;
            }
            return;
        }// end function

        private function completeHandler(param1:BitmapData, param2:String) : void
        {
            if (this.url != null && this.url == param2)
            {
                this.bitmapData = param1;
                this.upate();
                if (this.completeFunc != null)
                {
                    this.completeFunc.call(null, param1);
                }
                this.completeFunc = null;
            }
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.bmWidth = param1;
            if (this.bitmapData != null)
            {
                super.width = param1;
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return this.bmWidth;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.bmHeight = param1;
            if (this.bitmapData != null)
            {
                super.height = param1;
            }
            return;
        }// end function

        override public function get height() : Number
        {
            return this.bmHeight;
        }// end function

        override public function set smoothing(param1:Boolean) : void
        {
            this.bmSmoothing = param1;
            if (this.bitmapData != null)
            {
                super.smoothing = param1;
            }
            return;
        }// end function

        override public function get smoothing() : Boolean
        {
            return this.bmSmoothing;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            x = param1;
            y = param2;
            return;
        }// end function

        override public function set scaleX(param1:Number) : void
        {
            this.bmScaleX = param1;
            this.upate();
            return;
        }// end function

        override public function set scaleY(param1:Number) : void
        {
            this.bmScaleY = param1;
            this.upate();
            return;
        }// end function

        public function setSize(param1:uint, param2:uint) : void
        {
            this.width = param1;
            this.height = param2;
            this.smoothing = true;
            return;
        }// end function

        private function upate() : void
        {
            if (this.bitmapData == null)
            {
                return;
            }
            if (this.bmWidth != 0)
            {
                this.width = this.bmWidth;
            }
            else
            {
                var _loc_1:* = this.bitmapData.width;
                this.width = this.bitmapData.width;
                this.bmWidth = _loc_1;
            }
            if (this.bmHeight != 0)
            {
                this.height = this.bmHeight;
            }
            else
            {
                var _loc_1:* = this.bitmapData.height;
                this.height = this.bitmapData.height;
                this.bmHeight = _loc_1;
            }
            this.smoothing = this.bmSmoothing;
            if (this.bmScaleX != 1)
            {
                super.scaleX = this.bmScaleX;
            }
            if (this.bmScaleY != 1)
            {
                super.scaleY = this.bmScaleY;
            }
            return;
        }// end function

    }
}
