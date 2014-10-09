package com.game.auction.view
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.auction.control.*;
    import com.game.auction.events.*;
    import com.game.chat.control.*;
    import com.game.mall.utils.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class BoothItem extends Component
    {
        private var _info:AuctionItemInfo;
        private var _selected:Boolean;
        private var _playerNameTxt:TextField;
        private var _bg:MovieClip;
        private var _index:int = 0;
        private var _icon:IconItem;
        protected const COLOR_NORMAL:uint = 16766079;
        protected const COLOR_SELECT:uint = 65532;
        private var _selectIndex:int;
        private var _totalpriceTxt:TextField;
        private var _iconSingle:Bitmap;
        private var _iconTotal:Bitmap;
        private var _countTxt:TextField;
        private var _itemNameTxt:TextField;
        private var _singlePriceTxt:TextField;
        private var _score:EquipScoreIcon;
        private var _priTimer:int;
        private var _buyBtn:BaseButton;

        public function BoothItem(param1:String = "stallsSelectItem")
        {
            super.initComponentUI(param1);
            this.initUI();
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__out);
            addEvtListener(MouseEvent.CLICK, this.__click);
            this._buyBtn.addEvtListener(MouseEvent.CLICK, this.__buyClick);
            return;
        }// end function

        public function get selectIndex() : int
        {
            return this._selectIndex;
        }// end function

        public function set selectIndex(param1:int) : void
        {
            this._selectIndex = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        private function initUI() : void
        {
            this._totalpriceTxt = getDisplayChildByName("txt_totalprice");
            this._singlePriceTxt = getDisplayChildByName("txt_singleprice");
            this._playerNameTxt = getDisplayChildByName("txt_name");
            this._itemNameTxt = getDisplayChildByName("txt_itemname");
            this._countTxt = getDisplayChildByName("txt_count");
            this._buyBtn = new BaseButton(getDisplayChildByName("btn_buy"));
            this._buyBtn.setText(LanguageCfgObj.getInstance().getByIndex("10266"));
            this._bg = getDisplayChildByName("bg");
            this._icon = new IconItem();
            this._icon.setImageSize(56, 56);
            this._icon.setImageXY(5, 5);
            this._icon.move(5, 7);
            this._icon.setCountTxtXY(66 - 10, 66 - 20);
            this._iconSingle = IconUtil.getIcon(CostType.GOLD);
            this._iconSingle.x = this._singlePriceTxt.x - this._iconSingle.width - 4;
            this._iconSingle.y = this._singlePriceTxt.y;
            addChild(this._iconSingle);
            this._iconTotal = IconUtil.getIcon(CostType.GOLD);
            this._iconTotal.x = this._totalpriceTxt.x - this._iconTotal.width - 4;
            this._iconTotal.y = this._totalpriceTxt.y;
            addChild(this._iconSingle);
            addChild(this._iconTotal);
            addChild(this._icon);
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        private function __buyClick(event:MouseEvent) : void
        {
            AuctionControl.getInstance().openBuyStallsInfo(this._info);
            return;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            if (param1)
            {
                this._bg.gotoAndStop(4);
                this.setTextColor(this.COLOR_SELECT);
            }
            else
            {
                if (this._bg)
                {
                    this._bg.gotoAndStop(this._selectIndex % 2 == 0 ? (1) : (2));
                }
                this.setTextColor(this.COLOR_NORMAL);
            }
            return;
        }// end function

        public function get info() : AuctionItemInfo
        {
            return this._info;
        }// end function

        public function set info(param1:AuctionItemInfo) : void
        {
            this._info = param1;
            this.update();
            return;
        }// end function

        protected function setBackFrame(param1:int) : void
        {
            if (this._bg)
            {
                this._bg.gotoAndStop(param1);
            }
            return;
        }// end function

        private function update() : void
        {
            this.setBackFrame(this._selectIndex % 2 == 0 ? (1) : (2));
            this._totalpriceTxt.text = ToolKit.getMoneyString(this._info.price);
            if (this._info.unitprice < 1)
            {
                this._singlePriceTxt.text = "< 1";
            }
            else
            {
                this._singlePriceTxt.text = ToolKit.getMoneyString(this._info.unitprice);
            }
            this._itemNameTxt.htmlText = PropUtil.getHtmlTxt(this._info.item);
            if (this._info.item is EquipmentInfo)
            {
                this._countTxt.visible = false;
                if (this._score == null)
                {
                    this._score = new EquipScoreIcon();
                }
                this._score.y = this._countTxt.y;
                this._score.x = this._countTxt.x;
                this._score.info = this._info.item as EquipmentInfo;
                this._icon.setInfo(this._info.item);
                addChild(this._score);
            }
            else
            {
                ToolKit.disappear(this._score);
                if (this._info.item.itemModelId < 0)
                {
                    this._countTxt.visible = true;
                    this._countTxt.text = this._info.item.num.toString();
                    this._icon.countNull = true;
                    this._icon.setInfo(this._info.item);
                }
                else
                {
                    this._icon.countNull = false;
                    this._icon.setInfo(this._info.item);
                    this._countTxt.visible = false;
                }
            }
            this._buyBtn.visible = this._info.playerid.equal(UserObj.getInstance().playerInfo.personId) ? (false) : (true);
            this._playerNameTxt.addEventListener(TextEvent.LINK, this.__link);
            if (!this._info.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._playerNameTxt.htmlText = "<u><a href=\'event:user|" + this._info.playername + "|" + this._info.playerid + "\'>" + this.getPlayerName(this._info.playername) + "</a></u>";
            }
            else
            {
                this._playerNameTxt.htmlText = LanguageCfgObj.getInstance().getByIndex("10267");
            }
            return;
        }// end function

        private function __link(event:TextEvent) : void
        {
            TextLinkControl.getInstance().doLink(event.text);
            return;
        }// end function

        private function getPlayerName(param1:String) : String
        {
            var _loc_2:* = param1.indexOf("]");
            return param1.substr((_loc_2 + 1));
        }// end function

        public function clear() : void
        {
            this._playerNameTxt.text = "";
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (!this._selected)
            {
                this.over();
            }
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            if (!this._selected)
            {
                this.out();
            }
            return;
        }// end function

        private function over() : void
        {
            this._bg.gotoAndStop(3);
            this.setTextColor(this.COLOR_SELECT);
            return;
        }// end function

        private function out() : void
        {
            if (this._bg)
            {
                this._bg.gotoAndStop(this._selectIndex % 2 == 0 ? (1) : (2));
            }
            this.setTextColor(this.COLOR_NORMAL);
            return;
        }// end function

        protected function singleClick() : void
        {
            if (this._info == null)
            {
                return;
            }
            dispatchEvent(new StallsEvent(StallsEvent.SELECTED, this, true));
            return;
        }// end function

        protected function setTextColor(param1:uint) : void
        {
            this._playerNameTxt.textColor = param1;
            return;
        }// end function

        protected function doDoubleClick() : void
        {
            if (this._info == null)
            {
                return;
            }
            if (this._info.playerid.equal(UserObj.getInstance().playerInfo.personId))
            {
                return;
            }
            AuctionControl.getInstance().openBuyStallsInfo(this._info);
            return;
        }// end function

        protected function __click(event:MouseEvent) : void
        {
            var _loc_2:* = getTimer();
            if (_loc_2 - this._priTimer < 300)
            {
                this.doDoubleClick();
                this._priTimer = 0;
            }
            else
            {
                this.singleClick();
                this._priTimer = _loc_2;
            }
            return;
        }// end function

    }
}
