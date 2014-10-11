package com.f1.ui
{
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.ui.box.*;
    import com.f1.ui.stripe.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class UILoadingBox extends BaseBox
    {
        private var stripe1:Stripe;
        private var txt:TextField;
        private var _currentURL:String;
        private var _logoMC:MovieClip;
        private var _autoCloseTime:Number;

        public function UILoadingBox()
        {
            setWH(331, 230);
            initBaseBoxUI("UI_loading_mc2");
            UILoaded = true;
            _peaceBox = ["*"];
            this.initUI();
            return;
        }// end function

        public function set autoClose(param1:Number) : void
        {
            this._autoCloseTime = param1;
            return;
        }// end function

        private function initUI() : void
        {
            this.stripe1 = new Stripe(getDisplayChildByName("loadstripe"));
            this.txt = getDisplayChildByName("txt");
            this.txt.text = "";
            addChild(this.stripe1);
            this._logoMC = getDisplayChildByName("logomc");
            return;
        }// end function

        public function setProgress(event:ProgressEvent, param2:VResLoadObj) : void
        {
            var _loc_3:* = event.bytesLoaded;
            var _loc_4:* = event.bytesTotal;
            if (param2.groupInfo)
            {
                _loc_3 = param2.groupInfo.loadedSize;
                _loc_4 = param2.groupInfo.totalSize;
            }
            var _loc_5:* = this._autoCloseTime > 0 ? (100000) : (0 + _loc_4);
            this.stripe1.setValue(_loc_3, _loc_5, false, "", false);
            this._currentURL = param2.url.split("/").pop();
            var _loc_6:* = Math.min(100, uint(_loc_3 * 100 / _loc_5));
            this.txt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11766"), [this._currentURL, _loc_6]);
            return;
        }// end function

        private function startAutoClose() : void
        {
            if (this._autoCloseTime > 0)
            {
                this.stripe1.fillStripe(this._autoCloseTime, this.fillUpdate);
                TweenLite.delayedCall(this._autoCloseTime + 0.5, this.close);
            }
            return;
        }// end function

        private function fillUpdate(param1:uint) : void
        {
            this.txt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11766"), [this._currentURL, param1]);
            return;
        }// end function

        override public function close() : void
        {
            if (this._autoCloseTime > 0)
            {
                this.startAutoClose();
                this._autoCloseTime = 0;
                return;
            }
            if (this._logoMC)
            {
                this._logoMC.stop();
            }
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            if (this._logoMC)
            {
                this._logoMC.play();
            }
            this.txt.text = "";
            this.stripe1.setValue(0, 0, false, "", false);
            super.open();
            return;
        }// end function

    }
}
