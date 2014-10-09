package com.f1.ui.imagesNumbericStepper
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;

    public class ImgNumber extends BaseSprite
    {
        private var _numId:int = 3;
        private var sp1:DisplayObject;
        private var _scale:Number = 1;
        private var flag:int = 1;

        public function ImgNumber()
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function get scale() : Number
        {
            return this._scale;
        }// end function

        public function set scale(param1:Number) : void
        {
            this._scale = param1;
            return;
        }// end function

        public function get numId() : int
        {
            return this._numId;
        }// end function

        public function set numId(param1:int) : void
        {
            this._numId = param1;
            return;
        }// end function

        public function setNumber(param1:String, param2:int = 0, param3:int = 0, param4:Boolean = false, param5:Boolean = false, param6:String = "") : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 && param1 != "")
            {
                if (param2 > 0)
                {
                    this._numId = param2;
                }
                this.reset();
                if (param5 && param6 != "")
                {
                    this.sp1 = ObjectPool.CheckOutByName(param6);
                    addChild(this.sp1);
                }
                _loc_7 = param1.split("");
                if (this.flag == -1)
                {
                    _loc_7.reverse();
                }
                for each (_loc_8 in _loc_7)
                {
                    
                    if (_loc_8 == "-")
                    {
                        _loc_8 = "dec";
                    }
                    else if (_loc_8 == "+")
                    {
                        _loc_8 = "plus";
                    }
                    else if (_loc_8 == "%")
                    {
                        _loc_8 = "100";
                    }
                    else if (_loc_8 == ",")
                    {
                        _loc_8 = "dot";
                    }
                    else if (_loc_8 == ".")
                    {
                        _loc_8 = "point";
                    }
                    if (param4)
                    {
                        this.sp1 = ObjectPool.CheckOutByName("numgundong" + this._numId);
                        if (this.sp1)
                        {
                            MovieClip(this.sp1).gotoAndPlay((_loc_8 + 1));
                        }
                    }
                    else
                    {
                        this.sp1 = ObjectPool.CheckOutByName("num_" + this._numId + "_" + _loc_8);
                    }
                    if (this.sp1)
                    {
                        this.sp1.scaleX = this.scale;
                        this.sp1.scaleY = this.scale;
                        if (this.width == 0)
                        {
                            this.sp1.x = 0;
                        }
                        else
                        {
                            this.sp1.x = this.width * this.flag + param3;
                        }
                        addChild(this.sp1);
                    }
                }
                if (param4)
                {
                    TweenLite.killDelayedCallsTo(this.setNumber);
                    TweenLite.delayedCall(0.5, this.setNumber, [param1, param2]);
                }
                setWH(width, height);
            }
            return;
        }// end function

        public function setNumberScroll(param1:String, param2:int = 0, param3:int = 0, param4:int = 23, param5:int = 31, param6:Boolean = true, param7:Boolean = false) : void
        {
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            if (param1 && param1 != "")
            {
                if (param2 > 0)
                {
                    this._numId = param2;
                }
                this.reset();
                _loc_8 = param1.length;
                _loc_9 = 0;
                _loc_10 = 0.3;
                if (param6)
                {
                    this.parent.x = (this.parent.parent.width - param4 * _loc_8) / 2;
                }
                _loc_11 = param1.split("");
                for each (_loc_12 in _loc_11)
                {
                    
                    _loc_13 = "scroll_" + this._numId;
                    if (_loc_12 == "-")
                    {
                        _loc_13 = "scroll_dec_" + this._numId;
                    }
                    else if (_loc_12 == "+")
                    {
                        _loc_13 = "scroll_plus_" + this._numId;
                    }
                    this.sp1 = ToolKit.getNew(_loc_13);
                    if (this.sp1)
                    {
                        if (this.width == 0)
                        {
                            this.sp1.x = 0;
                        }
                        else
                        {
                            this.sp1.x = this.width * this.flag + param3;
                        }
                        addChild(this.sp1);
                        this.sp1.y = 0;
                        if (_loc_12 != "scroll_plus")
                        {
                            TweenLite.delayedCall(_loc_10 * (_loc_8 - _loc_9 - 1), this.scrollFun, [this.sp1, _loc_10, _loc_12, param5]);
                        }
                    }
                    _loc_9++;
                }
                if (param7)
                {
                    TweenLite.delayedCall(_loc_10 * _loc_8, this.fadeEffect);
                }
            }
            return;
        }// end function

        private function scrollFun(param1:DisplayObject, param2:Number, param3:String, param4:int) : void
        {
            TweenLite.to(param1, param2, {y:param1.y - int(param3) * param4});
            return;
        }// end function

        private function fadeEffect() : void
        {
            FrameworkGlobal.sendMsg(new Event("fadeOut"));
            return;
        }// end function

        public function reset() : void
        {
            ToolKit.clearMcChild(this, false, true);
            return;
        }// end function

        public function set align(param1:String) : void
        {
            if (param1 == Align.LEFT)
            {
                this.flag = 1;
            }
            else
            {
                this.flag = -1;
            }
            return;
        }// end function

    }
}
