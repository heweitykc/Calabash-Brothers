package com.game.guide.view
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.events.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class BubbleTextView extends BaseSprite
    {
        private var speakDialog:TextField;
        private var _bg:Sprite;
        private var _closeBtn:BaseButton;
        private var _fireEffect:VMCView;
        private var effectContainer:Sprite;

        public function BubbleTextView()
        {
            this._bg = ToolKit.getNew("guide_bg_1");
            this._closeBtn = new BaseButton(this._bg["close_btn"]);
            addChild(this._bg);
            this._closeBtn.addEventListener(MouseEvent.CLICK, this._close);
            this._fireEffect = new VMCView();
            this._fireEffect.loadRes("res/effect/focus.png", null, true);
            this._fireEffect.updatePose("90");
            this.effectContainer = new Sprite();
            var _loc_1:* = false;
            this.effectContainer.mouseEnabled = false;
            this.effectContainer.mouseChildren = _loc_1;
            this.effectContainer.addChild(this._fireEffect);
            FrameworkGlobal.stage.addChild(this.effectContainer);
            return;
        }// end function

        public function setBubbleText(param1:String) : void
        {
            this.speakDialog.htmlText = param1;
            this.layout();
            return;
        }// end function

        public function dispose() : void
        {
            this.speakDialog.filters = [];
            removeChild(this.speakDialog);
            this.speakDialog = null;
            this.effectContainer.removeChild(this._fireEffect);
            if (FrameworkGlobal.stage.contains(this.effectContainer))
            {
                FrameworkGlobal.stage.removeChild(this.effectContainer);
            }
            this._fireEffect.finalize();
            this._fireEffect = null;
            this.effectContainer = null;
            return;
        }// end function

        public function close() : void
        {
            this._close();
            return;
        }// end function

        public function open() : void
        {
            if (visible)
            {
                this.setEffectAuto(true);
            }
            return;
        }// end function

        private function _close(event:MouseEvent = null) : void
        {
            this.setEffectAuto(false);
            if (FrameworkGlobal.stage.contains(this.effectContainer))
            {
                FrameworkGlobal.stage.removeChild(this.effectContainer);
            }
            dispatchEvent(new BoxEvent(BoxEvent.SHOW_HIDE, 1));
            return;
        }// end function

        private function layout() : void
        {
            this._closeBtn.x = this.speakDialog.x + this.speakDialog.width + 8;
            this._bg.width = this._closeBtn.x + this._closeBtn.width + 2;
            this._bg.height = this.speakDialog.y + this.speakDialog.height + 2;
            return;
        }// end function

        private function effectComplete(event:Event) : void
        {
            TweenLite.killDelayedCallsTo(this.repeatEffect);
            TweenLite.delayedCall(0.2, this.repeatEffect);
            return;
        }// end function

        private function setEffectAuto(param1:Boolean) : void
        {
            if (this._fireEffect)
            {
                if (param1)
                {
                    this._fireEffect.auto = true;
                    this._fireEffect.play();
                    this.effectContainer.x = x - 30;
                    this.effectContainer.y = y;
                    this._fireEffect.addEventListener(Event.COMPLETE, this.effectComplete);
                }
                else
                {
                    this._fireEffect.auto = false;
                    this._fireEffect.stop();
                    TweenLite.killDelayedCallsTo(this.repeatEffect);
                }
            }
            return;
        }// end function

        private function repeatEffect() : void
        {
            this._fireEffect.updatePose("90");
            this._fireEffect.auto = true;
            this.effectContainer.x = x - 30;
            this.effectContainer.y = y;
            FrameworkGlobal.stage.addChild(this.effectContainer);
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            if (this._fireEffect)
            {
                if (param1 && parent)
                {
                    FrameworkGlobal.stage.addChild(this.effectContainer);
                    this.setEffectAuto(true);
                }
                else if (FrameworkGlobal.stage.contains(this.effectContainer))
                {
                    FrameworkGlobal.stage.removeChild(this.effectContainer);
                    this.setEffectAuto(false);
                }
            }
            super.visible = param1;
            return;
        }// end function

    }
}
