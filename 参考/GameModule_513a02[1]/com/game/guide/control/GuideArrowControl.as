package com.game.guide.control
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import com.game.map.view.topbtnspanel.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class GuideArrowControl extends Object
    {
        private var curGuideObj:Object;
        private var loaded:Boolean;
        private var isLoading:Boolean;
        private var lastCheckTime:Number;
        private var curDir:String;
        private var preTargetX:Number;
        private var preTargetY:Number;
        private var isHide:Boolean;
        private const RES_URL:String = "res/guidearrow.swf";
        private const LEFT_NAME:String = "angel_left";
        private const TOP_NAME:String = "angel_top";
        private const DOWN_NAME:String = "angel_down";
        private const RIGHT_NAME:String = "angel_right";
        private const TALK_CONTENT_LEFT:String = "talk_content_left";
        private const TALK_CONTENT_RIGHT:String = "talk_content_right";
        private const TALK_CONTENT_TOP:String = "talk_content_top";
        private const LEFT_X_OFFSET:int = -207;
        private const LEFT_Y_OFFSET:int = -242;
        private const RIGHT_X_OFFSET:int = 31;
        private const RIGHT_Y_OFFSET:int = -242;
        private const UP_X_OFFSET:int = -148;
        private const UP_Y_OFFSET:int = -293;
        private const DOWN_X_OFFSET:int = 0;
        private const DOWN_Y_OFFSET:int = 0;
        private const TXT_LEFT_X_OFFSET:int = -35;
        private const TXT_LEFT_Y_OFFSET:int = 212;
        private const TXT_RIGHT_X_OFFSET:int = -31;
        private const TXT_RIGHT_Y_OFFSET:int = 212;
        private const TXT_UP_X_OFFSET:int = -17;
        private const TXT_UP_Y_OFFSET:int = 214;
        private const TXT_DOWN_X_OFFSET:int = 0;
        private const TXT_DOWN_Y_OFFSET:int = 0;
        private const LEFT:String = "2";
        private const RIGHT:String = "3";
        private const TOP:String = "0";
        private const DOWN:String = "1";
        private const SHOW_HIDE_TALK_TIME:Number = 0.3;
        private var leftAngel:MovieClip;
        private var rightAngel:MovieClip;
        private var topAngel:MovieClip;
        private var downAngel:MovieClip;
        private var curTarget:DisplayObject;
        private var curAngel:MovieClip;
        private var curTalkContent:MovieClip;
        private var talkLeftContent:MovieClip;
        private var talkRightContent:MovieClip;
        private var talkTopContent:MovieClip;
        private var mask:Shape;
        private var talkContainer:Sprite;

        public function GuideArrowControl()
        {
            return;
        }// end function

        public function addArrow(param1:DisplayObject, param2:String) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            if (!this.loaded)
            {
                this.curTarget = param1;
                this.curGuideObj = TaskCfgObj.getInstance().getGuideConfig(param2);
                this.initAngel();
                return;
            }
            if (this.curGuideObj && param2 == this.curGuideObj.q_id && this.curAngel && this.curAngel.visible)
            {
                return;
            }
            if (this.curTarget && this.curTarget.parent && this.curAngel && this.curAngel.parent)
            {
                _loc_3 = this.curAngel.parent.localToGlobal(new Point(this.curAngel.x, this.curAngel.y));
            }
            if (this.curTarget)
            {
                ButtonFlickerControl.getInstance().removeButtonFlicker(this.curTarget);
            }
            this.curTarget = param1;
            this.curGuideObj = TaskCfgObj.getInstance().getGuideConfig(param2);
            ButtonFlickerControl.getInstance().addButtonFlicker(this.curTarget);
            var _loc_7:* = this.getTargetHeight();
            switch(this.curGuideObj.q_dir)
            {
                case this.TOP:
                {
                    _loc_4 = param1.x + (param1.width >> 1) + this.UP_X_OFFSET;
                    _loc_5 = param1.y + this.UP_Y_OFFSET;
                    break;
                }
                case this.DOWN:
                {
                    _loc_4 = param1.x + (param1.width >> 1) + this.DOWN_X_OFFSET;
                    _loc_5 = param1.y + _loc_7 + this.DOWN_Y_OFFSET;
                    break;
                }
                case this.LEFT:
                {
                    _loc_4 = param1.x + this.LEFT_X_OFFSET;
                    _loc_5 = param1.y + (_loc_7 >> 1) + this.LEFT_Y_OFFSET;
                    break;
                }
                case this.RIGHT:
                {
                    _loc_4 = param1.x + param1.width + this.RIGHT_X_OFFSET;
                    _loc_5 = param1.y + (_loc_7 >> 1) + this.RIGHT_Y_OFFSET;
                    break;
                }
                default:
                {
                    break;
                }
            }
            _loc_6 = param1.parent.localToGlobal(new Point(_loc_4, _loc_5));
            if (_loc_3 && (_loc_3.x != _loc_6.x || _loc_3.y != _loc_6.y))
            {
                this.arrowFlyToPos(_loc_3, _loc_6);
            }
            else
            {
                this.arrowFlyComplete();
            }
            return;
        }// end function

        public function removeArrow(param1:DisplayObject) : void
        {
            if (this.curTarget == param1)
            {
                this.removeCurArrow();
            }
            ButtonFlickerControl.getInstance().removeButtonFlicker(param1);
            return;
        }// end function

        public function hideArrow() : void
        {
            this.isHide = true;
            if (this.curAngel)
            {
                if (!this.hideTalkContent(this.hideArrowComplete))
                {
                    this.hideArrowComplete();
                }
            }
            return;
        }// end function

        public function unHideArrow() : void
        {
            this.isHide = false;
            if (this.curAngel && this.curAngel.visible == false)
            {
                this.enableAdjust(true);
                this.curAngel.visible = true;
                this.arrowFlyComplete();
                ButtonFlickerControl.getInstance().addButtonFlicker(this.curTarget);
            }
            return;
        }// end function

        private function hideArrowComplete() : void
        {
            this.enableAdjust(false);
            if (this.curAngel)
            {
                this.curAngel.visible = false;
            }
            ButtonFlickerControl.getInstance().removeButtonFlicker(this.curTarget);
            return;
        }// end function

        public function hasArrow(param1:DisplayObject) : Boolean
        {
            return param1.parent && param1.parent.contains(this.curAngel);
        }// end function

        private function initAngel() : void
        {
            if (this.isLoading)
            {
                return;
            }
            VResManager.load(this.RES_URL, this.loadDisplayComplete);
            return;
        }// end function

        private function loadDisplayComplete(param1 = null) : void
        {
            this.loaded = true;
            this.leftAngel = new MovieClip();
            this.topAngel = new MovieClip();
            this.rightAngel = new MovieClip();
            this.talkLeftContent = ToolKit.getNew(this.TALK_CONTENT_LEFT);
            this.talkRightContent = ToolKit.getNew(this.TALK_CONTENT_RIGHT);
            this.talkTopContent = ToolKit.getNew(this.TALK_CONTENT_TOP);
            this.mask = new Shape();
            this.mask.graphics.beginFill(0, 0);
            this.mask.graphics.drawRect(0, 0, 1, 1);
            this.talkContainer = new Sprite();
            var _loc_2:* = false;
            this.talkContainer.mouseEnabled = false;
            this.talkContainer.mouseChildren = _loc_2;
            if (this.curTarget && this.curGuideObj && !this.isHide)
            {
                this.addArrow(this.curTarget, this.curGuideObj.q_id);
            }
            return;
        }// end function

        private function hideTalkContent(param1:Function = null, param2:Array = null) : Boolean
        {
            if (this.curTalkContent && this.curTalkContent.parent && this.mask.width > 0)
            {
                this.mask.x = this.curTalkContent.x;
                this.mask.y = this.curTalkContent.y;
                this.mask.height = this.curTalkContent.height;
                this.mask.width = this.curTalkContent.width;
                this.curTalkContent.parent.addChild(this.mask);
                this.curTalkContent.mask = this.mask;
                TweenLite.to(this.mask, this.SHOW_HIDE_TALK_TIME, {width:0, onComplete:param1, onCompleteParams:param2});
                this.enableAdjust(false);
                return true;
            }
            return false;
        }// end function

        private function arrowFlyToPos(param1:Point, param2:Point) : void
        {
            if (!this.hideTalkContent(this.arrowBeginMove, [param1, param2]))
            {
                this.arrowBeginMove(param1, param2);
            }
            return;
        }// end function

        private function arrowBeginMove(param1:Point, param2:Point) : void
        {
            this.removeCurArrow();
            if (param1.x > param2.x)
            {
                this.setCurAngel(this.RIGHT);
            }
            else
            {
                this.setCurAngel(this.LEFT);
            }
            this.curAngel.x = param1.x;
            this.curAngel.y = param1.y;
            this.curAngel.alpha = 1;
            FrameworkGlobal.stage.addChild(this.curAngel);
            var _loc_3:* = new Point(0, 0);
            _loc_3.x = Math.abs(param2.x - param1.x) >> 1;
            _loc_3.y = Math.abs(param2.y - param1.y) >> 1 + 100;
            _loc_3.x = _loc_3.x + (param2.x > param1.x ? (param1.x) : (param2.x));
            _loc_3.y = _loc_3.y + (param2.y > param1.y ? (param1.y) : (param2.y));
            this.arrowFlyComplete();
            return;
        }// end function

        private function arrowFlyComplete() : void
        {
            if (this.curAngel)
            {
                TweenMax.killTweensOf(this.curAngel);
            }
            TweenLite.killTweensOf(this.mask);
            this.removeCurArrow();
            this.adjustPos();
            if (this.curTarget.parent)
            {
                if (this.curGuideObj.q_bubble_show == "0")
                {
                    this.curAngel.alpha = 0;
                }
                else
                {
                    this.curAngel.alpha = 1;
                }
                FrameworkGlobal.stage.addChild(this.talkContainer);
                FrameworkGlobal.stage.addChild(this.curAngel);
                this.setCurTalkContent(this.curDir);
                this.adjustTalkPos();
                this.talkContainer.addChild(this.curTalkContent);
                this.mask.x = this.curTalkContent.x;
                this.mask.y = this.curTalkContent.y;
                this.mask.height = this.curTalkContent.height;
                this.mask.width = 1;
                this.curTalkContent.parent.addChild(this.mask);
                this.curTalkContent.mask = this.mask;
                this.curTalkContent.des.htmlText = this.curGuideObj.q_content;
                TweenLite.to(this.mask, this.SHOW_HIDE_TALK_TIME, {width:this.curTalkContent.width, onComplete:this.showTalkContentComplete});
            }
            return;
        }// end function

        private function showTalkContentComplete() : void
        {
            this.lastCheckTime = getTimer();
            this.enableAdjust(true);
            return;
        }// end function

        private function removeCurArrow(param1:Boolean = false) : void
        {
            if (this.curAngel)
            {
                TweenMax.killTweensOf(this.curAngel);
                TweenLite.killTweensOf(this.mask);
                if (this.talkContainer && this.talkContainer.parent)
                {
                    this.curTalkContent.mask = null;
                    this.curTalkContent.parent.removeChild(this.curTalkContent);
                    if (this.mask.parent)
                    {
                        this.mask.parent.removeChild(this.mask);
                    }
                    this.talkContainer.parent.removeChild(this.talkContainer);
                }
                if (this.curAngel.parent)
                {
                    this.curAngel.parent.removeChild(this.curAngel);
                }
                this.curAngel.stop();
                this.curAngel = null;
                this.enableAdjust(false);
            }
            return;
        }// end function

        private function setCurAngel(param1:String) : void
        {
            this.curDir = param1;
            switch(param1)
            {
                case this.TOP:
                {
                    this.curAngel = this.topAngel;
                    break;
                }
                case this.DOWN:
                {
                    this.curAngel = this.downAngel;
                    break;
                }
                case this.LEFT:
                {
                    this.curAngel = this.leftAngel;
                    break;
                }
                case this.RIGHT:
                {
                    this.curAngel = this.rightAngel;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.curAngel.visible = true;
            this.curAngel.play();
            return;
        }// end function

        private function setCurTalkContent(param1:String) : void
        {
            if (this.curTalkContent && this.curTalkContent.parent)
            {
                this.curTalkContent.mask = null;
                this.curTalkContent.parent.removeChild(this.curTalkContent);
            }
            switch(param1)
            {
                case this.TOP:
                {
                    this.curTalkContent = this.talkTopContent;
                    break;
                }
                case this.DOWN:
                {
                    break;
                }
                case this.LEFT:
                {
                    this.curTalkContent = this.talkLeftContent;
                    break;
                }
                case this.RIGHT:
                {
                    this.curTalkContent = this.talkRightContent;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.talkContainer.addChild(this.curTalkContent);
            this.curTalkContent.visible = true;
            this.curTalkContent.play();
            var _loc_2:* = false;
            this.curTalkContent.mouseChildren = false;
            this.curTalkContent.mouseEnabled = _loc_2;
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
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_5:* = null;
            if (!this.curTarget || !this.curTarget.parent || !this.curGuideObj)
            {
                return;
            }
            var _loc_3:* = this.curTarget.parent.localToGlobal(new Point(this.curTarget.x, this.curTarget.y));
            if (this.preTargetX == _loc_3.x && this.preTargetY == _loc_3.y && this.curAngel)
            {
                return;
            }
            this.preTargetX = _loc_3.x;
            this.preTargetY = _loc_3.y;
            var _loc_4:* = this.getTargetHeight();
            switch(this.curGuideObj.q_dir)
            {
                case this.TOP:
                {
                    _loc_1 = this.curTarget.x + (this.curTarget.width >> 1) + this.UP_X_OFFSET;
                    _loc_2 = this.curTarget.y + this.UP_Y_OFFSET;
                    break;
                }
                case this.DOWN:
                {
                    _loc_1 = this.curTarget.x + (this.curTarget.width >> 1) + this.DOWN_X_OFFSET;
                    _loc_2 = this.curTarget.y + _loc_4 + this.DOWN_Y_OFFSET;
                    break;
                }
                case this.LEFT:
                {
                    _loc_1 = this.curTarget.x + this.LEFT_X_OFFSET;
                    _loc_2 = this.curTarget.y + (_loc_4 >> 1) + this.LEFT_Y_OFFSET;
                    break;
                }
                case this.RIGHT:
                {
                    _loc_1 = this.curTarget.x + this.curTarget.width + this.RIGHT_X_OFFSET;
                    _loc_2 = this.curTarget.y + (_loc_4 >> 1) + this.RIGHT_Y_OFFSET;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this.curTarget.parent)
            {
                this.setCurAngel(this.curGuideObj.q_dir);
                _loc_5 = this.curTarget.parent.localToGlobal(new Point(_loc_1, _loc_2));
                if (this.curAngel.x != _loc_5.x || this.curAngel.y != _loc_5.y)
                {
                    this.curAngel.x = _loc_5.x;
                    this.curAngel.y = _loc_5.y;
                }
                this.adjustTalkPos();
            }
            return;
        }// end function

        private function adjustTalkPos() : void
        {
            if (this.talkContainer.parent)
            {
                switch(this.curDir)
                {
                    case this.TOP:
                    {
                        this.talkContainer.x = this.TXT_UP_X_OFFSET + this.curAngel.x;
                        this.talkContainer.y = this.TXT_UP_Y_OFFSET + this.curAngel.y;
                        break;
                    }
                    case this.DOWN:
                    {
                        this.talkContainer.x = this.TXT_DOWN_X_OFFSET + this.curAngel.x;
                        this.talkContainer.y = this.TXT_DOWN_Y_OFFSET + this.curAngel.y;
                        break;
                    }
                    case this.LEFT:
                    {
                        this.talkContainer.x = this.TXT_LEFT_X_OFFSET + this.curAngel.x;
                        this.talkContainer.y = this.TXT_LEFT_Y_OFFSET + this.curAngel.y;
                        break;
                    }
                    case this.RIGHT:
                    {
                        this.talkContainer.x = this.TXT_RIGHT_X_OFFSET + this.curAngel.x;
                        this.talkContainer.y = this.TXT_RIGHT_Y_OFFSET + this.curAngel.y;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function enableAdjust(param1:Boolean) : void
        {
            if (param1)
            {
                FrameworkGlobal.stage.addEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            else
            {
                FrameworkGlobal.stage.removeEventListener(Event.ENTER_FRAME, this.enterFrame);
            }
            return;
        }// end function

        public function dispose() : void
        {
            this.enableAdjust(false);
            if (this.mask)
            {
                if (this.mask.parent)
                {
                    this.mask.parent.removeChild(this.mask);
                }
                this.mask = null;
            }
            this.disposeMC(this.curTalkContent);
            this.curTalkContent = null;
            if (this.talkContainer)
            {
                if (this.talkContainer.parent)
                {
                    this.talkContainer.parent.removeChild(this.talkContainer);
                }
                this.talkContainer = null;
            }
            this.disposeMC(this.curAngel);
            this.curAngel = null;
            this.disposeMC(this.leftAngel);
            this.leftAngel = null;
            this.disposeMC(this.topAngel);
            this.topAngel = null;
            this.disposeMC(this.downAngel);
            this.downAngel = null;
            this.disposeMC(this.talkLeftContent);
            this.downAngel = null;
            this.disposeMC(this.talkRightContent);
            this.downAngel = null;
            this.disposeMC(this.talkTopContent);
            this.downAngel = null;
            this.curTarget = null;
            return;
        }// end function

        private function disposeMC(param1:MovieClip) : void
        {
            if (param1)
            {
                if (param1.parent)
                {
                    param1.parent.removeChild(param1);
                }
                param1.stop();
                param1 = null;
            }
            return;
        }// end function

        private function getTargetHeight() : int
        {
            if (this.curTarget)
            {
                if (this.curTarget is TopActivateIcon)
                {
                    return 64;
                }
                return this.curTarget.height;
            }
            return 0;
        }// end function

    }
}
