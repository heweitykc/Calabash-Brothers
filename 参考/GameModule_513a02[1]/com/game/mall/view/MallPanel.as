package com.game.mall.view
{
    import __AS3__.vec.*;
    import avmplus.*;
    import com.*;
    import com.cfg.obj.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.clickstream.*;
    import com.game.mall.control.*;
    import com.game.mall.model.*;
    import com.game.map.control.*;
    import com.game.shop.model.*;
    import com.model.*;
    import com.view.*;
    import flash.events.*;
    import flash.geom.*;

    public class MallPanel extends BaseBox
    {
        private var _info:ShopItemsInfo;
        private var _infoList:Object;
        private var _tab:Buttons;
        private var _type:String;
        private var _page:PageCounter;
        private var _web:BaseButton;
        private var _goodsBox:Array;
        private var _hotsBox:Array;
        private var _initCompleted:Boolean;
        private var _openIndex:int = 0;
        private var _diamondTab:BaseButton;
        private var _bindDiamondTab:BaseButton;
        private var _generalTab:BaseButton;
        private var _enhanceTab:BaseButton;
        private var _buffTab:BaseButton;
        private var _vipTab:BaseButton;
        private var _curTab:BaseSprite;
        private var _point:Point;
        private var _closeBtn:BaseButton;

        public function MallPanel()
        {
            _peaceBox = ["*"];
            _combinedBox = ["com.game.shop.view::ShopBuyPanel"];
            this._infoList = {};
            loadDisplay("res/mall.swf");
            return;
        }// end function

        public function get openIndex() : int
        {
            return this._openIndex;
        }// end function

        public function set openIndex(param1:int) : void
        {
            this._openIndex = param1;
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get info() : ShopItemsInfo
        {
            return this._info;
        }// end function

        public function addInfo(param1:ShopItemsInfo) : void
        {
            this._infoList[param1.shopModelId] = param1;
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("mallpanel");
            this.initUI();
            this.addListener();
            this.doTabClick();
            if (this._openIndex != 0)
            {
                this.setPage(this._openIndex);
            }
            this.setHot();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._tab = new Buttons();
            this._tab.intervalX = -1;
            this._tab.horizontal = true;
            this._tab.x = getDisplayChildByName("type_1").x;
            this._tab.y = getDisplayChildByName("type_1").y;
            this._generalTab = new BaseButton(getDisplayChildByName("type_1"), true);
            this._enhanceTab = new BaseButton(getDisplayChildByName("type_2"), true);
            this._buffTab = new BaseButton(getDisplayChildByName("type_3"), true);
            this._bindDiamondTab = new BaseButton(getDisplayChildByName("type_4"), true);
            this._vipTab = new BaseButton(getDisplayChildByName("type_5"), true);
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            this._web = new BaseButton(getDisplayChildByName("btn_web"));
            this._tab.add(this._generalTab);
            this._tab.add(this._enhanceTab);
            this._tab.add(this._buffTab);
            this._tab.add(this._bindDiamondTab);
            this._tab.add(this._vipTab);
            this.addVip();
            this._point = new Point(15, 91);
            addChild(this._tab);
            this._page = new PageCounter(getDisplayChildByName("pageCounter"));
            this._goodsBox = new Array();
            var _loc_1:* = 0;
            while (_loc_1 < MallModel.PAGESIZE)
            {
                
                _loc_2 = new MallItem(getDisplayChildByName("good_" + _loc_1));
                this._goodsBox.push(_loc_2);
                _loc_1++;
            }
            this._hotsBox = new Array();
            _loc_1 = 1;
            while (_loc_1 < 6)
            {
                
                _loc_3 = new HotItem(getDisplayChildByName("hot_" + _loc_1));
                this._hotsBox.push(_loc_3);
                _loc_1++;
            }
            this._initCompleted = true;
            return;
        }// end function

        public function get initComplete() : Boolean
        {
            return this._initCompleted;
        }// end function

        public function addVip() : void
        {
            if (VipCfgObj.getInstance().isVIPforMall(UserObj.getInstance().playerInfo.vipid))
            {
                this._vipTab.downType = true;
                this._vipTab.enabled = true;
                this._vipTab.removeEvtListener(MouseEvent.CLICK, this.__clickVip);
            }
            else
            {
                this._vipTab.downType = false;
                this._vipTab.enabled = false;
                this._vipTab.mouseEnabled = true;
                this._vipTab.addEvtListener(MouseEvent.CLICK, this.__clickVip);
            }
            return;
        }// end function

        private function __clickVip(event:MouseEvent) : void
        {
            ClickStream.add(ClickStreamId.CLICK_ShangCheng_VipShangCheng);
            if (!(event.target as BaseButton).enabled)
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10923"));
            }
            return;
        }// end function

        public function doTabClick() : void
        {
            switch(MallModel.getInstance().modelType)
            {
                case MallModel.GENERAL:
                {
                    this._tab.doBtnClick(this._generalTab);
                    break;
                }
                case MallModel.ENHANCE:
                {
                    this._tab.doBtnClick(this._enhanceTab);
                    break;
                }
                case MallModel.BUFF:
                {
                    this._tab.doBtnClick(this._buffTab);
                    break;
                }
                case MallModel.BINDDIAMOND:
                {
                    this._tab.doBtnClick(this._bindDiamondTab);
                    break;
                }
                case MallModel.VIP:
                {
                    this._tab.doBtnClick(this._vipTab);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.doTabClick();
                if (this._openIndex != 0)
                {
                    this.setPage(this._openIndex);
                }
                this._openIndex = 0;
                this.setHot();
            }
            return;
        }// end function

        public function setData(param1:int) : void
        {
            this.setPage(param1);
            return;
        }// end function

        public function setHot() : void
        {
            var _loc_2:* = 0;
            var _loc_1:* = MallControl.getInstance().getHot();
            if (_loc_1 != null)
            {
                if (_loc_1.length > this._hotsBox.length)
                {
                    return;
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_1.length)
                {
                    
                    (this._hotsBox[_loc_2] as HotItem).info = _loc_1[_loc_2];
                    _loc_2++;
                }
                while (_loc_2 < this._hotsBox.length)
                {
                    
                    (this._hotsBox[_loc_2] as HotItem).visible = false;
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function addListener() : void
        {
            this._tab.addEvtListener(Event.CHANGE, this.__tabChange);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._page.addEvtListener(Event.CHANGE, this.__pageChange);
            this._web.addEvtListener(MouseEvent.CLICK, this.__webClick);
            return;
        }// end function

        private function __webClick(event:MouseEvent) : void
        {
            MapControl.getInstance().showRecharge();
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

        private function __pageChange(event:Event) : void
        {
            this.setPage(this._page.curPage);
            return;
        }// end function

        private function setPage(param1:int) : void
        {
            this._page.curPage = param1;
            var _loc_2:* = MallControl.getInstance().getListTotal();
            this._page.pageTotal = _loc_2 % MallModel.PAGESIZE == 0 ? (_loc_2 / MallModel.PAGESIZE) : (_loc_2 / MallModel.PAGESIZE + 1);
            var _loc_3:* = MallControl.getInstance().getList(this._page.curPage);
            if (_loc_3 != null)
            {
                this.setInfo(_loc_3);
            }
            return;
        }// end function

        private function setInfo(param1:Vector.<ShopItemInfo>) : void
        {
            if (param1.length > this._goodsBox.length)
            {
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                (this._goodsBox[_loc_2] as MallItem).info = param1[_loc_2];
                _loc_2++;
            }
            while (_loc_2 < this._goodsBox.length)
            {
                
                (this._goodsBox[_loc_2] as MallItem).visible = false;
                _loc_2++;
            }
            return;
        }// end function

        private function __tabChange(event:Event) : void
        {
            switch(event.target.selectBtn)
            {
                case this._generalTab:
                {
                    MallModel.getInstance().modelType = MallModel.GENERAL;
                    break;
                }
                case this._enhanceTab:
                {
                    MallModel.getInstance().modelType = MallModel.ENHANCE;
                    break;
                }
                case this._buffTab:
                {
                    MallModel.getInstance().modelType = MallModel.BUFF;
                    break;
                }
                case this._bindDiamondTab:
                {
                    MallModel.getInstance().modelType = MallModel.BINDDIAMOND;
                    break;
                }
                case this._vipTab:
                {
                    MallModel.getInstance().modelType = MallModel.VIP;
                    ClickStream.add(ClickStreamId.CLICK_ShangCheng_VipShangCheng);
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.setPage(1);
            return;
        }// end function

    }
}
