package com.view.icon
{
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class IconBase extends BaseSprite
    {
        protected var _backImage:Object;
        protected var _place:String;
        protected var _image:Image;
        protected var _widthImg:int = 40;
        protected var _heightImg:int = 40;
        protected var _hitShape:Sprite;
        private var _priTimer:int;

        public function IconBase(param1 = "backpackbox_bg")
        {
            this._hitShape = new Sprite();
            if (param1 && param1 is String && param1.length > 0)
            {
                if (param1 is String)
                {
                    this._backImage = ToolKit.getNewDO(param1);
                }
                addChild(this._backImage);
            }
            else if (param1)
            {
                this._backImage = param1;
                x = param1.x;
                y = param1.y;
                param1.x = 0;
                param1.y = 0;
                addChild(this._backImage);
            }
            if (this._backImage)
            {
                this.initHitArea();
            }
            this._image = new Image();
            this._image.smoothing = true;
            addChild(this._image);
            buttonMode = true;
            return;
        }// end function

        protected function initHitArea() : void
        {
            this._hitShape.graphics.beginFill(0, 0);
            this._hitShape.graphics.drawRect(0, 0, this._backImage.width, this._backImage.height);
            this._hitShape.graphics.endFill();
            this.addChild(this._hitShape);
            this.hitArea = this._hitShape;
            return;
        }// end function

        public function get image() : Image
        {
            return this._image;
        }// end function

        public function set image(param1:Image) : void
        {
            this._image = param1;
            return;
        }// end function

        protected function doDoubleClick() : void
        {
            return;
        }// end function

        protected function __rightClick(event:MouseEvent) : void
        {
            return;
        }// end function

        public function setImageSize(param1:int, param2:int) : void
        {
            this._widthImg = param1;
            this._heightImg = param2;
            return;
        }// end function

        public function get widthImg() : int
        {
            return this._widthImg;
        }// end function

        public function get heightImg() : int
        {
            return this._heightImg;
        }// end function

        protected function singleClick(param1:int, param2:int) : void
        {
            return;
        }// end function

        public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            if (param1 && param1.hasOwnProperty("url"))
            {
                this._image.load(param1.url, null, null, null, true);
            }
            return;
        }// end function

        protected function __click(event:MouseEvent) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._priTimer < 200)
            {
                this.doDoubleClick();
                this._priTimer = 0;
            }
            else
            {
                this._priTimer = _loc_2;
                TweenLite.delayedCall(0.2, this.singleClick, [mouseX, mouseY]);
            }
            return;
        }// end function

    }
}
