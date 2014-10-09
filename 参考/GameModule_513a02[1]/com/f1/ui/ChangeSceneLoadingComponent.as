package com.f1.ui
{
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.ui.image.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;

    public class ChangeSceneLoadingComponent extends Component
    {
        private var _top:MovieClip;
        private var _bottom:MovieClip;
        private var _logo:MovieClip;
        private var _effect:MovieClip;
        private var _progress:Bitmap;
        private var _mapName:Image;
        private var _isBeginShowProgress:Boolean;
        private var _isLoadBeginShow:Boolean;
        private var _isShowingBegin:Boolean;
        private var _progressHeight:int;
        public var isOpen:Boolean;
        private var _percent:Number = 0;
        private var _mapId:int;
        private var thisStageW:Number;
        private var thisStageH:Number;

        public function ChangeSceneLoadingComponent()
        {
            loadDisplay("res/enterzoneeffect.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            this._top = ToolKit.getNew("top_door");
            this._bottom = ToolKit.getNew("bottom_door");
            this._effect = ToolKit.getNew("black_effect");
            this._logo = ToolKit.getNew("centre_logo");
            this._progress = new Bitmap(ToolKit.getNew("progress_effect"));
            this._progress.smoothing = true;
            this._progressHeight = this._progress.height;
            this._mapName = new Image();
            this._mapName.move(50, 349);
            this._logo.addChild(this._mapName);
            if (this._isLoadBeginShow)
            {
                this.beginShow(this._mapId);
            }
            super.displayReady();
            return;
        }// end function

        public function beginShow(param1:int) : void
        {
            this._mapId = param1;
            this.isOpen = true;
            if (UILoaded)
            {
                this.thisStageW = FrameworkGlobal.stageW;
                this.thisStageH = FrameworkGlobal.stageH;
                this._mapName.load("art/res/changsceneeffect/" + param1 + ".png");
                this._isShowingBegin = true;
                this._effect.width = this.thisStageW;
                this._effect.height = this.thisStageH;
                this._effect.alpha = 0;
                addChild(this._effect);
                TweenLite.to(this._effect, 0.3, {alpha:1});
                TweenLite.delayedCall(0.2, this._beginShowDoor);
            }
            else
            {
                this._isLoadBeginShow = true;
            }
            return;
        }// end function

        private function _beginShowDoor() : void
        {
            this._top.bg.width = this.thisStageW;
            this._top.bg.height = (this.thisStageH >> 1) + 27;
            this._top.item_1.x = this.thisStageW - this._top.item_1.width >> 1;
            this._top.item_1.y = this._top.bg.height - this._top.item_1.height;
            this._top.item_2.x = this.thisStageW - this._top.item_2.width >> 1;
            this._top.item_2.y = this._top.bg.height - 105;
            this._bottom.bg.width = this.thisStageW;
            this._bottom.bg.height = (this.thisStageH >> 1) + 27;
            this._bottom.item_1.x = this.thisStageW - this._top.item_1.width >> 1;
            this._bottom.item_2.x = this.thisStageW - this._top.item_2.width >> 1;
            this._top.y = -this.thisStageH;
            this._bottom.y = this.thisStageH;
            addChildAt(this._top, 0);
            addChildAt(this._bottom, 0);
            TweenLite.to(this._top, 0.1, {y:0});
            TweenLite.to(this._bottom, 0.1, {y:this.thisStageH - this._bottom.height});
            TweenLite.delayedCall(0.4, this._beginShowLogo);
            return;
        }// end function

        private function _beginShowLogo() : void
        {
            var _loc_3:* = this.thisStageW - this._logo.width * 0.7 >> 1;
            this._logo.x = this.thisStageW - this._logo.width * 0.7 >> 1;
            var _loc_1:* = _loc_3;
            var _loc_3:* = this.thisStageH - this._logo.height * 0.7 >> 1;
            this._logo.y = this.thisStageH - this._logo.height * 0.7 >> 1;
            var _loc_2:* = _loc_3;
            this._logo.alpha = 0;
            var _loc_3:* = 1.5;
            this._logo.scaleY = 1.5;
            this._logo.scaleX = _loc_3;
            this._logo.x = this.thisStageW - this._logo.width >> 1;
            this._logo.y = this.thisStageH - this._logo.height >> 1;
            addChild(this._logo);
            TweenLite.to(this._logo, 0.15, {x:_loc_1, y:_loc_2, scaleX:0.7, scaleY:0.7, alpha:0.7, onComplete:this._logoShake});
            return;
        }// end function

        private function _logoShake() : void
        {
            var _loc_3:* = 1;
            this._logo.scaleY = 1;
            this._logo.scaleX = _loc_3;
            var _loc_1:* = this.thisStageW - this._logo.width >> 1;
            var _loc_2:* = this.thisStageH - this._logo.height >> 1;
            var _loc_3:* = 0.7;
            this._logo.scaleY = 0.7;
            this._logo.scaleX = _loc_3;
            this._logo.x = this.thisStageW - this._logo.width >> 1;
            this._logo.y = this.thisStageH - this._logo.height >> 1;
            TweenLite.to(this._logo, 0.03, {x:_loc_1, y:_loc_2, scaleX:1, scaleY:1, alpha:1, onComplete:this._logoShowComplete});
            return;
        }// end function

        private function _logoShowComplete() : void
        {
            this._isBeginShowProgress = true;
            this._isShowingBegin = false;
            if (this._percent >= 1)
            {
                this.endShow();
            }
            return;
        }// end function

        public function endShow() : void
        {
            if (UILoaded && !this._isShowingBegin)
            {
                this.isOpen = false;
                this._setProgress(1);
                TweenLite.delayedCall(0.5, this._beginZoomProgress);
            }
            else
            {
                this._percent = 1;
            }
            return;
        }// end function

        public function close() : void
        {
            this._isLoadBeginShow = false;
            if (this._effect)
            {
                TweenLite.killTweensOf(this._effect);
            }
            TweenLite.killDelayedCallsTo(this._beginShowDoor);
            if (this._top)
            {
                TweenLite.killTweensOf(this._top);
            }
            if (this._bottom)
            {
                TweenLite.killTweensOf(this._bottom);
            }
            TweenLite.killDelayedCallsTo(this._beginShowLogo);
            if (this._logo)
            {
                TweenLite.killTweensOf(this._logo);
            }
            if (this._progress)
            {
                TweenLite.killTweensOf(this._logo);
            }
            this._isShowingBegin = false;
            TweenLite.killDelayedCallsTo(this._beginZoomProgress);
            this._allFinish();
            return;
        }// end function

        private function _beginZoomProgress() : void
        {
            TweenLite.to(this._progress, 0.3, {height:0, y:this.thisStageH >> 1});
            TweenLite.to(this._effect, 0.3, {alpha:0, onComplete:this._beginHideDoor});
            return;
        }// end function

        private function _beginHideDoor() : void
        {
            TweenLite.to(this._top, 0.7, {y:-this.thisStageH});
            TweenLite.to(this._bottom, 0.7, {y:this.thisStageH});
            this._beginHideLogo();
            return;
        }// end function

        private function _beginHideLogo() : void
        {
            TweenLite.to(this._logo, 0.6, {alpha:0, onComplete:this._allFinish});
            return;
        }// end function

        private function _allFinish() : void
        {
            if (parent)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        public function setProgress(event:ProgressEvent, param2:VResLoadObj) : void
        {
            if (!UILoaded || !this._isShowingBegin)
            {
                return;
            }
            var _loc_3:* = event.bytesLoaded;
            var _loc_4:* = event.bytesTotal;
            if (param2.groupInfo)
            {
                _loc_4 = param2.groupInfo.totalSize;
                _loc_3 = param2.groupInfo.loadedSize;
            }
            var _loc_5:* = _loc_3 / _loc_4;
            this._setProgress(_loc_5);
            return;
        }// end function

        private function _setProgress(param1:Number) : void
        {
            var _loc_2:* = getChildIndex(this._effect);
            if (_loc_2 == -1)
            {
                _loc_2 = getChildIndex(this._logo);
            }
            addChildAt(this._progress, _loc_2);
            this._progress.height = this._progressHeight;
            this._progress.x = -80;
            this._progress.y = this.thisStageH - this._progressHeight >> 1;
            if (param1 == 1)
            {
                this._progress.width = this.thisStageW;
            }
            else
            {
                TweenLite.killTweensOf(this._progress);
                TweenLite.to(this._progress, 0.1, {width:this.thisStageW * param1});
            }
            return;
        }// end function

    }
}
