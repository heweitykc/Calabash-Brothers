package com.game.zones.view.wolfsoul
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;

    public class ZonesWolfHintView extends Component
    {
        private var _sneakView:MovieClip;
        private var _hitView:MovieClip;
        private var _widiView:MovieClip;
        private var _roundView:MovieClip;
        private var _roundNum:MovieClip;
        private var _isNeedShowHit:Boolean;
        private var _curRound:int;
        private var showType:int;

        public function ZonesWolfHintView()
        {
            super(null, null);
            loadDisplay("res/zoneswolfsoulhint.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._widiView = ToolKit.getNew("wolf_wudi");
            this._hitView = ToolKit.getNew("wolf_hit");
            this._sneakView = ToolKit.getNew("wolf_sneak");
            this._roundView = ToolKit.getNew("wolf_round");
            this._roundNum = ToolKit.getNew("wolf_num");
            this._roundNum.x = 311;
            this._roundNum.y = 7;
            if (this._isNeedShowHit)
            {
                this.showHit();
            }
            switch(this.showType)
            {
                case 1:
                {
                    this.showSneak();
                    break;
                }
                case 2:
                {
                    this.showWudi();
                    break;
                }
                case 3:
                {
                    this.showRound(this._curRound);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.showType = 0;
            return;
        }// end function

        public function showHit() : void
        {
            if (UILoaded)
            {
                this._isNeedShowHit = false;
                this.removeHitShow();
                this._hitView.x = FrameworkGlobal.stageW - this._hitView.width >> 1;
                this._hitView.y = FrameworkGlobal.stageH - 260;
                FrameworkGlobal.stage.addChild(this._hitView);
                TweenLite.delayedCall(3, this.removeHitShow);
            }
            else
            {
                this._isNeedShowHit = true;
            }
            return;
        }// end function

        public function showRound(param1:int) : void
        {
            if (UILoaded)
            {
                this._curRound = 0;
                this.removeShow();
                this._roundNum.gotoAndStop((param1 + 1));
                this._roundView.x = FrameworkGlobal.stageW - this._roundView.width >> 1;
                this._roundView.y = 150;
                this._roundView.play();
                if (this._roundView.contains(this._roundNum))
                {
                    this._roundView.removeChild(this._roundNum);
                }
                this._roundView.addEventListener(Event.ENTER_FRAME, this.roundEnterFrame);
                FrameworkGlobal.stage.addChild(this._roundView);
                TweenLite.delayedCall(8, this.removeShow);
            }
            else
            {
                this._curRound = param1;
                this.showType = 3;
            }
            return;
        }// end function

        private function roundEnterFrame(event:Event) : void
        {
            if (this._roundView.currentFrame >= 14)
            {
                this._roundView.addChild(this._roundNum);
            }
            if (this._roundView.currentFrame >= 14 && this._roundView.currentFrame < 18)
            {
                this._roundNum.alpha = (this._roundView.currentFrame - 14) * 0.25;
            }
            return;
        }// end function

        public function showSneak() : void
        {
            if (UILoaded)
            {
                this.removeShow();
                this._sneakView.x = FrameworkGlobal.stageW - this._sneakView.width >> 1;
                this._sneakView.y = 150;
                FrameworkGlobal.stage.addChild(this._sneakView);
                this._sneakView.play();
                TweenLite.delayedCall(8, this.removeShow);
            }
            else
            {
                this.showType = 1;
            }
            return;
        }// end function

        public function showWudi() : void
        {
            if (UILoaded)
            {
                this.removeShow();
                this._widiView.x = FrameworkGlobal.stageW - this._widiView.width >> 1;
                this._widiView.y = 150;
                FrameworkGlobal.stage.addChild(this._widiView);
                this._widiView.play();
                TweenLite.delayedCall(8, this.removeShow);
            }
            else
            {
                this.showType = 2;
            }
            return;
        }// end function

        public function removeShow() : void
        {
            if (!UILoaded)
            {
                return;
            }
            TweenLite.killDelayedCallsTo(this.removeShow);
            if (this._widiView.parent)
            {
                this._widiView.stop();
                this._widiView.parent.removeChild(this._widiView);
            }
            if (this._sneakView.parent)
            {
                this._sneakView.stop();
                this._sneakView.parent.removeChild(this._sneakView);
            }
            if (this._roundView.parent)
            {
                this._roundView.stop();
                this._roundView.removeEventListener(Event.ENTER_FRAME, this.roundEnterFrame);
                this._roundView.parent.removeChild(this._roundView);
            }
            return;
        }// end function

        public function removeHitShow() : void
        {
            if (!UILoaded)
            {
                return;
            }
            if (this._hitView.parent)
            {
                TweenLite.killDelayedCallsTo(this.removeHitShow);
                this._hitView.parent.removeChild(this._hitView);
            }
            return;
        }// end function

    }
}
