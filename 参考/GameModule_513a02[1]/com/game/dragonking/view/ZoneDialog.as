package com.game.dragonking.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class ZoneDialog extends Component
    {
        private var _complete:Boolean;
        private var _top:MovieClip;
        private var _bottom:MovieClip;
        private var _nameTxt:TextField;
        private var _contentTxt:TextField;
        private var _leftBmp:Image;
        private var _rightBmp:Image;
        private var _auto:Boolean = false;
        private var _info:Object;
        private var _needToUp:Boolean;
        private var inTween:Boolean;
        private var startTime:int;

        public function ZoneDialog(param1 = null, param2:String = null)
        {
            this._leftBmp = new Image();
            this._rightBmp = new Image();
            return;
        }// end function

        override protected function displayReady() : void
        {
            this._top = ToolKit.getNew("npc_dialog_up");
            this._top.height = this._top.height + 100;
            this._bottom = ToolKit.getNew("npc_dialog_down");
            this._nameTxt = this._bottom.getChildByName("txt_name") as TextField;
            this._contentTxt = this._bottom.getChildByName("content") as TextField;
            this._complete = true;
            this._beginShowDoor(this._needToUp);
            return;
        }// end function

        private function load() : void
        {
            loadDisplay("res/zonedialog.swf");
            return;
        }// end function

        public function beginShow(param1:Object, param2:Boolean = true) : void
        {
            this._info = param1;
            this._needToUp = param2;
            if (this._complete)
            {
                this._beginShowDoor(param2);
            }
            else
            {
                this.load();
            }
            return;
        }// end function

        private function _beginShowDoor(param1:Boolean) : void
        {
            this.inTween = true;
            this._bottom.bg.width = FrameworkGlobal.stageW;
            this._top.width = FrameworkGlobal.stageW;
            this._contentTxt.htmlText = this._info.content;
            this._contentTxt.x = this._bottom.bg.width - this._contentTxt.width >> 1;
            this._nameTxt.x = this._contentTxt.x;
            this._leftBmp.x = 40;
            this._bottom.addChild(this._leftBmp);
            this._bottom.addChild(this._rightBmp);
            this._top.y = -this._top.height;
            this._bottom.y = FrameworkGlobal.stageH;
            this._nameTxt.text = "";
            addChildAt(this._top, 0);
            addChildAt(this._bottom, 0);
            this.startTime = getTimer();
            if (!this._needToUp)
            {
                this._leftBmp.load(this._info.left, this.leftComplete);
            }
            if (this._needToUp)
            {
                TweenLite.to(this._top, 0.5, {y:0});
                TweenLite.to(this._bottom, 0.5, {y:FrameworkGlobal.stageH - this._bottom.bg.height, onComplete:this.onShow});
            }
            else
            {
                this._top.y = 0;
                this._bottom.y = FrameworkGlobal.stageH - this._bottom.bg.height;
                this.onShow();
            }
            if (this._info.left)
            {
                this._leftBmp.load(this._info.left, this.leftComplete);
                if (param1)
                {
                    this._leftBmp.alpha = 0;
                    TweenLite.to(this._leftBmp, 0.4, {alpha:1});
                }
                else
                {
                    this._leftBmp.alpha = 1;
                }
            }
            if (this._info.right)
            {
                this._rightBmp.load(this._info.right, this.rightComplete);
                if (param1)
                {
                    this._rightBmp.alpha = 0;
                    TweenLite.to(this._rightBmp, 0.4, {alpha:1});
                }
                else
                {
                    this._leftBmp.alpha = 1;
                }
            }
            FrameworkGlobal.stage.addEventListener(Event.RESIZE, this.__resize);
            return;
        }// end function

        private function __resize(event:Event) : void
        {
            var _loc_2:* = 0;
            this._contentTxt.x = this._bottom.bg.width - this._contentTxt.width >> 1;
            this._nameTxt.x = this._contentTxt.x;
            this._rightBmp.x = this._contentTxt.x + this._contentTxt.width + 5;
            this._bottom.bg.width = FrameworkGlobal.stageW;
            this._top.width = FrameworkGlobal.stageW;
            if (!this.inTween)
            {
                this._top.y = 0;
                this._bottom.y = FrameworkGlobal.stageH - this._bottom.bg.height;
            }
            else
            {
                _loc_2 = getTimer();
                this._rightBmp.x = FrameworkGlobal.stageW - this._rightBmp.width - 40;
                if (_loc_2 - this.startTime < 500)
                {
                    TweenLite.killTweensOf(this._top);
                    TweenLite.killTweensOf(this._bottom);
                    TweenLite.to(this._top, 0.5 - (_loc_2 - this.startTime), {y:0});
                    TweenLite.to(this._bottom, 0.5 - (_loc_2 - this.startTime), {y:FrameworkGlobal.stageH - this._bottom.bg.height, onComplete:this.onShow});
                }
            }
            return;
        }// end function

        private function leftComplete(param1:BitmapData) : void
        {
            this._leftBmp.y = this._bottom.bg.height - this._leftBmp.height;
            return;
        }// end function

        private function rightComplete(param1:BitmapData) : void
        {
            this._rightBmp.x = this._contentTxt.x + this._contentTxt.width + 5;
            this._rightBmp.y = this._bottom.bg.height - this._rightBmp.height;
            return;
        }// end function

        private function onShow() : void
        {
            this.inTween = false;
            this._nameTxt.text = this._info.name + "：";
            this._contentTxt.text = this._info.content;
            if (this._auto)
            {
                TweenLite.delayedCall(3, this.end);
            }
            return;
        }// end function

        public function end() : void
        {
            this._nameTxt.text = "";
            this._contentTxt.text = "";
            this._leftBmp.dispose();
            this._rightBmp.dispose();
            TweenLite.to(this._top, 0.5, {y:-this._top.height});
            TweenLite.to(this._bottom, 0.5, {y:FrameworkGlobal.stageH, onComplete:this.onShowComplete});
            return;
        }// end function

        private function onShowComplete() : void
        {
            if (parent)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

    }
}
