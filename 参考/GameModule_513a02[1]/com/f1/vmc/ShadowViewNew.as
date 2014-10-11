package com.f1.vmc
{
    import com.f1.*;
    import flash.display.*;
    import flash.geom.*;

    public class ShadowViewNew extends BaseSprite
    {
        private var bmp:Bitmap;
        private var direct:int;
        private var count:int = 0;
        private var bmpFactory:Array;
        private var h:Number = 0;
        private static const matrix:Matrix = new Matrix(1, 0, Math.tan(40 * Math.PI / 180), 0.5);
        private static const colorTransform:ColorTransform = new ColorTransform(0, 0, 0, 0.5);

        public function ShadowViewNew()
        {
            this.bmpFactory = [];
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function getBmp(param1:int) : Bitmap
        {
            if (this.bmpFactory[param1])
            {
                return this.bmpFactory[param1];
            }
            this.bmp = new Bitmap();
            addChild(this.bmp);
            this.bmp.transform.colorTransform = colorTransform;
            this.bmpFactory[param1] = this.bmp;
            return this.bmp;
        }// end function

        public function programDraw(param1:VMCView, param2:Boolean) : void
        {
            this.bmp.bitmapData = param1.bitmapData;
            this.direct = param2 ? (-1) : (1);
            matrix.a = this.direct * 1;
            this.bmp.transform.matrix = matrix;
            this.bmp.transform.colorTransform = colorTransform;
            this.bmp.x = (-(270 - param1.y - 270)) * matrix.c;
            this.bmp.y = (270 - param1.y - 270) * (1 - matrix.d);
            this.x = param1.x - 0;
            this.y = param1.y - 0;
            return;
        }// end function

        public function programDrawShadow(param1:Array, param2:Boolean, param3:Boolean) : void
        {
            if (param1[0] == null)
            {
                return;
            }
            var _loc_4:* = param1[0];
            this.direct = param2 ? (-1) : (1);
            matrix.a = this.direct * 1;
            this.x = _loc_4.x;
            this.y = _loc_4.y;
            var _loc_5:* = param1.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_5)
            {
                
                _loc_4 = param1[_loc_6];
                if (_loc_4 && _loc_4.bitmapData != null)
                {
                    this.bmp = this.getBmp(_loc_6);
                    this.bmp.bitmapData = _loc_4.bitmapData;
                    this.bmp.transform.matrix = matrix;
                    if (_loc_6 == 0)
                    {
                        if (param3)
                        {
                            this.h = _loc_4.y;
                        }
                        else
                        {
                            this.h = -_loc_4.height;
                        }
                        this.bmp.x = this.h * matrix.c;
                        this.bmp.y = (-this.h) * (1 - matrix.d);
                    }
                    else
                    {
                        this.bmp.x = _loc_4.x - this.x + _loc_4.y * matrix.c;
                        this.bmp.y = _loc_4.y - this.y + (-_loc_4.y) * (1 - matrix.d);
                    }
                }
                else if (this.bmpFactory[_loc_6])
                {
                    removeChild(this.bmpFactory[_loc_6]);
                    this.bmpFactory[_loc_6] = null;
                }
                _loc_6++;
            }
            return;
        }// end function

    }
}
