package com.game.prenotice.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.image.*;
    import com.f1.ui.tips.*;
    import com.f1.vmc.*;
    import com.greensock.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class PrenoticeView extends Component
    {
        private var _showEffect:VMCView;
        private var _foldEffect:VMCView;
        private var _fold:VMCView;
        private var _mainView:MovieClip;
        private var _qWord:TextField;
        private var _qName:TextField;
        private var _img:Image;
        private var _imgContainer:Sprite;
        private var _foldContainer:Sprite;
        private var _showEffectCom:Boolean = false;
        private var _foldEffectCom:Boolean = false;
        private var _foldCom:Boolean = false;
        private var _isEffecting:Boolean = false;
        private var _isFold:Boolean = false;
        private var _config:Object;

        public function PrenoticeView()
        {
            setWH(300, 300);
            loadDisplay("res/prenotice.swf");
            this._showEffect = new VMCView();
            this._showEffect.move(57, 59);
            this._showEffect.loadRes("res/effect/prenoticeshow.png", null, true, this._loadShowComplete);
            return;
        }// end function

        public function showByCfg(param1:Object) : void
        {
            this.stopAllEffect();
            this._config = param1;
            if (this._config && this._showEffectCom && UILoaded)
            {
                this._qWord.htmlText = this._config.q_word;
                this._qName.htmlText = this._config.q_name;
                this._img.load(Params.ART_PATH + "forshow/" + this._config.q_icon + ".png");
                StringTip.create(this._imgContainer, this._config.q_tips);
                addEventListener(MouseEvent.CLICK, this._clickHandler);
                this.beginShow();
            }
            return;
        }// end function

        public function close() : void
        {
            this.stopAllEffect();
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("prenoticeView");
            this._img = new Image();
            this._img.move(30, 32);
            this._imgContainer = new Sprite();
            this._imgContainer.addChild(this._img);
            this._qWord = display.bgView.q_word;
            this._qName = display.bgView.q_name;
            display.bgView.addChild(this._imgContainer);
            this.showByCfg(this._config);
            return;
        }// end function

        private function _loadShowComplete() : void
        {
            this._showEffectCom = true;
            this.showByCfg(this._config);
            return;
        }// end function

        private function _loadFoldEffectComplete() : void
        {
            this._foldEffectCom = true;
            this.fold();
            return;
        }// end function

        private function _loadFoldComplete() : void
        {
            this._foldCom = true;
            this._foldContainer = new Sprite();
            this._foldContainer.addChild(this._fold);
            StringTip.create(this._foldContainer, LanguageCfgObj.getInstance().getByIndex("11027"));
            this.fold();
            return;
        }// end function

        private function beginShow() : void
        {
            if (this._fold)
            {
                this._foldContainer.visible = false;
            }
            display.visible = false;
            this._isEffecting = true;
            addChildAt(this._showEffect, 0);
            this._showEffect.auto = true;
            this._showEffect.updatePose("90", false);
            this._showEffect.addEventListener(Event.COMPLETE, this._showEffectComplete);
            TweenLite.delayedCall(0.8, this.showContent);
            return;
        }// end function

        private function _showEffectComplete(event:Event = null) : void
        {
            display.redView.visible = true;
            this._showEffect.removeEventListener(Event.COMPLETE, this._showEffectComplete);
            removeChild(this._showEffect);
            return;
        }// end function

        private function showContent() : void
        {
            display.visible = true;
            display.bgView.alpha = 0.2;
            display.redView.visible = false;
            TweenLite.to(display.bgView, 1, {alpha:1, onComplete:this.finishShow});
            return;
        }// end function

        private function _foldEffectComplete(event:Event = null) : void
        {
            this._foldEffect.removeEventListener(Event.COMPLETE, this._foldEffectComplete);
            removeChild(this._foldEffect);
            return;
        }// end function

        private function finishShow() : void
        {
            this._isEffecting = false;
            this._isFold = false;
            return;
        }// end function

        private function fold() : void
        {
            TweenLite.killDelayedCallsTo(this.fold);
            this._isEffecting = true;
            if (!this._fold)
            {
                this._fold = new VMCView();
                this._fold.loadRes("res/effect/prenoticeball.png", null, true, this._loadFoldComplete);
                this._fold.move(60, 65);
                this._foldEffect = new VMCView();
                this._foldEffect.move(70, 60);
                this._foldEffect.loadRes("res/effect/prenoticehide.png", null, true, this._loadFoldEffectComplete);
            }
            if (this._foldCom && this._foldEffectCom)
            {
                alpha = 1;
                TweenLite.to(this, 1, {alpha:0, onComplete:this.finishFold});
                addChild(this._foldEffect);
                this._foldEffect.auto = true;
                this._foldEffect.updatePose("90", false);
                this._foldEffect.addEventListener(Event.COMPLETE, this._foldEffectComplete);
            }
            return;
        }// end function

        private function finishFold() : void
        {
            display.visible = false;
            alpha = 1;
            this._foldContainer.visible = true;
            addChild(this._foldContainer);
            this._fold.auto = true;
            this._fold.updatePose("90", true);
            this._isEffecting = false;
            this._isFold = true;
            return;
        }// end function

        private function _clickHandler(event:MouseEvent) : void
        {
            if (this._isEffecting)
            {
                return;
            }
            if (this._isFold)
            {
                this.showByCfg(this._config);
            }
            else
            {
                this.fold();
            }
            return;
        }// end function

        private function stopAllEffect() : void
        {
            if (this._foldEffect && contains(this._foldEffect))
            {
                this._foldEffectComplete();
            }
            if (this._showEffect && contains(this._showEffect))
            {
                this._showEffectComplete();
            }
            TweenLite.killDelayedCallsTo(this.fold);
            TweenLite.killTweensOf(this, false);
            if (display && display.bgView)
            {
                TweenLite.killTweensOf(display.bgView, false);
            }
            return;
        }// end function

    }
}
