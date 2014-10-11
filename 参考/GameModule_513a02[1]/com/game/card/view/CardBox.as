package com.game.card.view
{
    import com.*;
    import com.adobe.serialization.json.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.card.control.*;
    import com.game.card.model.*;
    import com.game.card.view.*;
    import com.game.map.control.*;
    import com.game.prompt.control.*;
    import com.game.reqhttp.control.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class CardBox extends BaseBox implements PhoneValidatePanelImpl
    {
        private var closeBtn:BaseButton;
        private var txt_lastphone:TextField;
        private var txt_phone:TextField;
        private var txt_card:TextField;
        private var txt_number:TextField;
        private var txt_back:TextField;
        private var txt_des:TextField;
        private var btn_sendPhone:BaseButton;
        private var btn_sendPhoneAgain:BaseButton;
        private var btn_sendCard:BaseButton;
        private var inputPhoneErrorTxt:TextField;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var _preTimer:int;
        private var countPhone:int = 30;
        private var countCard:int = 3;

        public function CardBox()
        {
            loadDisplay("res/phonebind.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("phoneBind");
            this.initUI();
            addEvtListener(Event.ADDED_TO_STAGE, this.addedToStage);
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.mc2.visible = false;
            this.txt_card = getDisplayChildByName("txt_card");
            this.btn_sendCard = new BaseButton(getDisplayChildByName("btn_sendCard"));
            this.btn_sendCard.addEvtListener(MouseEvent.CLICK, this.__click);
            this.txt_phone = this.mc1.getChildByName("txt_phone") as TextField;
            this.txt_phone.text = LanguageCfgObj.getInstance().getByIndex("10397");
            this.txt_phone.textColor = 7566194;
            this.txt_phone.restrict = "0-9";
            this.txt_phone.maxChars = 11;
            this.btn_sendPhone = new BaseButton(this.mc1.getChildByName("btn_sendPhone"));
            this.btn_sendPhone.addEvtListener(MouseEvent.CLICK, this.__click);
            this.inputPhoneErrorTxt = this.mc1.getChildByName("errorMsg") as TextField;
            this.txt_des = this.mc2.getChildByName("txt_des") as TextField;
            this.txt_des.selectable = false;
            this.txt_number = this.mc2.getChildByName("txt_number") as TextField;
            this.txt_number.selectable = false;
            this.txt_lastphone = this.mc2.getChildByName("txt_lastphone") as TextField;
            this.txt_card.text = LanguageCfgObj.getInstance().getByIndex("10398");
            this.txt_card.textColor = 7566194;
            this.txt_back = this.mc2.getChildByName("txt_back") as TextField;
            this.txt_back.htmlText = LanguageCfgObj.getInstance().getByIndex("10399");
            this.txt_back.addEventListener(TextEvent.LINK, this.backHandler);
            this.btn_sendPhoneAgain = new BaseButton(this.mc2.getChildByName("btn_sendPhoneAgain"));
            this.btn_sendPhoneAgain.setText(LanguageCfgObj.getInstance().getByIndex("10400"));
            this.btn_sendPhoneAgain.addEvtListener(MouseEvent.CLICK, this.__click);
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 70, 20);
            this.txt_phone.addEventListener(FocusEvent.FOCUS_IN, this.focusInHanler);
            this.txt_phone.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHanler);
            this.txt_card.addEventListener(FocusEvent.FOCUS_IN, this.focusInHanler);
            this.txt_card.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHanler);
            return;
        }// end function

        private function focusInHanler(event:FocusEvent) : void
        {
            switch(event.target)
            {
                case this.txt_phone:
                {
                    this.inputPhoneErrorTxt.text = "";
                    if (event.target.text == LanguageCfgObj.getInstance().getByIndex("10397"))
                    {
                        event.target.text = "";
                    }
                    this.txt_phone.textColor = 15850156;
                    break;
                }
                case this.txt_card:
                {
                    if (event.target.text == LanguageCfgObj.getInstance().getByIndex("10398"))
                    {
                        event.target.text = "";
                    }
                    this.txt_card.textColor = 15850156;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function focusOutHanler(event:FocusEvent) : void
        {
            switch(event.target)
            {
                case this.txt_phone:
                {
                    if (event.target.text == "")
                    {
                        event.target.text = LanguageCfgObj.getInstance().getByIndex("10397");
                        this.txt_phone.textColor = 7566194;
                    }
                    break;
                }
                case this.txt_card:
                {
                    if (event.target.text == "")
                    {
                        event.target.text = LanguageCfgObj.getInstance().getByIndex("10398");
                        this.txt_card.textColor = 7566194;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            switch(event.target)
            {
                case this.btn_sendPhone:
                case this.btn_sendPhoneAgain:
                {
                    if (this.checkPhone())
                    {
                        CardControl.getInstance().reqCardPhone(Params.username, UserObj.getInstance().playerInfo.personId, this.txt_phone.text);
                    }
                    break;
                }
                case this.btn_sendCard:
                {
                    _loc_2 = getTimer();
                    if (this._preTimer != 0 && _loc_2 - this._preTimer < 200)
                    {
                        return;
                    }
                    this._preTimer = _loc_2;
                    if (this.checkKey())
                    {
                        ReqHttpControl.getInstance().validateCode(this.txt_card.text, this.updateCard);
                        this.countCard = 3;
                        this.btn_sendCard.enabled = false;
                        this.btn_sendCard.filters = [FrameworkGlobal.colorMat];
                        this.btn_sendCard.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11939"), [this.countCard]));
                        Ticker.registerTimer(1, this.setTextCard, null, 3);
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function reqHttpPhone() : void
        {
            if (this.checkPhone())
            {
                ReqHttpControl.getInstance().getPhoneValidate(this.txt_phone.text, this.updateNumber, function () : void
            {
                return;
            }// end function
            );
            }
            else
            {
                this.inputPhoneErrorTxt.text = LanguageCfgObj.getInstance().getByIndex("10406");
                this.updateUI(false);
            }
            return;
        }// end function

        private function updateUI(param1:Boolean) : void
        {
            this.mc1.visible = !param1;
            this.mc2.visible = param1;
            return;
        }// end function

        private function checkPhone() : Boolean
        {
            var _loc_1:* = false;
            var _loc_2:* = this.txt_phone.text;
            if (_loc_2 == LanguageCfgObj.getInstance().getByIndex("10397"))
            {
                PromptControl.getInstance().personNoticeClient("dante_phoneauth_001");
            }
            else if (this.regPhoneNumber(_loc_2))
            {
                _loc_1 = true;
            }
            else
            {
                PromptControl.getInstance().personNoticeClient("dante_phoneauth_002");
                _loc_1 = false;
            }
            return _loc_1;
        }// end function

        public function regPhoneNumber(param1:String) : Boolean
        {
            var _loc_2:* = /^[0-9]{11}$/;
            var _loc_3:* = _loc_2.exec(param1);
            if (_loc_3 == null)
            {
                return false;
            }
            return true;
        }// end function

        private function checkKey() : Boolean
        {
            var _loc_1:* = this.txt_card.text;
            if (_loc_1 == LanguageCfgObj.getInstance().getByIndex("10398"))
            {
                PromptControl.getInstance().personNoticeClient("dante_phoneauth_003");
                return false;
            }
            return true;
        }// end function

        public function updateNumber(param1:String) : void
        {
            var _loc_2:* = JSON.decode(param1);
            var _loc_3:* = _loc_2.MSG;
            var _loc_4:* = "";
            if (_loc_2.RES == -2)
            {
                _loc_4 = LanguageCfgObj.getInstance().getByIndex("10409");
            }
            else if (_loc_2.RES == 0)
            {
                _loc_4 = LanguageCfgObj.getInstance().getByIndex("10410");
            }
            else if (_loc_2.RES == 6)
            {
                _loc_4 = LanguageCfgObj.getInstance().getByIndex("10411");
            }
            else if (_loc_2.RES == 7)
            {
                _loc_4 = LanguageCfgObj.getInstance().getByIndex("10412");
            }
            else if (_loc_2.RES == 2)
            {
                _loc_4 = LanguageCfgObj.getInstance().getByIndex("10413");
            }
            else if (_loc_2.RES == -4)
            {
                _loc_4 = LanguageCfgObj.getInstance().getByIndex("10414");
            }
            if (_loc_4 != "")
            {
                Global.popManager.addedToSystem(_loc_4);
                this.updateUI(false);
                return;
            }
            if (_loc_2.RES == 1)
            {
                this.updateUI(true);
                this.txt_number.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11940"), [_loc_3]);
                this.updateUI(true);
                this.countPhone = 30;
                this.btn_sendPhoneAgain.enabled = false;
                this.btn_sendPhoneAgain.filters = [FrameworkGlobal.colorMat];
                this.btn_sendPhoneAgain.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11941"), [this.countPhone]));
                this.txt_number.text = "";
                Ticker.killTimer(this.setTextPhone);
                Ticker.registerTimer(1, this.setTextPhone, null, 30);
                this.txt_lastphone.text = LanguageCfgObj.getInstance().getByIndex("11942") + this.txt_phone.text;
            }
            else if (_loc_2.RES == 4)
            {
                this.updateUI(false);
                this.inputPhoneErrorTxt.text = LanguageCfgObj.getInstance().getByIndex("10405");
                this.btn_sendPhoneAgain.setText(LanguageCfgObj.getInstance().getByIndex("10400"));
                this.btn_sendPhoneAgain.enabled = false;
                this.btn_sendPhoneAgain.filters = [FrameworkGlobal.colorMat];
                Ticker.killTimer(this.setTextPhone);
                this.updateUI(false);
            }
            else if (_loc_2.RES == -1)
            {
                this.inputPhoneErrorTxt.text = LanguageCfgObj.getInstance().getByIndex("10417");
            }
            return;
        }// end function

        public function updateCard(param1:String) : void
        {
            var _loc_2:* = JSON.decode(param1);
            var _loc_3:* = _loc_2.MSG;
            if (_loc_2.RES == "1")
            {
                CardData.getInstance().state = 2;
                MapControl.getInstance().showOrHideCardPhone(false);
                this.close();
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10418"));
            }
            else if (_loc_2.RES == "5")
            {
                Global.popManager.addedToSystem(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11943"), [_loc_2.MSG]));
            }
            else if (_loc_2.RES == "0")
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10419"));
            }
            else if (_loc_2.RES == "4")
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10420"));
            }
            else if (_loc_2.RES == "6")
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10421"));
            }
            return;
        }// end function

        private function setTextPhone() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.countPhone - 1;
            _loc_1.countPhone = _loc_2;
            this.btn_sendPhoneAgain.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11941"), [this.countPhone]));
            if (this.countPhone < 1)
            {
                this.btn_sendPhoneAgain.enabled = true;
                this.btn_sendPhoneAgain.filters = null;
                Ticker.killTimer(this.setTextPhone);
            }
            return;
        }// end function

        private function setTextCard() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.countCard - 1;
            _loc_1.countCard = _loc_2;
            this.btn_sendCard.setText(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11939"), [this.countCard]));
            if (this.countCard < 1)
            {
                this.btn_sendCard.enabled = true;
                this.btn_sendCard.filters = null;
                Ticker.killTimer(this.setTextCard);
            }
            return;
        }// end function

        private function backHandler(event:Event) : void
        {
            this.updateUI(false);
            return;
        }// end function

        private function addedToStage(event:Event) : void
        {
            if (CardData.getInstance().phone)
            {
                this.txt_phone.text = CardData.getInstance().phone;
            }
            this.inputPhoneErrorTxt.text = "";
            this.updateUI(false);
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
