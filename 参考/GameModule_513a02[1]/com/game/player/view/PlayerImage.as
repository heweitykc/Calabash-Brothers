package com.game.player.view
{
    import com.f1.ui.image.*;
    import flash.display.*;

    public class PlayerImage extends Sprite
    {
        private var _image:Image;

        public function PlayerImage()
        {
            this._image = new Image();
            this._image.smoothing = true;
            addChild(this._image);
            return;
        }// end function

        public function setUrl(param1:String) : void
        {
            this._image.load(param1);
            return;
        }// end function

        public function setScale(param1:Number, param2:Number) : void
        {
            this._image.scaleX = param1;
            this._image.scaleY = param2;
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            this._image.setSize(param1, param2);
            return;
        }// end function

    }
}
