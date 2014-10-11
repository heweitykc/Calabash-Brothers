package com.f1.ui.image
{
    import com.f1.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class TxtImage extends Object
    {
        private static var _txt:TextField;
        private static var txtDic:Dictionary = new Dictionary();

        public function TxtImage()
        {
            return;
        }// end function

        public static function getTxtImage(param1:String, param2:TextFormat = null) : Bitmap
        {
            if (!_txt)
            {
                _txt = new TextField();
                _txt.htmlText = "";
                _txt.autoSize = TextFieldAutoSize.LEFT;
                _txt.selectable = false;
                _txt.filters = [FrameworkGlobal.BLACK_FILTER];
            }
            param2.bold = false;
            if (param2)
            {
                _txt.defaultTextFormat = param2;
            }
            _txt.text = param1;
            var _loc_3:* = param1 + (param2 ? ("_" + param2.size + "_" + param2.color) : (""));
            var _loc_4:* = txtDic[_loc_3];
            if (!txtDic[_loc_3])
            {
                _loc_4 = new BitmapData(_txt.width + 2, _txt.height + 2, true, 16777215);
                _loc_4.draw(_txt);
                txtDic[_loc_3] = _loc_4;
            }
            var _loc_5:* = new Bitmap(_loc_4);
            return new Bitmap(_loc_4);
        }// end function

    }
}
