package com.game.supervip.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.map.control.*;
    import com.game.supervip.control.*;
    import com.game.supervip.event.*;
    import com.game.supervip.model.*;
    import com.game.supervip.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class SupervipPanel extends SupervipBaseBox
    {
        private var btnClose:BaseButton;
        private var btnRecharge:BaseButton;
        private var viewGmName:TextField;
        private var viewGmQq:TextField;
        private var viewGmPhoto:SupervipCrossdomainImage;
        private var viewRequiredRmb:TextField;
        private var viewRmbDif:TextField;
        private var viewRmbDifNormalX:int;
        private var viewItem:SupervipItemView;
        private var viewTitle:SupervipTitleView;
        private var viewRechargeButtonEffect:VMCView;
        private var viewGift:Sprite;
        private var viewGiftEffect:VMCView;
        private var supervipData:SupervipData;

        public function SupervipPanel()
        {
            this.supervipData = SupervipData.getInstance();
            loadDisplay("res/supervipPanel.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("supervipPanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        public function initUI() : void
        {
            this.btnClose = SupervipUiUtil.createButton(this, "btnClose", this.onClose);
            this.btnRecharge = SupervipUiUtil.createButton(this, "btnRecharge", this.onRecharge);
            this.viewGmName = getDisplayChildByName("viewGmName");
            this.adjustDefaultTextFormat(this.viewGmName, null, null);
            this.viewGmQq = getDisplayChildByName("viewGmQq");
            this.adjustDefaultTextFormat(this.viewGmQq, null, null);
            this.viewGmPhoto = new SupervipCrossdomainImage();
            this.addUnderCover(this.viewGmPhoto, "viewGmPhotoCover");
            this.viewRequiredRmb = getDisplayChildByName("viewRequiredRmb");
            this.adjustDefaultTextFormat(this.viewRequiredRmb, true, null);
            this.viewRequiredRmb.autoSize = TextFieldAutoSize.LEFT;
            this.viewRmbDif = getDisplayChildByName("viewRmbDif");
            this.adjustDefaultTextFormat(this.viewRmbDif, true, null);
            this.viewRmbDifNormalX = this.viewRmbDif.x;
            this.viewItem = new SupervipItemView();
            this.addOverBg(this.viewItem, "viewItemBg", 2, 1);
            this.viewItem.setItemModelId(GlobalCfgObj.getInstance().getSupervipAwardItemModelId());
            this.viewTitle = new SupervipTitleView();
            this.addOverBg(this.viewTitle, "viewTitleBg", 78, 26);
            this.viewTitle.hitArea = getDisplayChildByName("viewTitleBg");
            this.viewTitle.setTitleId(GlobalCfgObj.getInstance().getSupervipAwardTitleId());
            this.viewGift = getDisplayChildByName("viewGift");
            this.viewRechargeButtonEffect = new VMCView();
            this.viewRechargeButtonEffect.auto = true;
            this.viewRechargeButtonEffect.loadRes("res/effect/supervip/rechargeButton.png", null, true);
            this.viewRechargeButtonEffect.updatePose("90", true);
            this.viewRechargeButtonEffect.move(this.btnRecharge.x + this.btnRecharge.width / 2, this.btnRecharge.y + this.btnRecharge.height / 2 - 2);
            addChild(this.viewRechargeButtonEffect);
            this.viewGiftEffect = new VMCView();
            this.viewGiftEffect.auto = true;
            this.viewGiftEffect.loadRes("res/effect/supervip/gift.png", null, true);
            this.viewGiftEffect.updatePose("90", true);
            this.viewGiftEffect.move(this.viewGift.x + this.viewGift.width / 2, this.viewGift.y + this.viewGift.height / 2);
            addChild(this.viewGiftEffect);
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (stage)
            {
                this.onAddedToStage();
            }
            return;
        }// end function

        private function onAddedToStage(event:Event = null) : void
        {
            SupervipControl.getInstance().reqGetSuperVipInfo();
            this.supervipData.addEventListener(SupervipEvent.SUPERVIP_DATA_CHANGE, this.refreshData);
            this.initData();
            return;
        }// end function

        private function onRemovedFromStage(event:Event) : void
        {
            this.supervipData.removeEventListener(SupervipEvent.SUPERVIP_DATA_CHANGE, this.refreshData);
            return;
        }// end function

        private function addUnderCover(param1:DisplayObject, param2:String, param3:int = 0, param4:int = 0, param5:Boolean = false) : void
        {
            var _loc_6:* = getDisplayChildByName(param2);
            var _loc_7:* = _loc_6.parent;
            if (param5)
            {
                _loc_6.mouseEnabled = false;
                _loc_6.mouseChildren = false;
            }
            var _loc_8:* = _loc_6.x + param3;
            var _loc_9:* = _loc_6.y + param4;
            if (param1 is VMCView)
            {
                (param1 as VMCView).move(_loc_8, _loc_9);
            }
            else
            {
                param1.x = _loc_8;
                param1.y = _loc_9;
            }
            _loc_7.addChildAt(param1, _loc_7.getChildIndex(_loc_6));
            return;
        }// end function

        private function addOverBg(param1:DisplayObject, param2:String, param3:int = 0, param4:int = 0) : void
        {
            var _loc_8:* = 0;
            var _loc_5:* = getDisplayChildByName(param2);
            var _loc_6:* = _loc_5.parent;
            var _loc_7:* = _loc_5.x + param3;
            _loc_8 = _loc_5.y + param4;
            if (param1 is VMCView)
            {
                (param1 as VMCView).move(_loc_7, _loc_8);
            }
            else
            {
                param1.x = _loc_7;
                param1.y = _loc_8;
            }
            _loc_6.addChildAt(param1, (_loc_6.getChildIndex(_loc_5) + 1));
            return;
        }// end function

        private function adjustDefaultTextFormat(param1:TextField, param2 = null, param3 = null) : void
        {
            var _loc_4:* = param1.defaultTextFormat;
            _loc_4.bold = param2;
            _loc_4.italic = param3;
            param1.defaultTextFormat = _loc_4;
            return;
        }// end function

        private function initData() : void
        {
            this.refreshData();
            return;
        }// end function

        private function refreshData(event:Event = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = false;
            var _loc_4:* = null;
            if (!this.supervipData.hasData)
            {
                this.viewRequiredRmb.text = "";
                this.viewGmName.text = "";
                this.viewGmQq.text = "";
                this.viewRmbDif.text = "";
            }
            else
            {
                _loc_2 = this.supervipData.rmbDif;
                _loc_3 = _loc_2 <= 0;
                _loc_4 = _loc_3 ? (this.supervipData.gmQq) : ("*********");
                this.viewRequiredRmb.htmlText = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12210"), [this.supervipData.requiredRmb]);
                this.viewGmName.text = "GM-" + this.supervipData.gmName;
                this.viewGmQq.text = "GM-" + this.supervipData.gmName + _loc_4;
                this.viewRmbDif.visible = !_loc_3;
                if (this.viewRmbDif.visible)
                {
                    this.viewRmbDif.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12211"), [_loc_2]);
                    this.viewRmbDif.x = this.viewRmbDifNormalX + (this.viewRmbDif.width - this.viewRmbDif.textWidth) / 2 - 2;
                }
                this.viewGmPhoto.load(this.supervipData.gmPhoto);
            }
            return;
        }// end function

        private function onRecharge(event:MouseEvent) : void
        {
            MapControl.getInstance().showRecharge();
            return;
        }// end function

        private function onClose(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
