package com.game.chat.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.backpack.control.*;
    import com.game.backpack.events.*;
    import com.game.backpack.model.*;
    import com.game.chat.control.*;
    import com.game.chat.model.*;
    import com.game.confirm.*;
    import com.game.shop.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class HornPanel extends BaseBox
    {
        private const TEMPLATE:String;
        private var _templateTxt:TextField;
        private var _inputTxt:ChatInput;
        private var _closeBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _enterBtn:BaseButton;
        private var _faceBtn:BaseButton;
        private var _face:FaceSp;
        private var _buyBtn:BaseButton;
        private var _icon:NeedIcon;
        private var _priceTxt:TextField;

        public function HornPanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.TEMPLATE = LanguageCfgObj.getInstance().getByIndex("10468");
            _combinedBox = ["com.game.backpack.view::BackPackPanel", "com.game.primaryrole.view::PrimaryRoleMainPanel"];
            loadDisplay("res/horn.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("horn");
            this.initUI();
            this.addlisteners();
            this.initTemplate();
            this.drawIcon();
            ChatController.getInstance().hornInput = this;
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._inputTxt = new ChatInput();
            this._inputTxt.isMultine = true;
            this._inputTxt.wordWrap = true;
            this._inputTxt.width = 285;
            this._inputTxt.height = 50;
            this._inputTxt.x = 20;
            this._inputTxt.textColor = 16771767;
            this._inputTxt.y = 130;
            addChild(this._inputTxt);
            this._inputTxt.horn = this;
            this._enterBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._buyBtn = new BaseButton(getDisplayChildByName("btn_buy"));
            this._face = FaceSp.instance;
            this._icon = new NeedIcon();
            this._icon.setImageXY(6, 6);
            this._icon.setImageSize(56, 56);
            this._icon.setCountTxtXY(55, 43);
            this._icon.move(20, 46);
            addChild(this._icon);
            this._priceTxt = getDisplayChildByName("txt_price");
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._faceBtn = new BaseButton(getDisplayChildByName("btn_face"));
            this._enterBtn.setText(LanguageCfgObj.getInstance().getByIndex("10469"));
            this._cancelBtn.setText(LanguageCfgObj.getInstance().getByIndex("10470"));
            this._buyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10471"));
            this._enterBtn.enabled = false;
            return;
        }// end function

        private function drawIcon() : void
        {
            var _loc_1:* = PropUtil.createItemByCfg(ItemConst.HORN);
            _loc_1.num = BackpackObj.getInstance().getItemCount(ItemConst.HORN);
            this._icon.setInfo(_loc_1);
            this._icon.count = 1;
            var _loc_2:* = ShopCfgObj.getInstance().getShopItemInfoFromInside(ItemConst.HORN);
            this._priceTxt.text = _loc_2.gold.toString();
            return;
        }// end function

        private function addlisteners() : void
        {
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._enterBtn.addEvtListener(MouseEvent.CLICK, this.__enter);
            this._faceBtn.addEvtListener(MouseEvent.CLICK, this.__face);
            this._buyBtn.addEvtListener(MouseEvent.CLICK, this.__buy);
            this._inputTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            return;
        }// end function

        private function __buy(event:MouseEvent) : void
        {
            var _loc_2:* = ShopCfgObj.getInstance().getShopItemInfoFromInside(ItemConst.HORN);
            if (_loc_2 == null)
            {
                throw new Error(LanguageCfgObj.getInstance().getByIndex("10472"));
            }
            ShopController.getInstance().openBuyItem(_loc_2);
            return;
        }// end function

        private function __face(event:MouseEvent) : void
        {
            this._face.x = this._faceBtn.x;
            this._face.y = this._faceBtn.y - this._face.height - 2;
            this._face.position = 1;
            addChild(this._face);
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            ChatController.getInstance().horn_active_time = 0;
            BackpackObj.getInstance().addEvtListener(BackpackEvent.GOODS_CHANGE, this.__itemChange);
            FrameworkGlobal.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
            return;
        }// end function

        public function linkToChat(param1:PropInfo) : void
        {
            this._inputTxt.accept(param1);
            return;
        }// end function

        public function addToFace(param1:String) : void
        {
            this._inputTxt.addFace(param1);
            return;
        }// end function

        private function __enter(event:MouseEvent) : void
        {
            this.enter();
            return;
        }// end function

        private function enter() : void
        {
            var _loc_1:* = this._inputTxt.getMsg();
            var _loc_2:* = _loc_1[0];
            var _loc_3:* = _loc_1[1];
            if (_loc_2.length == 0 && _loc_3.length == 0)
            {
                return;
            }
            var _loc_4:* = getTimer();
            if (ChatModel.getInstance().preTimer[ChatType.CHATTYPE_HORN] == 0 || _loc_4 - ChatModel.getInstance().preTimer[ChatType.CHATTYPE_HORN] > ChatModel.getInteralTime(ChatType.CHATTYPE_HORN))
            {
                BackPackControl.getInstance().checkItemCount(ItemConst.HORN, 1, this.sendMsg, [_loc_2, _loc_3], ConfirmObj.CHAT_LABA);
            }
            else
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10473"));
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            FrameworkGlobal.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.__keyDownHandler);
            BackpackObj.getInstance().addEvtListener(BackpackEvent.GOODS_CHANGE, this.__itemChange);
            this.assignActiveTime();
            if (UILoaded)
            {
                this._enterBtn.enabled = false;
                this.drawIcon();
                this.initTemplate();
                this.clear();
                this._inputTxt.addEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false, 0, true);
            }
            return;
        }// end function

        private function assignActiveTime() : void
        {
            var _loc_1:* = getTimer();
            ChatController.getInstance().horn_active_time = _loc_1;
            return;
        }// end function

        override public function changeToActive() : void
        {
            this.assignActiveTime();
            return;
        }// end function

        private function __itemChange(event:BackpackEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.data as PropInfo;
            if (_loc_2)
            {
                if (_loc_2.itemModelId == ItemConst.HORN)
                {
                    _loc_3 = this._icon.info;
                    if (_loc_3)
                    {
                        _loc_3.num = BackpackObj.getInstance().getItemCount(ItemConst.HORN);
                        this._icon.count = 1;
                    }
                }
            }
            return;
        }// end function

        private function clear() : void
        {
            this._inputTxt.clear();
            return;
        }// end function

        private function __keyDownHandler(event:KeyboardEvent) : void
        {
            switch(event.keyCode)
            {
                case KeyCode.ENTER:
                {
                    if (!UserObj.keyable)
                    {
                        return;
                    }
                    if (stage.focus == this._inputTxt)
                    {
                        this.enter();
                    }
                    else if (!ToolKit.isInputTextField)
                    {
                        if (ChatController.getInstance().ishornActive())
                        {
                            stage.focus = this._inputTxt;
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

        private function sendMsg(... args) : void
        {
            ChatController.getInstance().chatRquest(ChatType.CHATTYPE_HORN, args[0], "", args[1]);
            this._inputTxt.clear();
            this._enterBtn.enabled = false;
            return;
        }// end function

        private function __check(event:MouseEvent) : void
        {
            return;
        }// end function

        private function __focusIn(event:FocusEvent) : void
        {
            this.assignActiveTime();
            this._inputTxt.removeEventListener(FocusEvent.FOCUS_IN, this.__focusIn, false);
            if (this._templateTxt && this._templateTxt.parent)
            {
                this._templateTxt.parent.removeChild(this._templateTxt);
            }
            return;
        }// end function

        public function decide(param1:int) : void
        {
            this._enterBtn.enabled = param1 > 0 ? (true) : (false);
            return;
        }// end function

        private function initTemplate() : void
        {
            var _loc_1:* = null;
            if (this._templateTxt == null)
            {
                this._templateTxt = new TextField();
                this._templateTxt.autoSize = "left";
                this._templateTxt.mouseEnabled = false;
                this._templateTxt.x = this._inputTxt.x;
                this._templateTxt.y = this._inputTxt.y - 1;
                _loc_1 = this._templateTxt.defaultTextFormat;
                _loc_1.font = "SimSun";
                this._templateTxt.defaultTextFormat = _loc_1;
            }
            if (this._templateTxt.parent == null)
            {
                addChild(this._templateTxt);
            }
            this._templateTxt.htmlText = this.TEMPLATE;
            return;
        }// end function

        public function initInput() : void
        {
            if (this._inputTxt.text == "")
            {
                this.initTemplate();
            }
            else if (this._templateTxt && this._templateTxt.parent)
            {
                this._templateTxt.parent.removeChild(this._templateTxt);
            }
            return;
        }// end function

    }
}
