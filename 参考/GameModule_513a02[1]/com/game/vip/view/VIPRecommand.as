package com.game.vip.view
{
    import com.cfg.obj.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.mall.view.*;
    import com.game.vip.consts.*;
    import com.game.vip.control.*;
    import flash.events.*;

    public class VIPRecommand extends Component
    {
        private var _year:MallItem;
        private var _monthes:MallItem;
        private var _month:MallItem;
        private var _closeBtn:BaseButton;

        public function VIPRecommand()
        {
            super.initComponentUI("vip_recommand");
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._year = new MallItem(getDisplayChildByName("year"));
            this._year.icon.move(0, 0);
            this._monthes = new MallItem(getDisplayChildByName("monthes"));
            this._monthes.icon.move(0, 0);
            this._month = new MallItem(getDisplayChildByName("month"));
            this._month.icon.move(0, 0);
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._year.info = ShopCfgObj.getInstance().getShopItemInfoFromInside(VipConst.YEAR_CARD);
            this._monthes.info = ShopCfgObj.getInstance().getShopItemInfoFromInside(VipConst.MONTHES_CARD);
            this._month.info = ShopCfgObj.getInstance().getShopItemInfoFromInside(VipConst.MONTH_CARD);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            VIPControl.getInstance().closeRecommand();
            return;
        }// end function

    }
}
