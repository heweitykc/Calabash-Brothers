package com.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import flash.text.*;

    public class ImageTxtIcon extends ImageSP
    {
        private var _txt:TextField;

        public function ImageTxtIcon(param1:uint, param2:uint)
        {
            setWH(param1, param2);
            this._txt = new TextField();
            var _loc_3:* = new TextFormat();
            _loc_3.color = 16777215;
            _loc_3.align = "right";
            this._txt.defaultTextFormat = _loc_3;
            this._txt.height = 18;
            this._txt.width = 25;
            this._txt.filters = [FrameworkGlobal.BLACK_FILTER];
            layoutMC(this._txt, Layout.BOTTOM_RIGHT);
            addChild(this._txt);
            return;
        }// end function

        public function setTxt(param1:uint) : void
        {
            if (param1 == 0 || param1 == 1)
            {
                this._txt.text = "";
            }
            else
            {
                this._txt.text = param1.toString();
            }
            return;
        }// end function

    }
}
