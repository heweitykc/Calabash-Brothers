package com.f1.ui.container
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;

    public class HBox extends BaseSprite
    {
        public var oneRow:uint;
        private var _left:Boolean = true;
        protected var _horizontal:Boolean;
        protected var _intervalX:Number;
        protected var _intervalY:Number;
        protected var _contents:Array;
        public var row:uint;
        protected var lie:uint;
        public var cellW:Number;
        public var cellH:Number;
        private var _align:String;
        private var leftBegin:int = 1;
        private var topBegin:int = 1;
        public static const Align_LeftTop:String = "lefttop";
        public static const Align_LeftBottom:String = "leftbottom";
        public static const Align_RightTop:String = "righttop";
        public static const Align_RightBottom:String = "rightbottom";

        public function HBox()
        {
            mouseEnabled = false;
            this._contents = [];
            this._intervalX = 5;
            this._intervalY = 5;
            return;
        }// end function

        public function get contents() : Array
        {
            return this._contents;
        }// end function

        public function set contents(param1:Array) : void
        {
            this._contents = param1;
            return;
        }// end function

        public function set intervalX(param1:Number) : void
        {
            this._intervalX = param1;
            return;
        }// end function

        public function set intervalY(param1:Number) : void
        {
            this._intervalY = param1;
            return;
        }// end function

        public function get intervalX() : Number
        {
            return this._intervalX;
        }// end function

        public function get intervalY() : Number
        {
            return this._intervalY;
        }// end function

        public function get length() : uint
        {
            return this._contents.length;
        }// end function

        public function set horizontal(param1:Boolean) : void
        {
            this._horizontal = param1;
            return;
        }// end function

        public function get horizontal() : Boolean
        {
            return this._horizontal;
        }// end function

        public function get size() : uint
        {
            if (this._contents != null)
            {
                return this._contents.length;
            }
            return 0;
        }// end function

        public function getSizeNotNull() : uint
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            for each (_loc_2 in this._contents)
            {
                
                if (_loc_2 != null)
                {
                    _loc_1 = _loc_1 + 1;
                }
            }
            return _loc_1;
        }// end function

        public function reset(param1:Boolean = false, param2:Boolean = false) : void
        {
            ToolKit.clearMcChild(this, param1, param2);
            this.row = 0;
            this.lie = 0;
            _w = 0;
            _h = 0;
            this._contents = [];
            return;
        }// end function

        public function removeByIndexs(param1:Array) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = [];
            for each (_loc_4 in param1)
            {
                
                _loc_3 = this._contents[_loc_4];
                if (!_loc_3)
                {
                    continue;
                }
                removeChild(_loc_3);
                this._contents[_loc_4] = null;
                delete this._contents[_loc_4];
                _loc_2.push(_loc_3);
            }
            this.update();
            return _loc_2;
        }// end function

        public function removeByIndex(param1:int)
        {
            if (param1 == -1)
            {
                return;
            }
            if (param1 > (this._contents.length - 1))
            {
                return;
            }
            var _loc_2:* = this._contents.splice(param1, 1);
            this.update();
            return _loc_2;
        }// end function

        public function remove(param1) : void
        {
            var _loc_2:* = this._contents.indexOf(param1);
            this.removeByIndex(_loc_2);
            return;
        }// end function

        public function update() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this._contents.concat();
            this.reset();
            for each (_loc_2 in _loc_1)
            {
                
                this.add(_loc_2);
            }
            return;
        }// end function

        public function sortOn(param1:Object, param2:Object = null) : void
        {
            if (this._contents.length > 1)
            {
                this._contents.sortOn(param1, param2);
            }
            return;
        }// end function

        public function getContent(param1:uint)
        {
            if (param1 > (this._contents.length - 1))
            {
                return null;
            }
            return this._contents[param1];
        }// end function

        public function getContentIdx(param1) : int
        {
            return this._contents.indexOf(param1);
        }// end function

        public function addAt(param1, param2:uint, param3:Boolean = false, param4:int = 0, param5:int = 0) : void
        {
            this._contents.splice(param2, 0, param1);
            this.update();
            return;
        }// end function

        public function setItemWH(param1:Number, param2:Number) : void
        {
            this.cellW = param1;
            this.cellH = param2;
            return;
        }// end function

        public function add(param1, param2:Boolean = false, param3:int = 0, param4:int = 0) : DisplayObject
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            if (param1)
            {
                if (param1.parent == this)
                {
                    return param1;
                }
                if (param1 is BaseSprite && !param2)
                {
                    if ((param1 as BaseSprite)._w > 0)
                    {
                        this.cellW = (param1 as BaseSprite)._w;
                    }
                    else
                    {
                        this.cellW = param1.width;
                    }
                    if ((param1 as BaseSprite)._h > 0)
                    {
                        this.cellH = (param1 as BaseSprite)._h;
                    }
                    else
                    {
                        this.cellH = param1.height;
                    }
                }
                else
                {
                    this.cellW = param1.width;
                    this.cellH = param1.height;
                }
            }
            if (this._horizontal)
            {
                if (this.oneRow != 0)
                {
                    _loc_5 = (this.cellW + this._intervalX) * this.lie * this.leftBegin + param3;
                    _loc_6 = ((this.cellH + this._intervalY) * this.row + param4) * this.topBegin;
                    if (_loc_5 + this.cellW > _w)
                    {
                        _w = _loc_5 + this.cellW;
                    }
                    if (_loc_6 + this.cellH > _h)
                    {
                        _h = _loc_6 + this.cellH;
                    }
                    if (this.lie < (this.oneRow - 1))
                    {
                        var _loc_7:* = this;
                        var _loc_8:* = this.lie + 1;
                        _loc_7.lie = _loc_8;
                    }
                    else
                    {
                        this.lie = 0;
                        var _loc_7:* = this;
                        var _loc_8:* = this.row + 1;
                        _loc_7.row = _loc_8;
                    }
                }
                else
                {
                    _loc_5 = (this.cellW + this._intervalX) * this._contents.length * this.leftBegin + param3;
                    _loc_6 = param4;
                    if (_loc_5 + this.cellW + param3 > _w)
                    {
                        _w = _loc_5 + this.cellW + param3;
                    }
                    if (param4 + this.cellH > _h)
                    {
                        _h = param4 + this.cellH;
                    }
                }
            }
            else if (this.oneRow != 0)
            {
                if (this.row < (this.oneRow - 1))
                {
                    _loc_5 = (this.cellW + this._intervalX) * this.row * this.leftBegin + param3;
                    _loc_6 = (this.cellH + this._intervalY) * this.lie * this.topBegin + param4;
                    var _loc_7:* = this;
                    var _loc_8:* = this.row + 1;
                    _loc_7.row = _loc_8;
                }
                else
                {
                    _loc_5 = (this.cellW + this._intervalX) * this.row * this.leftBegin + param3;
                    _loc_6 = (this.cellH + this._intervalY) * this.lie * this.topBegin + param4;
                    this.row = 0;
                    var _loc_7:* = this;
                    var _loc_8:* = this.lie + 1;
                    _loc_7.lie = _loc_8;
                }
                if (_loc_5 + this.cellW > _w)
                {
                    _w = _loc_5 + this.cellW;
                }
                if (_loc_6 + this.cellH > _h)
                {
                    _h = _loc_6 + this.cellH;
                }
            }
            else
            {
                _loc_5 = param3;
                _loc_6 = _h + param4;
                if (this._contents.length > 0)
                {
                    _loc_6 = _loc_6 + this.intervalY;
                }
                if (_loc_5 + this.cellW > _w)
                {
                    _w = _loc_5 + this.cellW;
                }
                if (_loc_6 + this.cellH > _h)
                {
                    _h = _loc_6 + this.cellH;
                }
            }
            if (param1)
            {
                param1.x = _loc_5 + (this.leftBegin == 1 ? (0) : (-this.cellW));
                param1.y = _loc_6 + (this.topBegin == 1 ? (0) : (-this.cellH));
                addChild(param1);
                if (this._contents.indexOf(param1) == -1)
                {
                    this._contents.push(param1);
                }
            }
            else
            {
                this._contents.push(null);
            }
            return param1;
        }// end function

        public function set align(param1:String) : void
        {
            switch(param1)
            {
                case Align_LeftTop:
                {
                    this.leftBegin = 1;
                    this.topBegin = 1;
                    break;
                }
                case Align_LeftBottom:
                {
                    this.leftBegin = 1;
                    this.topBegin = -1;
                    break;
                }
                case Align_RightTop:
                {
                    this.leftBegin = -1;
                    this.topBegin = 1;
                    break;
                }
                case Align_RightBottom:
                {
                    this.leftBegin = -1;
                    this.topBegin = -1;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
