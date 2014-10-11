package com.game.card.view
{
    import com.*;
    import com.adobe.serialization.json.*;
    import com.f1.*;
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
    import com.greensock.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class CardBoxTemp extends BaseBox implements PhoneValidatePanelImpl
    {
        private var closeBtn:BaseButton;
        private var txt_number:TextField;
        private var btn_sendPhone:BaseButton;
        private var inputPhoneErrorTxt:TextField;
        private var INPUTPHONENUM:String;
        private var _preTimer:int;

        public function CardBoxTemp(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.INPUTPHONENUM = LanguageCfgObj.getInstance().getByIndex("10397");
            loadDisplay("res/phonebind_temp.swf");
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
            this.btn_sendPhone = new BaseButton(getDisplayChildByName("btn_sendPhone"));
            this.btn_sendPhone.addEvtListener(MouseEvent.CLICK, this.__click);
            this.inputPhoneErrorTxt = getDisplayChildByName("errorMsg") as TextField;
            this.txt_number = getDisplayChildByName("txt_number") as TextField;
            this.txt_number.text = this.INPUTPHONENUM;
            this.txt_number.textColor = 7566194;
            this.txt_number.restrict = "0-9";
            this.txt_number.maxChars = 11;
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 70, 20);
            this.txt_number.addEventListener(FocusEvent.FOCUS_IN, this.focusInHanler);
            this.txt_number.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHanler);
            return;
        }// end function

        private function focusInHanler(event:FocusEvent) : void
        {
            switch(event.target)
            {
                case this.txt_number:
                {
                    this.inputPhoneErrorTxt.text = "";
                    if (event.target.text == this.INPUTPHONENUM)
                    {
                        event.target.text = "";
                    }
                    this.txt_number.textColor = 15850156;
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
                case this.txt_number:
                {
                    if (event.target.text == "")
                    {
                        event.target.text = this.INPUTPHONENUM;
                        this.txt_number.textColor = 7566194;
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
            var time:int;
            var e:* = event;
            switch(e.target)
            {
                case this.btn_sendPhone:
                {
                    time = getTimer();
                    if (this._preTimer != 0 && time - this._preTimer < 200)
                    {
                        return;
                    }
                    this._preTimer = time;
                    if (this.checkPhone())
                    {
                        if (this.checkPhone())
                        {
                            this.btn_sendPhone.enabled = false;
                            CardControl.getInstance().reqCardPhone(Params.username, UserObj.getInstance().playerInfo.personId, this.txt_number.text);
                            TweenLite.delayedCall(1, function () : void
            {
                btn_sendPhone.enabled = true;
                return;
            }// end function
            );
                        }
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
                ReqHttpControl.getInstance().getPhoneValidate(this.txt_number.text, function (param1:String) : void
            {
                Log.log("手机连接成功");
                CardData.getInstance().state = 2;
                MapControl.getInstance().showOrHideCardPhone(false);
                close();
                return;
            }// end function
            , function () : void
            {
                Global.popManager.addedToSystem("手机验证连接失败");
                return;
            }// end function
            );
            }
            else
            {
                this.inputPhoneErrorTxt.text = LanguageCfgObj.getInstance().getByIndex("10424");
            }
            return;
        }// end function

        private function checkPhone() : Boolean
        {
            var _loc_1:* = false;
            var _loc_2:* = this.txt_number.text;
            if (_loc_2 == this.INPUTPHONENUM)
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

        public function updateCard(param1:String) : void
        {
            var _loc_2:* = JSON.decode(param1);
            var _loc_3:* = _loc_2.MSG;
            if (_loc_2.RES == "1")
            {
                CardControl.getInstance().reqCard("-1");
                close();
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10425"));
            }
            else if (_loc_2.RES == "5")
            {
                Global.popManager.addedToSystem("验证失败，今日剩余" + _loc_2.MSG + "次");
            }
            else if (_loc_2.RES == "0")
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10426"));
            }
            else if (_loc_2.RES == "4")
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10427"));
            }
            else if (_loc_2.RES == "6")
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10428"));
            }
            return;
        }// end function

        private function addedToStage(event:Event) : void
        {
            if (CardData.getInstance().phone)
            {
                this.txt_number.text = CardData.getInstance().phone;
            }
            this.inputPhoneErrorTxt.text = "";
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
