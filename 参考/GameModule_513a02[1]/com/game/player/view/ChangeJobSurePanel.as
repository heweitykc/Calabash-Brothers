package com.game.player.view
{
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.player.control.*;
    import com.game.shop.control.*;
    import com.model.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ChangeJobSurePanel extends BaseBox
    {
        private var txt_des:TextField;
        private var closeBtn:BaseButton;
        private var yes_btn:BaseButton;
        private var no_btn:BaseButton;
        private var img:MovieClip;
        private var goodID:int = 701025;
        private var price:Array;
        private var bugNum:int = 1;

        public function ChangeJobSurePanel()
        {
            this.price = [0, 10, 10];
            loadDisplay("res/changejobbox.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("changeJobSure");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt_des = getDisplayChildByName("txt_des");
            this.img = getDisplayChildByName("img");
            this.yes_btn = new BaseButton(getDisplayChildByName("yes_btn"));
            this.no_btn = new BaseButton(getDisplayChildByName("no_btn"));
            this.yes_btn.addEvtListener(MouseEvent.CLICK, this.__click);
            this.no_btn.addEvtListener(MouseEvent.CLICK, this.__click);
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
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.yes_btn:
                {
                    _loc_2 = ShopCfgObj.getInstance().getShopItemInfoFromInside(this.goodID);
                    ShopController.getInstance().openBuyItem(_loc_2, this.bugNum);
                    this.__close();
                    break;
                }
                case this.no_btn:
                {
                    ChangeJobControl.getInstance().reqActivateStar();
                    this.__close();
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
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (UILoaded)
            {
                _loc_1 = new PropInfo();
                _loc_1.convByCfg(this.goodID);
                _loc_2 = new IconItem("");
                _loc_2.setWH(56, 56);
                _loc_2.setImageSize(56, 56);
                _loc_2.setInfo(_loc_1);
                ToolKit.clearMcChild(this.img);
                this.img.addChild(_loc_2);
                _loc_3 = ChangeJobControl.getInstance().activeCount;
                _loc_4 = UserObj.getInstance().playerInfo.jobkind;
                _loc_5 = QBaptismStarCfgObj.getInstance().getQBaptismStarInfoById(_loc_4 + "_" + (_loc_3 + 1));
                _loc_6 = _loc_5.q_consume.split("_");
                _loc_7 = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10019", "lang_changejob"), [_loc_6[0]]);
                this.bugNum = int(_loc_6[0]);
                this.txt_des.htmlText = _loc_7;
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
