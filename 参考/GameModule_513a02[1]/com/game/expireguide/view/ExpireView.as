package com.game.expireguide.view
{
    import com.cfg.obj.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.clickstream.*;
    import com.game.expireguide.control.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class ExpireView extends BaseBox
    {
        private var goBtn:BaseButton;
        private var closeBtn:BaseButton;
        private var expireImg:MovieClip;
        private var _item:IconItem;
        private var _equip:PropInfo;

        public function ExpireView(param1 = null)
        {
            loadDisplay("res/expire.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("expireView", 60);
            this.initUI();
            super.displayReady();
            if (this._equip)
            {
                this.setInfo(this._equip);
            }
            return;
        }// end function

        private function initUI() : void
        {
            this.goBtn = new BaseButton(getDisplayChildByName("goBtn"));
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this.expireImg = getDisplayChildByName("expireImg") as MovieClip;
            var _loc_1:* = false;
            this.expireImg.mouseEnabled = false;
            this.expireImg.mouseChildren = _loc_1;
            this.goBtn.addEventListener(MouseEvent.CLICK, this.clickHandler);
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.closeHandler);
            return;
        }// end function

        public function setInfo(param1:PropInfo) : void
        {
            var _loc_4:* = 0;
            this._equip = param1;
            if (!UILoaded)
            {
                return;
            }
            if (!this._item)
            {
                this._item = new IconItem("");
                this._item.x = 195;
                this._item.y = 150;
                this._item.setImageSize(56, 56);
                this._item.setWH(56, 56);
            }
            this._item.setInfo(param1);
            var _loc_2:* = MovieClip(display).getChildIndex(this.expireImg);
            display.addChildAt(this._item, _loc_2);
            var _loc_3:* = ShopCfgObj.getInstance().getShopItemBySellId(30001, this._equip.itemModelId);
            if (_loc_3 == null)
            {
                _loc_4 = ProtectCfgObj.instance.getRealKey(this._equip.itemModelId);
                if (_loc_4)
                {
                    _loc_3 = ShopCfgObj.getInstance().getShopItemBySellId(30001, _loc_4);
                }
            }
            this.goBtn.setText("" + (_loc_3 ? (_loc_3.q_gold) : ("null")));
            return;
        }// end function

        private function clickHandler(event:MouseEvent) : void
        {
            ExpireGuideControl.getInstance().reqRenewProtect(this._equip.itemId);
            ClickStream.add(ClickStreamId.CLICK_MengChongXuFei_LijiQianWang);
            return;
        }// end function

        private function closeHandler(event:MouseEvent) : void
        {
            close();
            return;
        }// end function

    }
}
