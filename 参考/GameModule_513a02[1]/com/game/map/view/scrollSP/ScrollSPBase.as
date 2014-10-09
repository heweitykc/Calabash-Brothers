package com.game.map.view.scrollSP
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;

    public class ScrollSPBase extends BaseSprite
    {
        private var _contentMask:Shape;
        private var _content:DisplayObject;
        private var _viewWidth:int;
        private var _viewHeight:int;
        private var _layoutType:int = 1;
        private var _offsetX:Number;
        private var _offsetY:Number;
        private var _mouseDownX:Number;
        private var _mouseDownY:Number;
        private var _hasMove:Boolean;
        private var _hasMoveOut:Boolean;
        private var _mouseUpFun:Function;

        public function ScrollSPBase(param1:int, param2:int)
        {
            this.init();
            this.setViewWH(param1, param2);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this._mouseDown);
            return;
        }// end function

        private function init() : void
        {
            this._contentMask = new Shape();
            this._contentMask.graphics.beginFill(0, 0);
            this._contentMask.graphics.drawRect(0, 0, 1, 1);
            this._contentMask.graphics.endFill();
            addChild(this._contentMask);
            return;
        }// end function

        public function get content() : DisplayObject
        {
            return this._content;
        }// end function

        public function seContent(param1:DisplayObject, param2:int, param3:Boolean = true) : void
        {
            if (this._content && this._content.parent)
            {
                this._content.parent.removeChild(this._content);
            }
            this._content = null;
            this._content = param1;
            this._content.mask = this._contentMask;
            addChild(this._content);
            this._layoutType = param2;
            if (param3)
            {
                this.setOffset(this._content.x, this._content.y);
            }
            return;
        }// end function

        public function setViewWH(param1:int, param2:int) : void
        {
            var _loc_3:* = param1;
            this._contentMask.width = param1;
            this._viewWidth = _loc_3;
            var _loc_3:* = param2;
            this._contentMask.height = param2;
            this._viewHeight = _loc_3;
            return;
        }// end function

        public function setOffset(param1:Number, param2:Number, param3:Boolean = true, param4:Boolean = false) : void
        {
            if (this._content)
            {
                TweenLite.killTweensOf(this._content, false);
                if (!this._hasMoveOut || param4)
                {
                    this._offsetX = this._getLegelX(param1);
                    this._offsetY = this._getLegelY(param2);
                    if (param3)
                    {
                        TweenLite.to(this._content, 0.2, {x:this._offsetX, y:this._offsetY});
                    }
                    else
                    {
                        this._content.x = this._offsetX;
                        this._content.y = this._offsetY;
                    }
                }
            }
            return;
        }// end function

        public function setMouseUpFun(param1:Function) : void
        {
            this._mouseUpFun = param1;
            return;
        }// end function

        public function moveContent(param1:Number, param2:Number) : void
        {
            if (this._content)
            {
                this.setOffset(this._content.x + param1, this._content.y + param2, false, true);
            }
            return;
        }// end function

        private function _getLegelX(param1:Number) : Number
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = this._viewWidth - this._content.width;
            switch(this._layoutType)
            {
                case Layout.CENTER:
                case Layout.TOP_CENTER:
                case Layout.BOTTOM_CENTER:
                {
                }
                case Layout.LEFT_CENTER:
                case Layout.BOTTOM:
                {
                }
                case Layout.RIGHT_CENTER:
                case Layout.BOTTOM_RIGHT:
                case Layout.RIGHT:
                {
                }
                default:
                {
                    break;
                }
            }
            return param1;
        }// end function

        private function _getLegelY(param1:Number) : Number
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = this._viewHeight - this._content.height;
            switch(this._layoutType)
            {
                case Layout.CENTER:
                case Layout.RIGHT_CENTER:
                case Layout.LEFT_CENTER:
                {
                }
                case Layout.BOTTOM_RIGHT:
                case Layout.BOTTOM:
                case Layout.BOTTOM_CENTER:
                {
                }
                case Layout.TOP_CENTER:
                case Layout.RIGHT:
                {
                }
                default:
                {
                    break;
                }
            }
            return param1;
        }// end function

        private function _getLegelPos(param1:Number, param2:Number, param3:Number) : Number
        {
            if (param1 < param2)
            {
                return param2;
            }
            if (param1 > param3)
            {
                return param3;
            }
            return param1;
        }// end function

        private function _mouseDown(event:MouseEvent) : void
        {
            this._mouseDownX = event.stageX;
            this._mouseDownY = event.stageY;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this._mouseMove);
            this.addEventListener(MouseEvent.MOUSE_UP, this._mouseUp);
            this.addEventListener(MouseEvent.MOUSE_OUT, this._mouseOut);
            return;
        }// end function

        private function _mouseMove(event:MouseEvent) : void
        {
            this._hasMove = true;
            this._hasMoveOut = true;
            var _loc_2:* = event.stageX;
            var _loc_3:* = event.stageY;
            var _loc_4:* = _loc_2 - this._mouseDownX;
            var _loc_5:* = _loc_3 - this._mouseDownY;
            this._mouseDownX = _loc_2;
            this._mouseDownY = _loc_3;
            this.moveContent(_loc_4, _loc_5);
            return;
        }// end function

        private function _mouseUp(event:MouseEvent) : void
        {
            if (!this._hasMove)
            {
                if (this._mouseUpFun != null)
                {
                    TweenLite.killTweensOf(this._content, true);
                    this._mouseUpFun(event);
                }
            }
            this.endMove();
            return;
        }// end function

        private function _mouseOut(event:MouseEvent) : void
        {
            this.endMove();
            return;
        }// end function

        private function endMove() : void
        {
            if (stage)
            {
                this._hasMove = false;
                stage.removeEventListener(MouseEvent.MOUSE_MOVE, this._mouseMove);
                this.removeEventListener(MouseEvent.MOUSE_UP, this._mouseUp);
                this.removeEventListener(MouseEvent.MOUSE_OUT, this._mouseOut);
            }
            return;
        }// end function

        public function get offsetX() : Number
        {
            return this._offsetX;
        }// end function

        public function get offsetY() : Number
        {
            return this._offsetY;
        }// end function

        public function set hasMoveOut(param1:Boolean) : void
        {
            this._hasMoveOut = param1;
            return;
        }// end function

    }
}
