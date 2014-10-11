package com.game.zones.view.bosshome
{
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.zones.model.*;
    import com.greensock.*;
    import com.riaidea.text.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class BossHomeIcon extends Component
    {
        private var _model:BossHomeModel;
        private var _stripe:BossHomeStripe;
        private var _txt:TextField;
        private var _closeBtn:BaseButton;
        private var _count:int;
        private var _aggregationView:VMCView;
        private var paopao:Sprite;
        private var speakDialog:RichTextField;

        public function BossHomeIcon()
        {
            super("icon_boss_home");
            this._model = BossHomeModel.getInstance();
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._stripe = new BossHomeStripe(getDisplayChildByName("stripe"));
            this._txt = getDisplayChildByName("txt_progress");
            this._txt.selectable = false;
            this.paopao = getDisplayChildByName("speak");
            this._closeBtn = new BaseButton(ToolKit.getNew("close_btn2"));
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.stopSpeak);
            if (this.paopao.parent)
            {
                this.paopao.parent.removeChild(this.paopao);
            }
            StringTip.create(this, LanguageCfgObj.getInstance().getByIndex("10013", BossHomeConsts.LANG_VER));
            return;
        }// end function

        public function update() : void
        {
            if (this._model.anger == 0)
            {
                this.speak(LanguageCfgObj.getInstance().getByIndex("10006", BossHomeConsts.LANG_VER));
            }
            if (this._model.anger > 0 && this._model.orginAnger == 0)
            {
                this.speak(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10007", BossHomeConsts.LANG_VER), [1, 1]));
            }
            if (this._model.anger > 30 && this._model.orginAnger <= 30)
            {
                this.speak(LanguageCfgObj.getInstance().getByIndex("10008", BossHomeConsts.LANG_VER));
            }
            if (this._model.anger > 80 && this._model.orginAnger <= 80)
            {
                this.speak(LanguageCfgObj.getInstance().getByIndex("10009", BossHomeConsts.LANG_VER));
            }
            if (this._model.anger >= 100 && this._model.orginAnger < 100)
            {
                this._count = 30;
                Ticker.killTimer(this.speakLight);
                this.speakLight();
                Ticker.registerTimer(1, this.speakLight, null, this._count);
            }
            this._stripe.progress = this._model.anger > 100 ? (100) : (this._model.anger);
            this._txt.text = (this._model.anger > 100 ? (100) : (this._model.anger)).toString();
            return;
        }// end function

        public function aggregation() : void
        {
            if (this._aggregationView == null)
            {
                this._aggregationView = new VMCView();
                this._aggregationView.loadRes("res/effect/thunderaggregation.png");
                this._aggregationView.auto = true;
            }
            this._aggregationView.move(50, 0);
            this._aggregationView.updatePose("90", false, false, true);
            addChild(this._aggregationView);
            return;
        }// end function

        public function richSpeak(param1:String, param2:Array = null, param3:Boolean = false, param4:TextFormat = null, param5:int = 0) : void
        {
            if (this.speakDialog == null)
            {
                this.initSpeakDialog();
            }
            this.stopSpeak();
            this.speakDialog.append(param1, param2, param3, param4);
            this.layoutPaopao(param1, param2, param3, param4);
            TweenLite.killDelayedCallsTo(this.stopSpeak);
            addChild(this.paopao);
            if (this._closeBtn.parent)
            {
                this._closeBtn.parent.removeChild(this._closeBtn);
            }
            addChild(this.speakDialog);
            if (param5 != 0)
            {
                TweenLite.delayedCall(param5, this.stopSpeak);
            }
            return;
        }// end function

        public function getNum(param1:String) : Bitmap
        {
            var _loc_2:* = "boss_" + param1;
            var _loc_3:* = ToolKit.getNewDO(_loc_2) as Bitmap;
            return _loc_3;
        }// end function

        private function speakLight() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = this;
            var _loc_7:* = this._count - 1;
            _loc_6._count = _loc_7;
            var _loc_1:* = LanguageCfgObj.getInstance().getByIndex("10010", BossHomeConsts.LANG_VER);
            var _loc_2:* = [];
            var _loc_3:* = this._count.toString().length < 2 ? ("0" + this._count) : (this._count.toString());
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = this.getNum(_loc_3.toString().charAt(_loc_4));
                _loc_2.push({index:_loc_1.length, src:_loc_5});
                _loc_4++;
            }
            this.richSpeak(_loc_1, _loc_2);
            if (this._count <= 0)
            {
                Ticker.killTimer(this.speakLight);
                this.stopSpeak();
            }
            return;
        }// end function

        public function speak(param1:String) : void
        {
            if (this.speakDialog == null)
            {
                this.initSpeakDialog();
            }
            this.stopSpeak();
            this.speakDialog.append(param1);
            this.layoutPaopao(param1);
            this._closeBtn.x = this.paopao.x + this.paopao.width - this._closeBtn.width + 1;
            this._closeBtn.y = this.paopao.y + 3;
            addChild(this.paopao);
            addChild(this.speakDialog);
            if (this._closeBtn.parent == null)
            {
                addChild(this._closeBtn);
            }
            TweenLite.delayedCall(15, this.stopSpeak);
            return;
        }// end function

        public function stopSpeak(event:Event = null) : void
        {
            if (this.paopao != null)
            {
                TweenLite.killDelayedCallsTo(this.stopSpeak);
                if (this._closeBtn.parent)
                {
                    this._closeBtn.parent.removeChild(this._closeBtn);
                }
                if (this.speakDialog)
                {
                    this.speakDialog.clear();
                }
                if (this.paopao.parent)
                {
                    this.paopao.parent.removeChild(this.paopao);
                }
                if (this.speakDialog)
                {
                    if (this.speakDialog.parent)
                    {
                        this.speakDialog.parent.removeChild(this.speakDialog);
                    }
                    this.speakDialog.setSize(152, this.speakDialog.textfield.textHeight + 4);
                }
            }
            return;
        }// end function

        private function layoutPaopao(param1:String, param2:Array = null, param3:Boolean = false, param4:TextFormat = null) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (this.paopao)
            {
                _loc_5 = this.speakDialog.textfield.textWidth + 4;
                _loc_6 = this.speakDialog.textfield.textHeight + 8;
                if (_loc_5 < 50)
                {
                    _loc_5 = 50;
                }
                if (_loc_6 <= this.speakDialog.height)
                {
                    _loc_6 = this.speakDialog.height;
                }
                this.speakDialog.setSize(140, _loc_6);
                this.paopao["bg"].width = _loc_5 + 18;
                this.paopao["bg"].height = _loc_6 + 18;
                this.paopao.height = _loc_6 + 19;
                this.speakDialog.x = this.paopao.x + 18;
                this.speakDialog.y = this.paopao.y + 11;
            }
            return;
        }// end function

        private function initSpeakDialog() : void
        {
            this.speakDialog = new RichTextField();
            this.speakDialog.type = RichTextField.DYNAMIC;
            var _loc_1:* = new TextFormat("SimSun", 12, 14604487, false, false, false);
            _loc_1.leading = 5;
            this.speakDialog.defaultTextFormat = _loc_1;
            this.speakDialog.textfield.mouseWheelEnabled = false;
            this.speakDialog.textfield.selectable = false;
            this.speakDialog.textfield.filters = [FrameworkGlobal.BLACK_FILTER];
            this.speakDialog.autoScroll = false;
            this.speakDialog.html = true;
            this.speakDialog.setSize(152, 40);
            return;
        }// end function

        public function reset() : void
        {
            Ticker.killTimer(this.speakLight);
            return;
        }// end function

    }
}
