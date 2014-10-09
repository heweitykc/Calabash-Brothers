package com.game.zones.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.guide.consts.*;
    import com.game.guide.control.*;
    import com.game.map.control.*;
    import com.game.zones.control.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.events.*;
    import flash.text.*;

    public class ZonesInspireView extends Component
    {
        private var TIPS_GLOD_INSPIRE:String;
        private var TIPS_MONEY_INSPIRE:String;
        private const BUFF_EXP:int = 1128;
        private const BUFF_ATTACK:int = 1101;
        private const BUFF_DEFENSE:int = 1102;
        private var _btnGlod:BaseButton;
        private var _btnMoney:BaseButton;
        private var _btnClose:BaseButton;
        private var _txtInspireAttact:TextField;
        private var _txtInspireDefense:TextField;
        private var _coinCost:int = 100000;

        public function ZonesInspireView()
        {
            this.TIPS_GLOD_INSPIRE = LanguageCfgObj.getInstance().getByIndex("11476");
            this.TIPS_MONEY_INSPIRE = LanguageCfgObj.getInstance().getByIndex("11477");
            loadDisplay("res/zonetasktrace.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initComponentUI("inspire_view");
            this.initComp();
            this.addEvent();
            super.displayReady();
            return;
        }// end function

        private function initComp() : void
        {
            this._btnGlod = new BaseButton(getDisplayChildByName("btn_inspire_glod"));
            this._btnMoney = new BaseButton(getDisplayChildByName("btn_inspire_money"));
            this._txtInspireAttact = TextField(getDisplayChildByName("txt_inspire_info1"));
            this._txtInspireDefense = TextField(getDisplayChildByName("txt_inspire_info2"));
            this._btnGlod.setText(LanguageCfgObj.getInstance().getByIndex("11478"));
            this._btnMoney.setText(LanguageCfgObj.getInstance().getByIndex("11479"));
            StringTip.create(this._btnGlod, this.TIPS_GLOD_INSPIRE);
            StringTip.create(this._btnMoney, this.TIPS_MONEY_INSPIRE);
            this.checkBuff();
            return;
        }// end function

        private function addEvent() : void
        {
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnGlod:
                {
                    if (UserObj.getInstance().playerInfo.gold >= 2)
                    {
                        ZonesControl.getInstance().reqAddInspireBuff(1);
                    }
                    else
                    {
                        MapControl.getInstance().showRechargeD();
                    }
                    break;
                }
                case this._btnMoney:
                {
                    if (UserObj.getInstance().playerInfo.money >= this._coinCost)
                    {
                        ZonesControl.getInstance().reqAddInspireBuff(0);
                    }
                    else
                    {
                        FunGuideControl.getInstance().showRemind(FunGuideConst.GOLD);
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

        public function setInspireBuf(param1:int, param2:int) : void
        {
            switch(param1)
            {
                case this.BUFF_ATTACK:
                {
                    this.setBuffAttact(param2 * 10);
                    break;
                }
                case this.BUFF_DEFENSE:
                {
                    this.setBuffDefense(param2 * 10);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setBuffAttact(param1:int) : void
        {
            if (param1 == 0)
            {
                this._txtInspireAttact.text = "";
            }
            else
            {
                this._txtInspireAttact.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12333"), [param1]);
            }
            return;
        }// end function

        private function setBuffDefense(param1:int) : void
        {
            if (param1 == 0)
            {
                this._txtInspireDefense.text = "";
            }
            else
            {
                this._txtInspireDefense.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12334"), [param1]);
            }
            return;
        }// end function

        public function checkBuff() : void
        {
            var _loc_1:* = UserObj.getInstance().getBuffInfo(this.BUFF_ATTACK);
            if (_loc_1 == null)
            {
                this.setBuffAttact(0);
            }
            else
            {
                this.setBuffAttact(_loc_1.num * 10);
            }
            _loc_1 = UserObj.getInstance().getBuffInfo(this.BUFF_DEFENSE);
            if (_loc_1 == null)
            {
                this.setBuffDefense(0);
            }
            else
            {
                this.setBuffDefense(_loc_1.num * 10);
            }
            return;
        }// end function

        public function open() : void
        {
            Global.mainUIManager.addUI(this, new LayoutInfo(Layout.RIGHT, 0, 150));
            if (UILoaded)
            {
                ButtonFlickerControl.getInstance().addButtonFlicker(this._btnGlod);
                ButtonFlickerControl.getInstance().addButtonFlicker(this._btnMoney);
                this.checkBuff();
            }
            return;
        }// end function

        public function close() : void
        {
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._btnGlod);
            ButtonFlickerControl.getInstance().removeButtonFlicker(this._btnMoney);
            Global.mainUIManager.removeUI(this);
            return;
        }// end function

    }
}
