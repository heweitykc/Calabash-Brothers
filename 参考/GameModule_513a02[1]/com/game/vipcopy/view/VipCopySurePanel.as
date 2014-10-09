package com.game.vipcopy.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.backpack.model.*;
    import com.game.map.control.*;
    import com.game.vipcopy.control.*;
    import com.game.vipcopy.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class VipCopySurePanel extends BaseBox
    {
        private var txt_des:TextField;
        private var closeBtn:BaseButton;
        private var yes_btn:BaseButton;
        private var img:MovieClip;
        private var goodID:int = 100005;
        private var layer:Array;
        private var needNumber:Array;
        private var copyIdArray:Array;
        private var curSelect:int = 1;
        private var price:Array;

        public function VipCopySurePanel()
        {
            this.layer = [LanguageCfgObj.getInstance().getByIndex("12298"), LanguageCfgObj.getInstance().getByIndex("12299"), LanguageCfgObj.getInstance().getByIndex("12300")];
            this.needNumber = [0, 10, 40];
            this.copyIdArray = [3007, 3008, 3009];
            this.price = [0, 10, 10];
            loadDisplay("res/vipcopy.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("vipEnterSure");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt_des = getDisplayChildByName("txt_des");
            this.img = getDisplayChildByName("img");
            this.yes_btn = new BaseButton(getDisplayChildByName("yes_btn"));
            this.yes_btn.setText(LanguageCfgObj.getInstance().getByIndex("11420"));
            this.yes_btn.addEvtListener(MouseEvent.CLICK, this.__click);
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 5, 5);
            this.update();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            switch(event.target)
            {
                case this.yes_btn:
                {
                    _loc_2 = VipCopyData.getInstance().getCopyLeftNum(this.copyIdArray[(this.curSelect - 1)]);
                    if (_loc_2 == 0)
                    {
                        Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("11421"));
                    }
                    else
                    {
                        _loc_3 = BackpackObj.getInstance().getItemCount(this.goodID);
                        if (_loc_3 >= this.needNumber[(this.curSelect - 1)])
                        {
                            VipCopyControl.getInstance().reqEnterVipCopy(0, this.copyIdArray[(this.curSelect - 1)]);
                            close();
                        }
                        else if (UserObj.getInstance().playerInfo.gold < (this.needNumber[(this.curSelect - 1)] - _loc_3) * this.price[(this.curSelect - 1)])
                        {
                            MapControl.getInstance().showRechargeD();
                        }
                        else
                        {
                            VipCopyControl.getInstance().reqEnterVipCopy(0, this.copyIdArray[(this.curSelect - 1)]);
                            close();
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

        private function update() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (UILoaded)
            {
                this.curSelect = VipCopyData.getInstance().curSelect;
                _loc_1 = ZonesCloneCfg.getInstance().getZonesInfoFromId(this.copyIdArray[(this.curSelect - 1)]);
                this.goodID = int(_loc_1.need_item);
                _loc_2 = new PropInfo();
                _loc_2.convByCfg(this.goodID);
                _loc_3 = new IconItem("");
                _loc_3.setWH(56, 56);
                _loc_3.setImageSize(56, 56);
                _loc_3.setInfo(_loc_2);
                ToolKit.clearMcChild(this.img);
                this.img.addChild(_loc_3);
                _loc_4 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12309"), [this.layer[(this.curSelect - 1)], _loc_2.q_name, this.needNumber[(this.curSelect - 1)]]);
                _loc_5 = BackpackObj.getInstance().getItemCount(this.goodID);
                if (_loc_5 < this.needNumber[(this.curSelect - 1)])
                {
                    _loc_4 = _loc_4 + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12310"), [_loc_2.q_name, (this.needNumber[(this.curSelect - 1)] - _loc_5) * this.price[(this.curSelect - 1)]]);
                }
                this.txt_des.htmlText = _loc_4;
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.update();
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
