package com.view.icon
{
    import com.f1.utils.*;
    import flash.display.*;

    public class NeedIcon extends IconItem
    {
        private var _mask:Sprite;

        public function NeedIcon(param1:String = "shopboxbg")
        {
            super(param1);
            this._mask = ToolKit.getNew("icon_mask");
            this._mask.x = _image.x;
            this._mask.y = _image.y;
            addChildAt(this._mask, getChildIndex(_image));
            return;
        }// end function

        public function get iconMask() : Sprite
        {
            return this._mask;
        }// end function

        public function set iconMask(param1:Sprite) : void
        {
            this._mask = param1;
            return;
        }// end function

        override public function setImageXY(param1:int, param2:int) : void
        {
            super.setImageXY(param1, param2);
            this._mask.x = _image.x;
            this._mask.y = _image.y;
            return;
        }// end function

        override public function setImageSize(param1:int, param2:int) : void
        {
            super.setImageSize(param1, param2);
            this._mask.width = param1 - 2;
            this._mask.height = param2 - 2;
            return;
        }// end function

        override public function set count(param1:Number) : void
        {
            _countTxt.text = _info.num.toString();
            if (_info == null)
            {
                return;
            }
            if (param1 > _info.num)
            {
                this._mask.visible = true;
            }
            else
            {
                this._mask.visible = false;
            }
            return;
        }// end function

    }
}
