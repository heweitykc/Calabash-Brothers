package com.f1.ui.btn
{
    import flash.display.*;

    public class BmpButton extends BaseButton
    {
        private var _bmp:Bitmap;

        public function BmpButton(param1 = null, param2:Boolean = false, param3 = null)
        {
            super(param1, param2, param3);
            return;
        }// end function

        public function addBmp(param1:Bitmap, param2:int = 0, param3:int = 0) : void
        {
            if (this._bmp && this._bmp.parent)
            {
                this._bmp.parent.removeChild(this._bmp);
                this._bmp = null;
            }
            this._bmp = param1;
            param1.x = (width - param1.width) * 0.5 + param2;
            param1.y = (height - param1.height) * 0.5 + param3;
            addChild(param1);
            return;
        }// end function

    }
}
