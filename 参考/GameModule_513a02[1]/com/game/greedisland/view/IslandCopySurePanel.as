package com.game.greedisland.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.greedisland.control.*;
    import com.game.greedisland.model.*;
    import com.game.map.control.*;
    import com.model.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class IslandCopySurePanel extends BaseBox
    {
        private var txt_des:TextField;
        private var closeBtn:BaseButton;
        private var yes_btn:BaseButton;
        private var no_btn:BaseButton;
        private var img:MovieClip;
        private var goodID:int = 600001;
        private var needGold:int = 0;
        private var price:Array;

        public function IslandCopySurePanel()
        {
            this.price = [0, 0, 100, 250, 400];
            loadDisplay("res/islandbox.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("islandEnterSure");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt_des = getDisplayChildByName("txt_des");
            this.img = getDisplayChildByName("img");
            this.yes_btn = new BaseButton(getDisplayChildByName("yes_btn"));
            this.yes_btn.setText(LanguageCfgObj.getInstance().getByIndex("10005", "lang_island"));
            this.no_btn = new BaseButton(getDisplayChildByName("no_btn"));
            this.no_btn.setText(LanguageCfgObj.getInstance().getByIndex("10006", "lang_island"));
            this.yes_btn.addEvtListener(MouseEvent.CLICK, this.__click);
            this.no_btn.addEvtListener(MouseEvent.CLICK, this.__close);
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 8, 5);
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
                    _loc_2 = IslandData.getInstance().getCopyLeftNum();
                    if (_loc_2 == 0)
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10002", "lang_island"));
                    }
                    else
                    {
                        _loc_3 = IslandData.getInstance().hasEnterTime;
                        if (_loc_3 <= 1)
                        {
                            IslandControl.getInstance().reqEnterIslandCopy();
                            close();
                        }
                        else
                        {
                            this.needGold = this.price[_loc_3];
                            if (UserObj.getInstance().playerInfo.gold < this.needGold)
                            {
                                MapControl.getInstance().showRechargeD();
                            }
                            else
                            {
                                IslandControl.getInstance().reqEnterIslandCopy();
                                close();
                            }
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
            var _loc_1:* = ZonesCloneCfg.getInstance().getZonesInfoFromId(Params.ISLAND_COPY_ID);
            var _loc_2:* = IslandData.getInstance().hasEnterTime;
            this.needGold = this.price[_loc_2];
            var _loc_3:* = IslandData.getInstance().getCopyLeftNum();
            var _loc_4:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("10025", "lang_island"), [(_loc_2 + 1), this.needGold]);
            this.txt_des.htmlText = _loc_4;
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

    }
}
