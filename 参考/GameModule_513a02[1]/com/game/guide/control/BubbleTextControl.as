package com.game.guide.control
{
    import com.f1.*;
    import com.f1.ui.events.*;
    import com.game.guide.view.*;
    import com.greensock.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class BubbleTextControl extends Object
    {
        private var _curBubbleText:BubbleTextView;
        private var _visible:Boolean;
        private var curTarget:DisplayObject;
        private const OFFSET_X:int = -190;
        private const OFFSET_Y:int = -5;
        private const TASK_TRANSFOR_TEXT:String;
        private var lastCheckTime:Number;
        private var preTargetX:Number;
        private var preTargetY:Number;
        private var preCloseTaskId:int;
        private var preClosetComplete:Boolean;
        private var _curTaskId:int;
        private var _isComplete:Boolean;
        private static var _instance:BubbleTextControl;

        public function BubbleTextControl()
        {
            this.TASK_TRANSFOR_TEXT = LanguageCfgObj.getInstance().getByIndex("10719");
            return;
        }// end function

        public function showBubbleText(param1:DisplayObject, param2:int, param3:Boolean, param4:Boolean = false) : void
        {
            var _loc_5:* = null;
            if (!this._curBubbleText)
            {
                this._curBubbleText = new BubbleTextView();
            }
            if (!param4)
            {
                if (this.preCloseTaskId == param2 && this.preClosetComplete == param3)
                {
                    return;
                }
                if (Params.EXP_VIP_GUIDE_TASK.indexOf(String(param2)) == -1)
                {
                    this.closeBubbleText();
                    return;
                }
            }
            if (param1.parent)
            {
                this._isComplete = param3;
                this._curTaskId = param2;
                this.curTarget = param1;
                _loc_5 = param1.parent.localToGlobal(new Point(param1.x, param1.y));
                this._curBubbleText.x = (param1.width >> 1) + _loc_5.x + this.OFFSET_X;
                this._curBubbleText.y = param1.height + _loc_5.y + this.OFFSET_Y;
                FrameworkGlobal.stage.addChild(this._curBubbleText);
                this._curBubbleText.open();
                this._curBubbleText.addEventListener(BoxEvent.SHOW_HIDE, this._clickClose);
                var _loc_6:* = 0;
                this.preTargetY = 0;
                this.preTargetX = _loc_6;
                this.lastCheckTime = getTimer();
                if (this._curBubbleText.x == this._curBubbleText.y && this._curBubbleText.x == 0)
                {
                    this.setBubbleTextVisible(false);
                }
                else
                {
                    this.setBubbleTextVisible(true);
                }
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            return;
        }// end function

        private function _clickClose(event:BoxEvent) : void
        {
            if (event.showOrHide == 1)
            {
                this.closeBubbleText();
            }
            return;
        }// end function

        public function closeBubbleText() : void
        {
            if (this._curBubbleText && this._curBubbleText.parent)
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
                this._curBubbleText.parent.removeChild(this._curBubbleText);
                this.preCloseTaskId = this._curTaskId;
                this._curTaskId = 0;
                this.preClosetComplete = this._isComplete;
                FrameworkGlobal.stage.focus = FrameworkGlobal.stage;
                this._curBubbleText.close();
                TweenLite.killDelayedCallsTo(this.delayClick);
                this.curTarget = null;
            }
            return;
        }// end function

        public function setBubbleTextVisible(param1:Boolean) : void
        {
            this._visible = param1;
            if (this._curBubbleText)
            {
                this._curBubbleText.visible = param1;
            }
            if (this._visible && this.curTarget)
            {
                TweenLite.killDelayedCallsTo(this.delayClick);
                TweenLite.delayedCall(60, this.delayClick);
            }
            else
            {
                TweenLite.killDelayedCallsTo(this.delayClick);
            }
            return;
        }// end function

        private function delayClick() : void
        {
            if (this.curTarget)
            {
                this.curTarget.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            }
            return;
        }// end function

        private function enterFrame(event:Event) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this.lastCheckTime >= 100)
            {
                this.lastCheckTime = _loc_2;
                this.adjustPos();
            }
            return;
        }// end function

        private function adjustPos() : void
        {
            var _loc_1:* = this.curTarget.parent.localToGlobal(new Point(this.curTarget.x, this.curTarget.y));
            if (this._curBubbleText.x == this._curBubbleText.y && this._curBubbleText.x == 0)
            {
                this.setBubbleTextVisible(false);
            }
            else if (this._curBubbleText.visible != this._visible)
            {
                this.setBubbleTextVisible(this._visible);
            }
            if (this.preTargetX == _loc_1.x && this.preTargetY == _loc_1.y)
            {
                return;
            }
            this.preTargetX = _loc_1.x;
            this.preTargetY = _loc_1.y;
            var _loc_2:* = this.curTarget.parent.localToGlobal(new Point(this.curTarget.x, this.curTarget.y));
            this._curBubbleText.x = (this.curTarget.width >> 1) + _loc_2.x + this.OFFSET_X;
            this._curBubbleText.y = this.curTarget.height + _loc_2.y + this.OFFSET_Y;
            return;
        }// end function

        public static function getInstance() : BubbleTextControl
        {
            var _loc_1:* = new BubbleTextControl;
            _instance = new BubbleTextControl;
            return _instance || _loc_1;
        }// end function

    }
}
